import 'package:isar/isar.dart';
import 'dart:developer';

part 'deduction_entry_model.g.dart';

@collection
class DeductionEntry {
  Id id = Isar.autoIncrement;

  late String customerCode;
  late String dedCode;
  late double dedAmount;
  late int milkType;
  late String adminId;
  late DateTime date;

  DeductionEntry({
    required this.customerCode,
    required this.dedCode,
    required this.dedAmount,
    required this.milkType,
    required this.adminId,
    required this.date,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() => {
    'customerCode': customerCode,
    'dedCode': dedCode,
    'dedAmount': dedAmount,
    'milkType': milkType,
    'adminId': adminId,
    'date':date,
  };

  // Create from JSON
  factory DeductionEntry.fromJson(Map<String, dynamic> json) {
    log('Parsing DeductionEntry from JSON: $json');
    return DeductionEntry(
      customerCode: json['customerCode'] ?? '',
      dedCode: json['dedCode'] ?? '',
      dedAmount: (json['dedAmount'] ?? 0).toDouble(),
      milkType: json['milkType'] ?? 0,
      adminId: json['adminId'] ?? '',
      date:json['date']
    );
  }
}
