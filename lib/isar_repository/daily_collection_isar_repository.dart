import 'package:isar/isar.dart';

import '../model/daily_collection_data.dart';
import '../repository/daily_collection_repository.dart';

class DailyCollectionIsarRepository implements DailyCollectionRepository {
  final Isar _isar;

  DailyCollectionIsarRepository(this._isar);

  @override
  Future<int> insert(DailyCollectionData data) async {
    return await _isar.writeTxn(() async => await _isar.dailyCollectionDatas.put(data));
  }

  @override
  Future<List<DailyCollectionData>> getAll() async {
    return await _isar.dailyCollectionDatas.where().findAll();
  }

  @override
  Future<DailyCollectionData?> getById(int id) async {
    return await _isar.dailyCollectionDatas.get(id);
  }

  @override
  Future<bool> delete(int id) async {
    return await _isar.writeTxn(() async => await _isar.dailyCollectionDatas.delete(id));
  }

  @override
  Future<bool> update(DailyCollectionData data) async {
    return await _isar.writeTxn(() async => await _isar.dailyCollectionDatas.put(data)) > 0;
  }

  @override
  Future<DailyCollectionData?> getByDate(DateTime date, int milkType) async{
    final startOfDay = DateTime(date.year, date.month, date.day, 0, 0, 0);

    // End of the day (23:59:59)
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);
    DailyCollectionData? dailyCollectionData = await _isar.dailyCollectionDatas.filter().dateBetween(startOfDay,endOfDay).milkTypeEqualTo(milkType).findFirst();
    return dailyCollectionData;
  }
}
