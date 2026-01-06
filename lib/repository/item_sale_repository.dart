import 'package:isar/isar.dart';

import '../model/item_sale_model.dart';

abstract class ItemSaleRepository {
  Future<List<ItemSale>> getAllSales();
  Future<void> insertSale(ItemSale sale);
  Future<void> updateSale(ItemSale sale);
  Future<void> deleteSaleById(Id id);
}
