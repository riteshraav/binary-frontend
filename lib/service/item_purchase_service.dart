import '../model/item_purchase_model.dart';
import '../repository/item_purchase_repository.dart';

class ItemPurchaseService {
  final ItemPurchaseRepository _repository;

  ItemPurchaseService(this._repository);

  Future<List<ItemPurchase>> fetchPurchases() async {
    return await _repository.getAllPurchases();
  }

  Future<ItemPurchase?> getPurchaseById(int id) async {
    return await _repository.getPurchaseById(id);
  }

  Future<int> addPurchase(ItemPurchase purchase) async {
    return await _repository.addPurchase(purchase);
  }

  Future<int> updatePurchase(ItemPurchase purchase) async {
    return await _repository.updatePurchase(purchase);
  }

  Future<int> deletePurchase(int id) async {
    return await _repository.deletePurchase(id);
  }

  Future<double> getItemPurchaseRate(String itemName) async {
    return await _repository.getItemPurchaseRate(itemName);
  }
}