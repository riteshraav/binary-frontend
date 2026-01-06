import 'dart:convert';
import 'package:isar/isar.dart';

part 'rate_model.g.dart';

@collection
class RateModel {
  Id id = Isar.autoIncrement;

  late String name;
  late DateTime date;
  late int milkType;

  /// Stored JSON string for Isar
  late String excelJson;

  late double minFat;
  late double minsnf;
  late double minRate;
  late double maxFat;
  late double maxsnf;
  late double maxRate;
  late int row;
  late int col;
  late double increment ;
  late bool isCurrent;
  /// Computed field (ignored by Isar)
  @ignore
  List<List<String>> get excel => _decodeExcel(excelJson);

  @ignore
  set excel(List<List<String>> value) {
    excelJson = _encodeExcel(value);
  }

  // --- Private helpers ---
  String _encodeExcel(List<List<String>> matrix) => jsonEncode(matrix);

  List<List<String>> _decodeExcel(String jsonStr) {
    final data = jsonDecode(jsonStr) as List<dynamic>;
    return data
        .map<List<String>>(
          (row) => (row as List<dynamic>)
          .map<String>((e) => e?.toString() ?? "")
          .toList(),
    )
        .toList();
  }


  /// ✅ Normal constructor for Isar (all real fields)
  RateModel({
    required this.name,
    required this.date,
    required this.milkType,
    required this.excelJson,
    required this.minFat,
    required this.minsnf,
    required this.minRate,
    required this.maxFat,
    required this.maxsnf,
    required this.maxRate,
    required this.row,
    required this.col,
    required this.increment,
    required this.isCurrent
  });

  /// ✅ Helper to construct with List<List<double>> instead of JSON
  static RateModel fromExcel({
    required String name,
    required DateTime date,
    required int milkType,
    required List<List<String>> excel,
    required double minFat,
    required double minsnf,
    required double minRate,
    required double maxFat,
    required double maxsnf,
    required double maxRate,
    required int row,
    required int col, required double increment,
    required bool   isCurrent
  }) {
    return RateModel(
      name: name,
      date: date,
      milkType: milkType,
      excelJson: jsonEncode(excel),
      minFat: minFat,
      minsnf: minsnf,
      minRate: minRate,
      maxFat: maxFat,
      maxsnf: maxsnf,
      maxRate: maxRate,
      row: row,
      col: col,
        increment: increment,
      isCurrent: isCurrent
    );
  }
}
