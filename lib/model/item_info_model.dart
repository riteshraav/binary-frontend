import 'package:isar/isar.dart';

part 'item_info_model.g.dart';

@collection
class ItemInfoModel {
  Id? id;

  late String code;
  late String name;
  late String unit;

  double openingQty;
  double minQty;
  double purchaseRate;
  double currentQty;
  double sellingRate;
  double vat;

  String? purchaseAccount;
  String? salesAccount;
  String? creditSalesAccount;
  bool isActive;

  ItemInfoModel({
    this.id,
    required this.code,
    required this.name,
    required this.unit,
    this.openingQty = 0,
    this.minQty = 0,
    this.purchaseRate = 0,
    this.currentQty = 0,
    this.sellingRate = 0,
    this.vat = 0,
    this.purchaseAccount,
    this.salesAccount,
    this.creditSalesAccount,
    this.isActive = true,
  });
}