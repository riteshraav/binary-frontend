// lib/model/item_sale_model.dart
import 'package:isar/isar.dart';

part 'item_sale_model.g.dart';

@collection
class ItemSale {

  @Index()  // ✅ add index so `codeEqualTo` works
  late int code;

  Id id = Isar.autoIncrement;

  String? voucherNo;
  String? voucherNum;
  String? customer;
  String? seqNo;
  String? itemName;
  String? qty;
  String? rate;
  String? amount;
  String? vat;
  String? bhade;
  String? totalAmount;
  String? billAmount;
  String? details;
  String? paymentType;
  DateTime? date;

  // optional named constructor (without id)
  ItemSale({
    this.voucherNo,
    this.voucherNum,
    this.customer,
    this.seqNo,
    this.itemName,
    this.qty,
    this.rate,
    this.amount,
    this.vat,
    this.bhade,
    this.totalAmount,
    this.billAmount,
    this.details,
    this.paymentType,
    this.date,
  });
}
