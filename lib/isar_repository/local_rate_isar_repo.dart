import 'package:isar/isar.dart';
import '../model/local_rate_model.dart';
import '../repository/local_rate_repository.dart';

class LocalRateRepositoryImpl implements LocalRateRepository {
  final Isar isar;

  LocalRateRepositoryImpl(this.isar);

  @override
  Future<int> addRate(LocalRateModel rate) async {
    return await isar.writeTxn(() async {
      return await isar.localRateModels.put(rate);
    });
  }

  @override
  Future<List<LocalRateModel>> getAllRates() async {
    return await isar.localRateModels.where().findAll();
  }

  @override
  Future<LocalRateModel?> getRateById(int id) async {
    return await isar.localRateModels.get(id);
  }

  @override
  Future<bool> deleteRate(int id) async {
    return await isar.writeTxn(() async {
      return await isar.localRateModels.delete(id);
    });
  }

  @override
  Future<bool> updateRate(LocalRateModel rate) async {
    return await isar.writeTxn(() async {
      return await isar.localRateModels.put(rate) > 0;
    });
  }
}
