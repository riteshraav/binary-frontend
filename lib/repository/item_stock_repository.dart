import '../model/item_stock_model.dart';


class ItemStockRepository {
  final List<ItemStock> _stocks = [];

  Future<List<ItemStock>> getAllStocks() async {
    return _stocks;
  }

  Future<void> insertStock(ItemStock stock) async {
    _stocks.add(stock);
  }

  Future<void> deleteStock(int id) async {
    _stocks.removeWhere((s) => s.id == id);
  }
}
