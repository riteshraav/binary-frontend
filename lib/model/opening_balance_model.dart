import 'package:isar/isar.dart';

part 'opening_balance_model.g.dart';

@collection
class OpeningBalance {
  Id id = Isar.autoIncrement;
  @Index(unique: false, composite: [CompositeIndex('customerCode')])
  late String deductionCode;
  late String customerCode;
  late double openingBalance;
  late double crTot;
  late double drTot;
  late double clBal;
  late double clTot;

  OpeningBalance({
    required this.deductionCode,
    required this.customerCode,
    required this.openingBalance,
    required this.crTot,
    required this.drTot,
    required this.clBal,
    required this.clTot,
  });

  // ✅ Convert Dart object → JSON
  Map<String, dynamic> toJson() => {
    'deductionCode': deductionCode,
    'customerCode': customerCode,
    'openingBalance': openingBalance,
    'crTot': crTot,
    'drTot': drTot,
    'clBal': clBal,
    'clTot': clTot,
  };

  // ✅ Convert JSON → Dart object
  factory OpeningBalance.fromJson(Map<String, dynamic> json) => OpeningBalance(
    deductionCode: json['deductionCode'] ?? '',
    customerCode: json['customerCode'] ?? '',
    openingBalance: (json['openingBalance'] ?? 0).toDouble(),
    crTot: (json['crTot'] ?? 0).toDouble(),
    drTot: (json['drTot'] ?? 0).toDouble(),
    clBal: (json['clBal'] ?? 0).toDouble(),
    clTot: (json['clTot'] ?? 0).toDouble(),
  );
}
