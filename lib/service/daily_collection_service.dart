import 'package:windows_sample/repository/daily_collection_repository.dart';

import '../model/daily_collection_data.dart';


class DailyCollectionService {
  final DailyCollectionRepository _repository;

  DailyCollectionService(this._repository);

  Future<void> addCollection(DailyCollectionData data) async {
    await _repository.insert(data);
  }

  Future<List<DailyCollectionData>> fetchAllCollections() async {
    return await _repository.getAll();
  }
  Future<DailyCollectionData?> fetchCollectionsByDate(DateTime date,int milkType) async {
    return await _repository.getByDate(date,milkType);
  }

  Future<DailyCollectionData?> fetchCollectionById(int id) async {
    return await _repository.getById(id);
  }

  Future<void> removeCollection(int id) async {
    await _repository.delete(id);
  }

  Future<void> updateCollection(DailyCollectionData data) async {
    await _repository.update(data);
  }
}
