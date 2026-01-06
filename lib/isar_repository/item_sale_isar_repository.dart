import 'package:isar/isar.dart';
import '../model/item_sale_model.dart';
import '../repository/item_sale_repository.dart';

class ItemSaleIsarRepository implements ItemSaleRepository {
  final Isar _isar;

  ItemSaleIsarRepository(this._isar);

  @override
  Future<List<ItemSale>> getAllSales() async {
    return await _isar.itemSales.where().findAll();
  }

  @override
  Future<void> insertSale(ItemSale sale) async {
    await _isar.writeTxn(() async {
      await _isar.itemSales.put(sale);
    });
  }

  @override
  Future<void> updateSale(ItemSale sale) async {
    await _isar.writeTxn(() async {
      await _isar.itemSales.put(sale);
    });
  }

  @override
  Future<void> deleteSaleById(Id id) async {
    await _isar.writeTxn(() async {
      await _isar.itemSales.delete(id);
    });
  }
}
