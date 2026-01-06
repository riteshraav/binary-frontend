import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:windows_sample/model/customer_summary_model.dart';

class CustomerSummaryPdfApi {
  final List<CustomerSummary> summaryList;
  final DateTime fromDate;
  final DateTime toDate;
  final String milkType;
  final String reportType;
  final double grandTotalMilk;
  final double grandTotalValue;
  final double grandTotalDeduction;
  final double grandNetPayment;
  final pw.Font ttf;
  final pw.Font ttfBold;

  CustomerSummaryPdfApi._({
    required this.summaryList,
    required this.fromDate,
    required this.toDate,
    required this.milkType,
    required this.reportType,
    required this.grandTotalMilk,
    required this.grandTotalValue,
    required this.grandTotalDeduction,
    required this.grandNetPayment,
    required this.ttf,
    required this.ttfBold,
  });

  // =========================
  // 🔴 MARATHI NORMALIZATION
  // =========================
  String normalizeMarathi(String text) {
    return text
        .replaceAll('दुध', 'दूध')
        .replaceAll('निव्वळ', 'निव्वळ')
        .replaceAll('कपात', 'कपात')
        .replaceAll('देय', 'देय')
        .replaceAll('दुध प्रकार', 'दूध प्रकार')
        .replaceAll('एकूण दुध', 'एकूण दूध');
  }

  static Future<CustomerSummaryPdfApi> create({
    required List<CustomerSummary> summaryList,
    required DateTime fromDate,
    required DateTime toDate,
    required String milkType,
    required String reportType,
    required double grandTotalMilk,
    required double grandTotalValue,
    required double grandTotalDeduction,
    required double grandNetPayment,
  }) async {
    final regularFontData = await rootBundle.load(
      'assets/font/NotoSansDevanagari-Regular.ttf',
    );
    final boldFontData = await rootBundle.load(
      'assets/font/NotoSansDevanagari-Bold.ttf',
    );

    final pw.Font fontRegular = pw.Font.ttf(regularFontData);
    final pw.Font fontBold = pw.Font.ttf(boldFontData);

    return CustomerSummaryPdfApi._(
      summaryList: summaryList,
      fromDate: fromDate,
      toDate: toDate,
      milkType: milkType,
      reportType: reportType,
      grandTotalMilk: grandTotalMilk,
      grandTotalValue: grandTotalValue,
      grandTotalDeduction: grandTotalDeduction,
      grandNetPayment: grandNetPayment,
      ttf: fontRegular,
      ttfBold: fontBold,
    );
  }

  Future<pw.Document> generate() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        header: (context) => _buildHeader(),
        footer: (context) => _buildFooter(context),
        build: (context) => [
          _buildReportInfo(),
          pw.SizedBox(height: 15),
          _buildSummaryTable(),
        ],
      ),
    );

    return pdf;
  }

  pw.Widget _buildHeader() {
    return pw.Column(
      children: [
        pw.Text(
          normalizeMarathi('भावेश्वरी डेअरी'),
          style: pw.TextStyle(font: ttfBold, fontSize: 20),
        ),
        pw.Text(
          normalizeMarathi('ग्राहक सारांश रिपोर्ट'),
          style: pw.TextStyle(font: ttf, fontSize: 15),
        ),
        pw.Divider(),
      ],
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          'Page ${context.pageNumber} of ${context.pagesCount}',
          style: pw.TextStyle(font: ttf, fontSize: 9),
        ),
        pw.Text(
          normalizeMarathi(
            'तयार केले: ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now())}',
          ),
          style: pw.TextStyle(font: ttf, fontSize: 9),
        ),
      ],
    );
  }

  pw.Widget _buildReportInfo() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          normalizeMarathi(
            'रिपोर्ट कालावधी: ${DateFormat('dd/MM/yyyy').format(fromDate)} - ${DateFormat('dd/MM/yyyy').format(toDate)}',
          ),
          style: pw.TextStyle(font: ttf, fontSize: 11),
        ),
        pw.Text(
          normalizeMarathi('दूध प्रकार: $milkType'),
          style: pw.TextStyle(font: ttf, fontSize: 11),
        ),
        pw.Text(
          normalizeMarathi(
            'रिपोर्ट प्रकार: ${reportType == 'सर्व' ? 'सर्व ग्राहक' : 'ठराविक ग्राहक'}',
          ),
          style: pw.TextStyle(font: ttf, fontSize: 11),
        ),
      ],
    );
  }

  pw.Widget _buildSummaryTable() {
    return pw.Table.fromTextArray(
      border: pw.TableBorder.all(width: 0.5),
      headerStyle: pw.TextStyle(font: ttfBold, fontSize: 9),
      cellStyle: pw.TextStyle(font: ttf, fontSize: 9),
      headers: [
        normalizeMarathi('कोड'),
        normalizeMarathi('नाव'),
        normalizeMarathi('दूध प्रकार'),
        normalizeMarathi('दूध (लि)'),
        normalizeMarathi('किंमत (₹)'),
        normalizeMarathi('कपात (₹)'),
        normalizeMarathi('निव्वळ देय (₹)'),
      ],
      data: summaryList.map((s) {
        return [
          s.code,
          normalizeMarathi(s.name ?? '-'),
          normalizeMarathi(s.milkType ?? '-'),
          s.totalMilk.toStringAsFixed(2),
          s.totalValue.toStringAsFixed(2),
          s.totalDeduction.toStringAsFixed(2),
          s.netPayment.toStringAsFixed(2),
        ];
      }).toList(),
    );
  }
}
