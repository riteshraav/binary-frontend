import 'package:isar/isar.dart';

part 'daily_collection_data.g.dart';

@collection
class DailyCollectionData {
  Id id = Isar.autoIncrement;
  DateTime date;
  int customerCount;
  String adminId;
  int milkType;
  double avgFat;
  double avgSnf;
  double quantity;
  int totalCan;
  double totalAmount;

  DailyCollectionData(
      this.date,
      this.customerCount,
      this.adminId,
      this.milkType,
      this.avgFat,
      this.avgSnf,
      this.quantity,
      this.totalCan,
      this.totalAmount,
      );

  // ✅ Corrected fromJson
  factory DailyCollectionData.fromJson(Map<String, dynamic> json) {
    return DailyCollectionData(
      json['data'] as DateTime,
      json['customerCount'] as int,
      json['adminId'] as String,
      json['milkType'] as int,
      (json['avgFat'] as num).toDouble(),
      (json['avgSnf'] as num).toDouble(),
      (json['quantity'] as num).toDouble(),
      json['totalCan'] as int,
      json['totalAmount'] as double,
    );
  }

  // ✅ toJson
  Map<String, dynamic> toJson() {
    return {
      'date':date,
      'id': id,
      'customerCount': customerCount,
      'adminId': adminId,
      'milkType': milkType,
      'avgFat': avgFat,
      'avgSnf': avgSnf,
      'quantity': quantity,
      'totalCan': totalCan,
      'totalAmount': totalAmount,
    };
  }
}
