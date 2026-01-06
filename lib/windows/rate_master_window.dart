import 'dart:io';
import 'package:excel/excel.dart' hide Border;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

/// RateMasterWindow - robust parser for BOTH:
///  1) Matrix layout (Fat/SNF header: first cell "Fat/SNF", SNF headers on row1, fats down col1)
///  2) Row layout (each row: Fat, SNF, Rate) with optional header row
///
/// Drop this file into lib/windows/rate_master_window.dart and run a full restart.
class RateMasterWindow extends StatefulWidget {
  const RateMasterWindow({super.key});

  @override
  State<RateMasterWindow> createState() => _RateMasterWindowState();
}

class _RateMasterWindowState extends State<RateMasterWindow> {
  final List<String> _types = const ['Cow', 'Buffalo'];
  String _selectedType = 'Cow';

  final Map<String, _RateSet> _store = {
    'Cow': _RateSet(),
    'Buffalo': _RateSet(),
  };

  _RateSet get _current => _store[_selectedType]!;

  // ---- Header UI ----
  Widget _header() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF1E40AF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Row(
        children: [
          const Text('Rate Master', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(color: Colors.white.withOpacity(.12), borderRadius: BorderRadius.circular(10)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedType,
                dropdownColor: const Color(0xFF1E3A8A),
                style: const TextStyle(color: Colors.white, fontSize: 14),
                iconEnabledColor: Colors.white,
                items: _types.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                onChanged: (v) {
                  if (v == null) return;
                  setState(() => _selectedType = v);
                },
              ),
            ),
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: _pickExcelForCurrentType,
            icon: const Icon(Icons.upload_file),
            label: const Text('Upload Excel'),
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xFF1E40AF),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }

  // ---- Metric card UI ----
  Widget _metricCard(String label, double? value) {
    return Expanded(
      child: Container(
        height: 92,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE5E7EB))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
          const Spacer(),
          Text(value == null ? '-' : value.toStringAsFixed(2), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
        ]),
      ),
    );
  }

  Widget _metricsGrid(_RateSet rs) {
    return Column(children: [
      Row(children: [_metricCard('Min Fat', rs.minFat), _metricCard('Max Fat', rs.maxFat)]),
      Row(children: [_metricCard('Min SNF', rs.minSnf), _metricCard('Max SNF', rs.maxSnf)]),
      Row(children: [_metricCard('Min Rate', rs.minRate), _metricCard('Max Rate', rs.maxRate)]),
    ]);
  }

  // ---- Action buttons and file name ----
  Widget _actions(_RateSet rs) {
    return Column(children: [
      if (rs.filePath != null) Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: Text('Uploaded: ${rs.filePath!.split(Platform.pathSeparator).last}', style: const TextStyle(color: Colors.black54))),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          FilledButton.tonal(
            onPressed: rs.rows.isEmpty ? null : () => _openViewer(rs),
            child: const Text('View'),
          ),
          const SizedBox(width: 12),
          FilledButton.tonal(onPressed: rs.rows.isEmpty ? null : () => _deleteForCurrentType(), child: const Text('Delete')),
          const SizedBox(width: 12),
          FilledButton.tonal(onPressed: rs.rows.isEmpty ? null : () => _toast('Edit: delete & re-upload'), child: const Text('Edit')),
        ]),
      ),
    ]);
  }

  // ---- File picker + parse ----
  Future<void> _pickExcelForCurrentType() async {
    if (_current.filePath != null) {
      _toast('Excel already uploaded for $_selectedType. Delete it to re-upload.');
      return;
    }

    final res = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['xlsx', 'xls']);
    if (res == null || res.files.single.path == null) return;

    final file = File(res.files.single.path!);
    try {
      final parsed = await _parseExcel(file);
      if (parsed.isEmpty) {
        _toast('No valid rows found. The sheet layout may be different; see console for debug.');
        return;
      }

      final fats = parsed.map((r) => r[0] as double).toList();
      final snfs = parsed.map((r) => r[1] as double).toList();
      final rates = parsed.map((r) => r[2] as double).toList();

      setState(() {
        _current.filePath = file.path;
        _current.rows = parsed;
        _current
          ..minFat = fats.reduce((a, b) => a < b ? a : b)
          ..maxFat = fats.reduce((a, b) => a > b ? a : b)
          ..minSnf = snfs.reduce((a, b) => a < b ? a : b)
          ..maxSnf = snfs.reduce((a, b) => a > b ? a : b)
          ..minRate = rates.reduce((a, b) => a < b ? a : b)
          ..maxRate = rates.reduce((a, b) => a > b ? a : b);
      });

      _toast('Parsed ${parsed.length} rows for $_selectedType');
    } catch (e, st) {
      debugPrint('Parse error: $e\n$st');
      _toast('Failed to read Excel: $e');
    }
  }

  /// Robust parser:
  /// - Detects matrix format: first cell contains 'fat' or 'fat/snf' and following cells in top row are SNF headers.
  ///   Then each next row has fat in first column and rates across columns → convert matrix to rows [fat, snf, rate].
  /// - Else falls back to row format: each row is (fat,snf,rate) (skips header if non-numeric first cell).
  Future<List<List<dynamic>>> _parseExcel(File file) async {
    final bytes = await file.readAsBytes();
    final excel = Excel.decodeBytes(bytes);
    final List<List<dynamic>> parsed = [];

    for (final sheet in excel.tables.values) {
      if (sheet.rows.isEmpty)
        {
          print('this row is empty');
          continue;
        }

      // Build first-row-first-col text to detect matrix layout
      final firstRow = sheet.rows.first;
      final String firstCellRaw = (firstRow.isNotEmpty && firstRow[0] != null) ? (firstRow[0]!.value?.toString() ?? '') : '';
      final String firstCell = firstCellRaw.toLowerCase().trim();

      final bool looksMatrix = firstCell.contains('fat') && firstRow.length >= 3;

      if (looksMatrix) {
        // parse SNF headers from firstRow (columns 1..n-1)
        final List<double> snfHeaders = [];
        for (int c = 1; c < firstRow.length; c++) {
          final dynamic v = firstRow[c]?.value;
          final double? d = _toDouble(v);
          if (d != null) snfHeaders.add(d);
          else {
            // If header is not numeric, attempt to parse removing text like "%" or extra chars
            final s = v?.toString() ?? '';
            final s2 = s.replaceAll(RegExp('[^0-9\\.,-]'), '');
            final dd = double.tryParse(s2.replaceAll(',', ''));
            if (dd != null) snfHeaders.add(dd);
            else snfHeaders.add(double.nan); // placeholder
          }
        }

        // parse each subsequent row: fat in col0, rates across remaining columns
        for (int r = 1; r < sheet.rows.length; r++) {
          final row = sheet.rows[r];
          if (row.isEmpty) continue;
          final dynamic fatRaw = row.elementAtOrNull(0)?.value;
          final double? fat = _toDouble(fatRaw);
          if (fat == null) continue;

          for (int c = 1; c < row.length && (c - 1) < snfHeaders.length; c++) {
            final dynamic rateRaw = row.elementAtOrNull(c)?.value;
            final double? rate = _toDouble(rateRaw);
            final double snfVal = snfHeaders[c - 1];
            // ensure snfVal is numeric (not NaN)
            if (rate != null && snfVal.isFinite) {
              parsed.add([fat, snfVal, rate]);
            }
          }
        }
      } else {
        // fallback: each row is fat,snf,rate (skip header row if first cell is not numeric)
        for (int r = 0; r < sheet.rows.length; r++) {
          final row = sheet.rows[r];
          if (row.isEmpty) continue;

          // If first row appears to be header (non-numeric first col), skip it
          if (r == 0 && _toDouble(row.elementAtOrNull(0)?.value) == null) {
            continue;
          }

          final double? fat = _toDouble(row.elementAtOrNull(0)?.value);
          final double? snf = _toDouble(row.elementAtOrNull(1)?.value);
          final double? rate = _toDouble(row.elementAtOrNull(2)?.value);

          if (fat != null && snf != null && rate != null) parsed.add([fat, snf, rate]);
        }
      }
    }
    print('parsed lenght is ${parsed.length}');
    return parsed;
  }

  double? _toDouble(dynamic v) {
    if (v == null) return null;
    if (v is num) return v.toDouble();
    final s = v.toString().trim();
    if (s.isEmpty) return null;
    // remove thousands separators and stray characters (keep . and -)
    final cleaned = s.replaceAll(',', '').replaceAll(RegExp('[^0-9\\.-]'), '');
    return double.tryParse(cleaned);
  }

  void _openViewer(_RateSet rs) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => _ExcelViewPage(rows: rs.rows, type: _selectedType)));
  }

  void _deleteForCurrentType() {
    setState(() => _store[_selectedType] = _RateSet());
    _toast('Deleted uploaded Excel for $_selectedType');
  }

  void _toast(String message) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
          ),
        ),
        child: Column(children: [
          _header(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Column(children: [
                _metricsGrid(_current),
                const SizedBox(height: 8),
                _actions(_current),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}

class _RateSet {
  String? filePath;
  List<List<dynamic>> rows = []; // each row: [fat(double), snf(double), rate(double)]
  double? minFat, maxFat, minSnf, maxSnf, minRate, maxRate;
  _RateSet();
}

extension _SafeGet<T> on List<T> {
  T? elementAtOrNull(int? i) => (i == null || i < 0 || i >= length) ? null : this[i];
}

/// Very simple viewer that shows parsed rows in a scrollable DataTable.
class _ExcelViewPage extends StatelessWidget {
  final List<List<dynamic>> rows;
  final String type;
  const _ExcelViewPage({super.key, required this.rows, required this.type});

  @override
  Widget build(BuildContext context) {
    final headers = ['Fat', 'SNF', 'Rate'];
    return Scaffold(
      appBar: AppBar(title: Text('$type Rate Sheet')),
      body: rows.isEmpty
          ? const Center(child: Text('No data'))
          : Padding(
        padding: const EdgeInsets.all(12.0),
        child: Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateProperty.resolveWith((_) => const Color(0xFFEFF6FF)),
              columns: headers.map((h) => DataColumn(label: Text(h))).toList(),
              rows: rows.map((r) {
                return DataRow(cells: [DataCell(Text(r[0].toString())), DataCell(Text(r[1].toString())), DataCell(Text(r[2].toString()))]);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
