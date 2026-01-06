import 'package:isar/isar.dart';
import '../model/item_info_model.dart';
import '../repository/item_info_repository.dart';

class ItemInfoIsarRepository implements ItemInfoRepository {
  final Isar isar;
  ItemInfoIsarRepository(this.isar);

  @override
  Future<int> addItem(ItemInfoModel item) async {
    return await isar.writeTxn(() async {
      return await isar.itemInfoModels.put(item);
    });
  }

  @override
  Future<List<ItemInfoModel>> getAllItems() async {
    return await isar.itemInfoModels.where().findAll();
  }

  @override
  Future<ItemInfoModel?> getItemById(int id) async {
    return await isar.itemInfoModels.get(id);
  }

  @override
  Future<bool> deleteItem(int id) async {
    return await isar.writeTxn(() async {
      return await isar.itemInfoModels.delete(id);
    });
  }

  @override
  Future<int> updateItem(ItemInfoModel item) async {
    return await isar.writeTxn(() async {
      return await isar.itemInfoModels.put(item); // returns id
    });
  }

  // 🔹 New: Get Item by Code
  @override
  Future<ItemInfoModel?> getItemByCode(String code) async {
    return await isar.itemInfoModels.filter().codeEqualTo(code).findFirst();
  }

  // 🔹 New: Get Next Code (auto-increment style)
  @override
  Future<String> getNextCode() async {
    final items = await isar.itemInfoModels.where().findAll();
    if (items.isEmpty) return "1";

    // Convert existing codes to int safely
    final codes = items
        .map((e) => int.tryParse(e.code) ?? 0)
        .toList()
      ..sort();

    final next = codes.last + 1;
    return next.toString();
  }
}
