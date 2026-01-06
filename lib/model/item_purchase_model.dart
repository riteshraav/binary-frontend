import 'package:isar/isar.dart';
import 'supplier_model.dart';
import 'item_info_model.dart';

part 'item_purchase_model.g.dart';

@collection
class ItemPurchase {
  Id id = Isar.autoIncrement;

  @Index()
  late String voucherNo;

  late String paymentType;
  late DateTime date;
  late String voucherNum;
  late String seqNo;

  // Item info reference
  final item = IsarLink<ItemInfoModel>();
  late String itemName;
  late String qty;
  late String rate;
  late String amount;
  late String vat;
  late String commission;
  late String hamali;
  late String totalAmount;
  late String billAmount;
  late String details;

  final supplier = IsarLink<Supplier>();

  @override
  String toString() {
    return 'ItemPurchase{id: $id, voucherNo: $voucherNo, itemName: $itemName}';
  }
}