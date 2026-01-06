import '../model/item_purchase_model.dart';

abstract class ItemPurchaseRepository {
  Future<List<ItemPurchase>> getAllPurchases();
  Future<ItemPurchase?> getPurchaseById(int id);
  Future<int> addPurchase(ItemPurchase purchase);
  Future<int> updatePurchase(ItemPurchase purchase);
  Future<int> deletePurchase(int id);
  Future<double> getItemPurchaseRate(String itemName);
}