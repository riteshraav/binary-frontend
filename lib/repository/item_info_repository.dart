// lib/repository/item_info_repository.dart

import '../model/item_info_model.dart';

abstract class ItemInfoRepository {
  /// Add item. Returns generated id (if DB returns id) or -1.
  Future<int> addItem(ItemInfoModel item);

  /// Update existing item (returns id or affected count)
  Future<int> updateItem(ItemInfoModel item);

  /// Delete by id (returns true if deleted)
  Future<bool> deleteItem(int id);

  /// Get all items
  Future<List<ItemInfoModel>> getAllItems();

  /// Get item by id
  Future<ItemInfoModel?> getItemById(int id);

  /// Get item by code (string). Return null if not found.
  Future<ItemInfoModel?> getItemByCode(String code);

  /// Get the next code (string). Implementation may compute next numeric code.
  Future<String> getNextCode();
}
