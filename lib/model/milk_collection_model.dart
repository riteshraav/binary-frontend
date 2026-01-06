import 'package:isar/isar.dart';

part 'milk_collection_model.g.dart';

@collection
class MilkCollectionModel {
  Id id = Isar.autoIncrement; // Primary key
  late String customerId;
  late String adminId;
  late double fat;
  late double snf;
  late int milkType; // 0 = cow, 1 = buffalo
  late int time; // 0 = morning, 1 = evening
  late DateTime date; // store as string: "dd/MM/yyyy"
  late double rate;
  late double amount;
  late double quantity;

  @Index(unique: true)
  late String uniqueKey; // synthetic candidate key

  /// Helper to generate uniqueKey before saving
  void generateUniqueKey() {
    // Ensure DateTime is normalized (only date part if needed)
    final dateStr = "${date.year}-${date.month}-${date.day}";
    uniqueKey = "$customerId|$adminId|$milkType|$time|$dateStr";
  }
  // Constructor
  MilkCollectionModel({
    required this.customerId,
    required this.adminId,
    required this.fat,
    required this.snf,
    required this.milkType,
    required this.time,
    required this.date,
    required this.rate,
    required this.amount,
    required this.quantity,
  });

  // From JSON
  factory MilkCollectionModel.fromJson(Map<String, dynamic> json) {
    return MilkCollectionModel(
      customerId: json['customerId'],
      adminId: json['adminId'],
      fat: (json['fat'] as num).toDouble(),
      snf: (json['snf'] as num).toDouble(),
      milkType: json['milkType'],
      time: json['time'],
      date: json['date'],
      rate: (json['rate'] as num).toDouble(),
      amount: (json['amount'] as num).toDouble(),
      quantity: (json['quantity'] as num).toDouble(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerId': customerId,
      'adminId': adminId,
      'fat': fat,
      'snf': snf,
      'milkType': milkType,
      'time': time,
      'date': date.toIso8601String(),
      'rate': rate,
      'amount': amount,
      'quantity': quantity,
    };
  }
}
