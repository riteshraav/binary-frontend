// customer_summary_report_window.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import 'package:windows_sample/model/customer_model.dart';
import 'package:windows_sample/model/deduction.dart';
import 'package:windows_sample/model/milk_collection_model.dart';
import 'package:windows_sample/model/opening_balance_model.dart';
import 'package:windows_sample/service/customer_service.dart';
import 'package:windows_sample/service/deduction_service.dart';
import 'package:windows_sample/service/milk_collection_service.dart';
import 'package:windows_sample/service/opening_balance_service.dart';
import '../pdf_generation/pdf_api.dart';
import '../riverpod/providers.dart';

// Keep the CustomerSummary class here
class CustomerSummary {
  final String code;
  final String name;
  final String milkType;
  final double totalMilk;
  final double totalValue;
  final double totalDeduction;
  final double netPayment;
  final Map<String, double> deductions;

  CustomerSummary({
    required this.code,
    required this.name,
    required this.milkType,
    required this.totalMilk,
    required this.totalValue,
    required this.totalDeduction,
    required this.netPayment,
    required this.deductions,
  });
}

// PDF Generation class within the same file
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
    // Load Devanagari fonts (STATIC, SUPPORTED)
    final regularFontData = await rootBundle.load(
      'assets/font/NotoSansDevanagari-Regular.ttf',
    );

    final boldFontData = await rootBundle.load(
      'assets/font/NotoSansDevanagari-Bold.ttf',
    );

    // Create PDF font instances
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
      ttf: fontRegular,      // ✅ FIXED
      ttfBold: fontBold,     // ✅ FIXED
    );
  }


  Future<pw.Document> generate() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.applyMargin(
          left: 20,
          right: 20,
          top: 40,
          bottom: 40,
        ),
        header: (context) => _buildHeader(),
        footer: (context) => _buildFooter(context),
        build: (context) => [
          _buildReportInfo(),
          pw.SizedBox(height: 20),
          _buildSummaryTable(),
          pw.SizedBox(height: 20),
          _buildGrandTotals(),
        ],
      ),
    );

    return pdf;
  }

  pw.Widget _buildHeader() {
    return pw.Column(
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Text(
              'भावेश्वरी डेअरी',
              style: pw.TextStyle(
                font: ttfBold,
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 4),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Text(
              'ग्राहक सारांश रिपोर्ट',
              style: pw.TextStyle(
                font: ttf,
                fontSize: 16,
              ),
            ),
          ],
        ),
        pw.Divider(thickness: 1),
      ],
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Container(
      alignment: pw.Alignment.centerRight,
      margin: const pw.EdgeInsets.only(top: 20),
      child: pw.Column(
        children: [
          pw.Divider(thickness: 0.5),
          pw.SizedBox(height: 4),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'Page ${context.pageNumber} of ${context.pagesCount}',
                style: pw.TextStyle(fontSize: 10, font: ttf),
              ),
              pw.Text(
                'तयार केले: ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now())}',
                style: pw.TextStyle(fontSize: 10, font: ttf),
              ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _buildReportInfo() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'रिपोर्ट कालावधी:',
                  style: pw.TextStyle(font: ttf, fontSize: 12),
                ),
                pw.Text(
                  '${DateFormat('dd/MM/yyyy').format(fromDate)} - ${DateFormat('dd/MM/yyyy').format(toDate)}',
                  style: pw.TextStyle(font: ttfBold, fontSize: 12),
                ),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'दुध प्रकार:',
                  style: pw.TextStyle(font: ttf, fontSize: 12),
                ),
                pw.Text(
                  milkType,
                  style: pw.TextStyle(font: ttfBold, fontSize: 12),
                ),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'रिपोर्ट प्रकार:',
                  style: pw.TextStyle(font: ttf, fontSize: 12),
                ),
                pw.Text(
                  reportType == 'सर्व' ? 'सर्व ग्राहक' : 'ठराविक ग्राहक',
                  style: pw.TextStyle(font: ttfBold, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'एकूण ग्राहक: ${summaryList.length}',
              style: pw.TextStyle(font: ttf, fontSize: 12),
            ),
            pw.Text(
              'तारीख: ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
              style: pw.TextStyle(font: ttf, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildSummaryTable() {
    return pw.Table.fromTextArray(
      border: pw.TableBorder.all(width: 0.5),
      headerStyle: pw.TextStyle(
        font: ttfBold,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
      cellStyle: pw.TextStyle(font: ttf, fontSize: 9),
      cellAlignment: pw.Alignment.center,
      columnWidths: {
        0: const pw.FlexColumnWidth(0.8), // Code
        1: const pw.FlexColumnWidth(2.5), // Name
        2: const pw.FlexColumnWidth(1.2), // Milk Type
        3: const pw.FlexColumnWidth(1.2), // Milk Qty
        4: const pw.FlexColumnWidth(1.2), // Total Value
        5: const pw.FlexColumnWidth(1.2), // Deduction
        6: const pw.FlexColumnWidth(1.5), // Net Payment
      },
      headers: [
        'कोड',
        'नाव',
        'दुध प्रकार',
        'दूध (लि)',
        'किंमत (₹)',
        'कपात (₹)',
        'निव्वळ देय (₹)',
      ],
      data: summaryList.map((summary) {
        return [
          summary.code,
          summary.name,
          summary.milkType,
          summary.totalMilk.toStringAsFixed(2),
          summary.totalValue.toStringAsFixed(2),
          summary.totalDeduction.toStringAsFixed(2),
          summary.netPayment.toStringAsFixed(2),
        ];
      }).toList(),
    );
  }

  pw.Widget _buildGrandTotals() {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 1),
        borderRadius: pw.BorderRadius.circular(5),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            'एकूण सारांश',
            style: pw.TextStyle(
              font: ttfBold,
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
            children: [
              _buildTotalCard('एकूण दूध', '${grandTotalMilk.toStringAsFixed(2)} लि'),
              _buildTotalCard('एकूण किंमत', '₹${grandTotalValue.toStringAsFixed(2)}'),
              _buildTotalCard('एकूण कपात', '₹${grandTotalDeduction.toStringAsFixed(2)}'),
              _buildTotalCard('एकूण देय', '₹${grandNetPayment.toStringAsFixed(2)}'),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _buildTotalCard(String title, String value) {
    return pw.Container(
      width: 120,
      padding: const pw.EdgeInsets.all(8),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 0.5),
        borderRadius: pw.BorderRadius.circular(4),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              font: ttf,
              fontSize: 9,
              color: PdfColors.grey700,
            ),
            textAlign: pw.TextAlign.center,
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            value,
            style: pw.TextStyle(
              font: ttfBold,
              fontSize: 11,
              fontWeight: pw.FontWeight.bold,
            ),
            textAlign: pw.TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class CustomerSummaryReportWindow extends ConsumerStatefulWidget {
  const CustomerSummaryReportWindow({Key? key}) : super(key: key);

  @override
  ConsumerState<CustomerSummaryReportWindow> createState() => _CustomerSummaryReportWindowState();
}

class _CustomerSummaryReportWindowState extends ConsumerState<CustomerSummaryReportWindow> {
  bool isLoading = false;
  String? selectedCustomerCode;
  DateTime fromDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime toDate = DateTime.now();
  List<CustomerMaster> customerList = [];
  String adminId = "1";

  // Milk type selection
  String selectedMilkType = 'एकत्र'; // गाय, म्हैस, एकत्र
  String selectedPrintType = "सर्व";

  // Data
  List<CustomerSummary> summaryList = [];
  List<Deduction> deductionTypes = [];

  // Services
  late CustomerService customerService;
  late MilkCollectionService milkCollectionService;
  late DeductionServiceImpl deductionService;
  late OpeningBalanceService openingBalanceService;

  // Totals
  double grandTotalMilk = 0;
  double grandTotalValue = 0;
  double grandTotalDeduction = 0;
  double grandNetPayment = 0;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  String _currentDate() {
    return DateFormat('dd-MM-yyyy').format(DateTime.now());
  }

  Future<void> _initializeData() async {
    print("Initializing Customer Summary Report...");

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print("PostFrameCallback running...");
      try {
        await _loadData();
      } catch (e, st) {
        print("Error in loadData: $e");
        print(st);
      } finally {
        if (mounted) {
          setState(() => isLoading = false);
        }
      }
    });
  }

  Future<void> _loadData() async {
    // Initialize services
    customerService = ref.read(customerServiceProvider);
    milkCollectionService = ref.read(milkCollectionProvider);
    deductionService = ref.read(deductionProvider);
    openingBalanceService = ref.read(openingBalanceProvider);

    // Load all data
    customerList = await customerService.fetchAllCustomers(adminId);
    customerList.sort((a, b) => int.parse(a.code).compareTo(int.parse(b.code)));

    deductionTypes = await deductionService.fetchAllDeductions(sortByPriority: true);

    setState(() {});
  }

  Future<void> _generateReport() async {
    setState(() {
      isLoading = true;
      summaryList.clear();
      grandTotalMilk = 0;
      grandTotalValue = 0;
      grandTotalDeduction = 0;
      grandNetPayment = 0;
    });

    try {
      // Generate report for all customers or selected customer
      final customersToProcess = selectedCustomerCode != null
          ? customerList.where((c) => c.code == selectedCustomerCode).toList()
          : customerList;

      summaryList = await _generateSummariesForCustomers(customersToProcess);

      // Calculate grand totals
      _calculateGrandTotals();

      _showSuccess("रिपोर्ट तयार झाली");
    } catch (e) {
      _showError("रिपोर्ट तयार करताना त्रुटी: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<List<CustomerSummary>> _generateSummariesForCustomers(List<CustomerMaster> customers) async {
    final List<CustomerSummary> summaries = [];

    for (var customer in customers) {
      // Filter by milk type
      final customerMilkType = customer.milkType;
      if (customerMilkType == 'cow' && selectedMilkType == 'म्हैस') continue;
      if (customerMilkType == 'buffalo' && selectedMilkType == 'गाय') continue;

      final summary = await _generateCustomerSummary(customer);
      if (summary.totalMilk > 0 || summary.totalValue > 0) {
        summaries.add(summary);
      }
    }

    return summaries;
  }

  Future<CustomerSummary> _generateCustomerSummary(CustomerMaster customer) async {
    double totalMilk = 0;
    double totalValue = 0;
    Map<String, double> deductions = {};
    double totalDeduction = 0;

    // Get milk collections based on selected milk type
    if (selectedMilkType == 'एकत्र' || selectedMilkType == 'गाय') {
      final cowCollections = await _getMilkCollections(customer.code, 0);
      totalMilk += _sumMilkQuantity(cowCollections);
      totalValue += _sumMilkAmount(cowCollections);
    }

    if (selectedMilkType == 'एकत्र' || selectedMilkType == 'म्हैस') {
      final buffaloCollections = await _getMilkCollections(customer.code, 1);
      totalMilk += _sumMilkQuantity(buffaloCollections);
      totalValue += _sumMilkAmount(buffaloCollections);
    }

    // Get deductions
    final balances = await openingBalanceService.findBalance(customer.code);
    if (balances != null && balances.isNotEmpty) {
      for (var balance in balances) {
        final deductionType = deductionTypes.firstWhere(
              (d) => d.code == balance.deductionCode,
          orElse: () => Deduction(
            name: 'Unknown',
            code: balance.deductionCode,
            vasuliType: '',
            aakarani: '',
            rate: 0,
            priority: 0,
            rounding: false,
            milkat: false,
            kapatLock: false,
          ),
        );

        // Use opening balance as deduction amount
        deductions[deductionType.name] = balance.openingBalance;
        totalDeduction += balance.openingBalance;
      }
    }

    final netPayment = totalValue - totalDeduction;

    return CustomerSummary(
      code: customer.code,
      name: customer.name,
      milkType: _getMilkTypeDisplay(customer.milkType),
      totalMilk: totalMilk,
      totalValue: totalValue,
      totalDeduction: totalDeduction,
      netPayment: netPayment,
      deductions: deductions,
    );
  }

  Future<List<MilkCollectionModel>> _getMilkCollections(String customerCode, int milkType) async {
    try {
      final collections = await milkCollectionService.getCollectionsBetweenAndByAdminIdAndCustomerAndMilkType(
        customerCode,
        milkType,
        fromDate,
        toDate,
        adminId,
      );
      return collections;
    } catch (e) {
      print("Error fetching milk collections: $e");
      return [];
    }
  }

  double _sumMilkQuantity(List<MilkCollectionModel> collections) {
    return collections.fold(0.0, (sum, collection) => sum + collection.quantity);
  }

  double _sumMilkAmount(List<MilkCollectionModel> collections) {
    return collections.fold(0.0, (sum, collection) => sum + collection.amount);
  }

  void _calculateGrandTotals() {
    grandTotalMilk = 0;
    grandTotalValue = 0;
    grandTotalDeduction = 0;
    grandNetPayment = 0;

    for (var summary in summaryList) {
      grandTotalMilk += summary.totalMilk;
      grandTotalValue += summary.totalValue;
      grandTotalDeduction += summary.totalDeduction;
      grandNetPayment += summary.netPayment;
    }
  }

  String _getMilkTypeDisplay(String milkType) {
    switch (milkType) {
      case 'cow': return 'गाय';
      case 'buffalo': return 'म्हैस';
      case 'mixed': return 'एकत्र';
      default: return milkType;
    }
  }

  // PDF Generation Function
  Future<void> _printReport() async {
    if (summaryList.isEmpty) {
      _showError("कृपया प्रथम रिपोर्ट तयार करा");
      return;
    }

    setState(() => isLoading = true);

    try {
      // Generate PDF using the integrated class
      final pdfApi = await CustomerSummaryPdfApi.create(
        summaryList: summaryList,
        fromDate: fromDate,
        toDate: toDate,
        milkType: selectedMilkType,
        reportType: selectedPrintType,
        grandTotalMilk: grandTotalMilk,
        grandTotalValue: grandTotalValue,
        grandTotalDeduction: grandTotalDeduction,
        grandNetPayment: grandNetPayment,
      );

      final pdfDocument = await pdfApi.generate();

      // Save and open PDF
      final file = await PdfApi.saveDocument(
        name: "ग्राहक_सारांश_${DateTime.now().millisecondsSinceEpoch}.pdf",
        pdf: pdfDocument,
      );

      await PdfApi.openFile(file);

      _showSuccess("PDF रिपोर्ट यशस्वीरित्या तयार झाली");
    } catch (e) {
      _showError("PDF तयार करताना त्रुटी: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFromDate ? fromDate : toDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2563EB),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
          ),
        ),
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _buildMainContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.all(18),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.summarize, color: Colors.white, size: 28),
          const SizedBox(width: 12),
          const SelectableText(
            'ग्राहक सारांश रिपोर्ट',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.schedule, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                SelectableText(
                  'दिनांक: ${_currentDate()}',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 0, 18, 18),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left section - Milk Type and Filters
              _buildLeftSection(),

              // Right section - Date Selection and Action Buttons
              _buildRightSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeftSection() {
    return Container(
      width: 320,
      child: Column(
        children: [
          _buildMilkTypeSection(),
          const SizedBox(height: 16),
          _buildCustomerSelectionSection(),
        ],
      ),
    );
  }

  Widget _buildMilkTypeSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'दुधाचा प्रकार',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Radio<String>(
                value: 'गाय',
                groupValue: selectedMilkType,
                onChanged: (value) {
                  setState(() {
                    selectedMilkType = value!;
                  });
                },
                activeColor: const Color(0xFF2563EB),
              ),
              const Text(
                'गाय',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Row(
            children: [
              Radio<String>(
                value: 'म्हैस',
                groupValue: selectedMilkType,
                onChanged: (value) {
                  setState(() {
                    selectedMilkType = value!;
                  });
                },
                activeColor: const Color(0xFF2563EB),
              ),
              const Text(
                'म्हैस',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Row(
            children: [
              Radio<String>(
                value: 'एकत्र',
                groupValue: selectedMilkType,
                onChanged: (value) {
                  setState(() {
                    selectedMilkType = value!;
                  });
                },
                activeColor: const Color(0xFF2563EB),
              ),
              const Text(
                'एकत्र',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerSelectionSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Radio<String>(
                value: 'सर्व',
                groupValue: selectedPrintType,
                onChanged: (value) {
                  setState(() {
                    selectedPrintType = value!;
                  });
                },
                activeColor: const Color(0xFF2563EB),
              ),
              const Text(
                'सर्व ग्राहक',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Row(
            children: [
              Radio<String>(
                value: 'ठराविक ग्राहक',
                groupValue: selectedPrintType,
                onChanged: (value) {
                  setState(() {
                    selectedPrintType = value!;
                  });
                },
                activeColor: const Color(0xFF2563EB),
              ),
              const Text(
                'ठराविक ग्राहक',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          if (selectedPrintType == 'ठराविक ग्राहक')
            Container(
              margin: const EdgeInsets.only(top: 12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: selectedCustomerCode,
                  onChanged: (value) {
                    setState(() {
                      selectedCustomerCode = value;
                    });
                  },
                  isExpanded: true,
                  underline: const SizedBox(),
                  hint: const Text('ग्राहक निवडा'),
                  items: [
                    ...customerList.map((customer) => DropdownMenuItem<String>(
                      value: customer.code,
                      child: Text('${customer.code}: ${customer.name}'),
                    )).toList(),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRightSection() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Date Selection
            Row(
              children: [
                Expanded(child: _buildDateField('प्रारंभ', fromDate, true)),
                const SizedBox(width: 16),
                Expanded(child: _buildDateField('पर्यंत', toDate, false)),
              ],
            ),

            const SizedBox(height: 24),

            // Action Buttons
            _buildActionButtons(),

            const SizedBox(height: 24),

            // Report Summary
            if (summaryList.isNotEmpty) _buildReportSummary(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField(String label, DateTime date, bool isFromDate) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () => _selectDate(context, isFromDate),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('dd.MM.yyyy').format(date),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton('PDF तयार करा', Icons.picture_as_pdf, Colors.blue, _printReport),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionButton('रिपोर्ट तयार करा', Icons.summarize, Colors.green, _generateReport),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStopButton(),
        ),
      ],
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color, VoidCallback action) {
    return ElevatedButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: color,
        elevation: 2,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildStopButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.red,
        elevation: 2,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'STOP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'बंद करा',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildReportSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'रिपोर्ट सारांश',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 12),

          // Summary Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            childAspectRatio: 2.5,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildSummaryCard('एकूण ग्राहक', '${summaryList.length}', Icons.people, Colors.blue),
              _buildSummaryCard('एकूण दूध', '${grandTotalMilk.toStringAsFixed(2)} लि', Icons.local_drink, Colors.green),
              _buildSummaryCard('एकूण किंमत', '₹${grandTotalValue.toStringAsFixed(2)}', Icons.currency_rupee, Colors.orange),
              _buildSummaryCard('एकूण कपात', '₹${grandTotalDeduction.toStringAsFixed(2)}', Icons.money_off, Colors.red),
              _buildSummaryCard('एकूण देय', '₹${grandNetPayment.toStringAsFixed(2)}', Icons.payments, Colors.purple),
              _buildSummaryCard('कालावधी', '${DateFormat('dd/MM/yyyy').format(fromDate)}\nते\n${DateFormat('dd/MM/yyyy').format(toDate)}', Icons.calendar_today, Colors.teal),
              _buildSummaryCard('दुध प्रकार', selectedMilkType, Icons.category, Colors.indigo),
              _buildSummaryCard('रिपोर्ट प्रकार', selectedPrintType == 'सर्व' ? 'सर्व ग्राहक' : 'ठराविक ग्राहक', Icons.description, Colors.brown),
            ],
          ),

          const SizedBox(height: 16),

          // PDF Generation Button
          if (summaryList.isNotEmpty)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _printReport,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.picture_as_pdf, size: 20),
                label: const Text('PDF तयार करा', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}