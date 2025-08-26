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
        // Rollback already done automatically by Isar
        // Now show an error to the use
        // Optionally throw a custom exception or return null
        return null;
        throw Exception("Duplicate entry exists for this milk collection!");

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

}
