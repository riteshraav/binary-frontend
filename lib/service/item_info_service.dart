import '../model/item_info_model.dart';
import '../repository/item_info_repository.dart';

class ItemInfoService {
  final ItemInfoRepository repository;
  ItemInfoService(this.repository);

  /// Save (add or update depending on id presence)
  Future<int> saveItem(ItemInfoModel item) async {
    // Basic validation
    if (item.code.trim().isEmpty) {
      throw Exception("Code आवश्यक आहे");
    }
    if (item.name.trim().isEmpty) {
      throw Exception("Name आवश्यक आहे");
    }
    if (item.unit.trim().isEmpty) {
      throw Exception("Unit आवश्यक आहे");
    }

    // If id is null -> add, else update
    if (item.id != null) {
      return await repository.addItem(item);
    } else {
      return await repository.updateItem(item);
    }
  }

  Future<List<ItemInfoModel>> getItems() async {
    return await repository.getAllItems();
  }

  Future<ItemInfoModel?> getItemById(int id) async {
    return await repository.getItemById(id);
  }

  Future<ItemInfoModel?> getItemByCode(String code) async {
    return await repository.getItemByCode(code);
  }

  Future<bool> deleteItem(int id) async {
    return await repository.deleteItem(id);
  }

  Future<String> getNextItemCode() async {
    return await repository.getNextCode();
  }
}