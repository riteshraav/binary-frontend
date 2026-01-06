import '../model/item_stock_model.dart';
import '../repository/item_stock_repository.dart';


class ItemStockService {
  final ItemStockRepository _repo;

  ItemStockService(this._repo);

  Future<List<ItemStock>> fetchStock() async {
    return await _repo.getAllStocks();
  }

  Future<void> deleteStockById(int id) async {
    await _repo.deleteStock(id);
  }

  Future<void> addStock(ItemStock stock) async {
    await _repo.insertStock(stock);
  }
}
