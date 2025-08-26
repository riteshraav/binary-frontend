import '../model/daily_collection_data.dart';

abstract class DailyCollectionRepository {
  Future<int> insert(DailyCollectionData data);
  Future<List<DailyCollectionData>> getAll();
  Future<DailyCollectionData?> getById(int id);
  Future<bool> delete(int id);
  Future<bool> update(DailyCollectionData data);
  Future<DailyCollectionData?> getByDate(DateTime date,int milkType);
}
