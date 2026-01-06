import 'package:isar/isar.dart';
import 'package:windows_sample/model/supplier_model.dart';
import 'package:windows_sample/model/item_info_model.dart';
import '../model/item_purchase_model.dart';
import '../repository/item_purchase_repository.dart';

class ItemPurchaseIsarRepository implements ItemPurchaseRepository {
  final Isar isar;

  ItemPurchaseIsarRepository(this.isar);

  @override
  Future<List<ItemPurchase>> getAllPurchases() async {
    final purchases = await isar.itemPurchases.where().findAll();
    for (final purchase in purchases) {
      await purchase.supplier.load();
      await purchase.item.load();
    }
    return purchases;
  }

  @override
  Future<ItemPurchase?> getPurchaseById(int id) async {
    final purchase = await isar.itemPurchases.get(id);
    if (purchase != null) {
      await purchase.supplier.load();
      await purchase.item.load();
    }
    return purchase;
  }

  @override
  Future<int> addPurchase(ItemPurchase purchase) async {
    return await isar.writeTxn(() async {
      return await isar.itemPurchases.put(purchase);
    });
  }

  @override
  Future<int> updatePurchase(ItemPurchase purchase) async {
    return await isar.writeTxn(() async {
      return await isar.itemPurchases.put(purchase);
    });
  }

  @override
  Future<int> deletePurchase(int id) async {
    final success = await isar.writeTxn(() async {
      return await isar.itemPurchases.delete(id);
    });

    if (success) {
      return id;
    } else {
      throw Exception("Failed to delete purchase with id $id");
    }
  }

  @override
  Future<double> getItemPurchaseRate(String itemName) async {
    final item = await isar.itemInfoModels
        .filter()
        .nameEqualTo(itemName)
        .findFirst();

    return item?.purchaseRate ?? 0.0;
  }
}