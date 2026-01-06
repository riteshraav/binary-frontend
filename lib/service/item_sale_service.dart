import 'package:isar/isar.dart';

import '../model/item_sale_model.dart';
import '../repository/item_sale_repository.dart';

class ItemSaleService {
  final ItemSaleRepository _repository;

  ItemSaleService(this._repository);

  Future<List<ItemSale>> fetchSales() async {
    return await _repository.getAllSales();
  }

  Future<void> addSale(ItemSale sale) async {
    await _repository.insertSale(sale);
  }

  Future<void> updateSale(ItemSale sale) async {
    await _repository.updateSale(sale);
  }

  Future<void> deleteSaleById(Id id) async {
    await _repository.deleteSaleById(id);
  }
}
