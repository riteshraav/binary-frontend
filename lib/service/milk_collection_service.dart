import 'dart:developer';

import '../model/milk_collection_model.dart';
import '../repository/milk_collection_repository.dart';

class MilkCollectionService {
  final MilkCollectionRepository _repository;

  MilkCollectionService(this._repository);

  Future<int?> addCollection(MilkCollectionModel collection) {
    return _repository.insertMilkCollection(collection);
  }

  Future<List<MilkCollectionModel>> getAllCollections() {
    return _repository.getAllCollections();
  }

  Future<List<MilkCollectionModel>> getCollectionsByDate(DateTime date) async {
    // Normalize to start of the day (00:00:00)
    final startOfDay = DateTime(date.year, date.month, date.day, 0, 0, 0);

    // End of the day (23:59:59)
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);
    return _repository.getCollectionsBetween(startOfDay, endOfDay);
  }

  Future<void> deleteCollection(int id) {
    return _repository.deleteCollection(id);
  }

  Future<void> clearCollections() {
    return _repository.clearAll();
  }
}
