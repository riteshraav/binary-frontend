import 'dart:convert';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CowRateChartProvider with ChangeNotifier {
  final List<double> _snfValues = [];
  final List<double> _fatValues = [];
  final Map<double, Map<double, double>> _rates = {};

  // <-- NEW: store table data for viewing
  final List<List<dynamic>> _tableData = [];
  List<List<dynamic>> get tableData => _tableData;

  bool filePicked = false;

  // optional running totals you may use
  double morningCowQuantity = 0.0;
  double eveningCowQuantity = 0.0;

  static const _prefsKey = 'cow_ratechart_json_v1';

  List<double> get snfValues => List.unmodifiable(_snfValues);
  List<double> get fatValues => List.unmodifiable(_fatValues);

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw == null) return;

    final data = jsonDecode(raw) as Map<String, dynamic>;
    _snfValues
      ..clear()
      ..addAll((data['snf'] as List).map((e) => (e as num).toDouble()));
    _fatValues
      ..clear()
      ..addAll((data['fat'] as List).map((e) => (e as num).toDouble()));

    _rates.clear();
    final ratesMap = data['rates'] as Map<String, dynamic>;
    for (final fatK in ratesMap.keys) {
      final fat = double.parse(fatK);
      final inner = <double, double>{};
      final innerMap = ratesMap[fatK] as Map<String, dynamic>;
      for (final snfK in innerMap.keys) {
        inner[double.parse(snfK)] = (innerMap[snfK] as num).toDouble();
      }
      _rates[fat] = inner;
    }
    filePicked = _rates.isNotEmpty;
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonRates = <String, Map<String, double>>{};
    for (final fat in _rates.keys) {
      final inner = <String, double>{};
      _rates[fat]!.forEach((snf, rate) {
        inner[snf.toStringAsFixed(1)] = rate;
      });
      jsonRates[fat.toStringAsFixed(1)] = inner;
    }

    final payload = jsonEncode({
      'snf': _snfValues,
      'fat': _fatValues,
      'rates': jsonRates,
    });
    await prefs.setString(_prefsKey, payload);
  }

  Future<void> loadFromExcelBytes(List<int> bytes) async {
    final excel = Excel.decodeBytes(bytes);
    if (excel.tables.isEmpty) return;
    final sheet = excel.tables.values.first;

    _snfValues.clear();
    _fatValues.clear();
    _rates.clear();
    _tableData.clear(); // <-- clear previous table data

    final headerRow = sheet.rows.first;

    // Store header row for tableData
    _tableData.add(headerRow.map((c) => c?.value).toList());

    for (int c = 1; c < headerRow.length; c++) {
      final v = headerRow[c]?.value;
      if (v == null) continue;
      final d = double.tryParse(v.toString());
      if (d != null) _snfValues.add(double.parse(d.toStringAsFixed(1)));
    }

    for (int r = 1; r < sheet.rows.length; r++) {
      final row = sheet.rows[r];
      if (row.isEmpty) continue;

      // Store row for tableData
      _tableData.add(row.map((c) => c?.value).toList());

      final fatCell = row.first?.value;
      final fat = fatCell == null ? null : double.tryParse(fatCell.toString());
      if (fat == null) continue;

      final fatVal = double.parse(fat.toStringAsFixed(1));
      _fatValues.add(fatVal);

      final inner = <double, double>{};
      for (int c = 1; c < row.length && c <= _snfValues.length; c++) {
        final cell = row[c]?.value;
        final rate = cell == null ? null : double.tryParse(cell.toString());
        if (rate != null) {
          inner[_snfValues[c - 1]] = (rate as num).toDouble();
        }
      }
      _rates[fatVal] = inner;
    }
    _snfValues.sort();
    _fatValues.sort();
    filePicked = _rates.isNotEmpty;
    await _saveToPrefs();
    notifyListeners();
  }

  double findRate(double fat, double snf) {
    if (_rates.isEmpty) return 0.0;

    final f = double.parse(fat.toStringAsFixed(1));
    final s = double.parse(snf.toStringAsFixed(1));

    if (_rates.containsKey(f) && _rates[f]!.containsKey(s)) {
      return _rates[f]![s]!;
    }

    double? f1, f2, s1, s2;

    for (final v in _fatValues) {
      if (v <= f) f1 = v;
      if (v >= f && (f2 == null || v < f2!)) f2 = v;
    }
    for (final v in _snfValues) {
      if (v <= s) s1 = v;
      if (v >= s && (s2 == null || v < s2!)) s2 = v;
    }

    if (f1 == null || f2 == null || s1 == null || s2 == null) return 0.0;
    if (!_rates.containsKey(f1) || !_rates.containsKey(f2)) return 0.0;
    if (!_rates[f1]!.containsKey(s1) || !_rates[f1]!.containsKey(s2)) return 0.0;
    if (!_rates[f2]!.containsKey(s1) || !_rates[f2]!.containsKey(s2)) return 0.0;

    final q11 = _rates[f1]![s1]!;
    final q12 = _rates[f1]![s2]!;
    final q21 = _rates[f2]![s1]!;
    final q22 = _rates[f2]![s2]!;

    if (f1 == f2 && s1 == s2) return q11;
    if (f1 == f2) {
      final t = (s - s1) / (s2 - s1);
      return q11 + (q12 - q11) * t;
    }
    if (s1 == s2) {
      final t = (f - f1) / (f2 - f1);
      return q11 + (q21 - q11) * t;
    }

    final t = (f - f1) / (f2 - f1);
    final u = (s - s1) / (s2 - s1);
    final r1 = q11 + (q21 - q11) * t;
    final r2 = q12 + (q22 - q12) * t;
    return r1 + (r2 - r1) * u;
  }

  void clearChart() async {
    _snfValues.clear();
    _fatValues.clear();
    _rates.clear();
    _tableData.clear(); // <-- clear table data
    filePicked = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefsKey);
    notifyListeners();
  }
}
