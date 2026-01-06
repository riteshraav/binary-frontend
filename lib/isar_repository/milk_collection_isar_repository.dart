import 'package:isar/isar.dart';
import '../model/milk_collection_model.dart';
import 'package:path_provider/path_provider.dart';

import '../repository/milk_collection_repository.dart';

class MilkCollectionIsarRepository implements MilkCollectionRepository {
  final Isar _isar;

  MilkCollectionIsarRepository(this._isar);

  @override
  Future<int?> insertMilkCollection(MilkCollectionModel collection) async {
    collection.generateUniqueKey();

    try {
      return await _isar.writeTxn(() async {
        return await _isar.milkCollectionModels.put(collection);
      });
    } on IsarError catch (e) {
      if (e.message.contains('Unique index violated')) {
        print("⚠️ Duplicate entry detected for key=${collection.uniqueKey}, updating existing record instead");
        return await _isar.writeTxn(() async {
          // Find the existing record with the same uniqueKey
          final existing = await _isar.milkCollectionModels
              .filter()
              .uniqueKeyEqualTo(collection.uniqueKey) // assuming uniqueKey is indexed
              .findFirst();

          if (existing != null) {
            // Preserve the same id so Isar overwrites instead of inserting
            collection.id = existing.id;
          }

          // Now overwrite (upsert)
          return await _isar.milkCollectionModels.put(collection);
        });
      }
      rethrow; // other Isar errors
    }
  }

  @override
  Future<List<MilkCollectionModel>> getAllCollections() async {
    return await _isar.milkCollectionModels.where().findAll();
  }

  @override
  Future<List<MilkCollectionModel>> getCollectionsByDate(DateTime date) async {
    return await _isar.milkCollectionModels.filter().dateEqualTo(date).findAll();
  }

  @override
  Future<void> deleteCollection(int id) async {
    await _isar.writeTxn(() async {
      await _isar.milkCollectionModels.delete(id);
    });
  }

  @override
  Future<void> clearAll() async {
    await _isar.writeTxn(() async {
      await _isar.milkCollectionModels.clear();
    });
  }
  @override
  Future<List<MilkCollectionModel>> getCollectionsBetween(DateTime from, DateTime to) async {

    return await _isar.milkCollectionModels
        .filter()
        .dateBetween(from, to)
        .findAll();
  }

  @override
  Future<List<MilkCollectionModel>> getCollectionsBetweenAndByAdminId(DateTime from, DateTime to, String adminId) async{
    return await _isar.milkCollectionModels
        .filter()
        .adminIdEqualTo(adminId)
        .dateBetween(from, to)
        .findAll();
  }

  @override
  Future<List<MilkCollectionModel>> getCollectionsBetweenAndByAdminIdAndMilkType(DateTime from, DateTime to, String adminId, int milkType) async{
    return await _isar.milkCollectionModels
        .filter()
        .adminIdEqualTo(adminId)
        .milkTypeEqualTo(milkType)
        .dateBetween(from, to)
        .findAll();
  }

  @override
  Future<List<MilkCollectionModel>> getCollectionsBetweenAndByAdminIdAndCustomerAndMilkType(String customerId, int milkType, DateTime from, DateTime to, String adminId) async{
    return await _isar.milkCollectionModels
        .filter()
        .adminIdEqualTo(adminId)
        .milkTypeEqualTo(milkType)
        .dateBetween(from, to)
        .customerIdEqualTo(customerId)
        .findAll();
  }



}
