import 'package:isar/isar.dart';
import '../model/rate_model.dart';
import '../repository/rate_repository.dart';


class RateIsarRepository implements RateRepository {
  final Isar _isar;

  RateIsarRepository(this._isar);

  @override
  Future<void> addRate(RateModel rate) async {
    await _isar.writeTxn(() async {
      await _isar.rateModels.put(rate);
    });
  }

  @override
  Future<List<RateModel>> getAllRates() async {
    return await _isar.rateModels.where().findAll();
  }

  @override
  Future<RateModel?> getRateById(int id) async {
    return await _isar.rateModels.get(id);
  }

  @override
  Future<void> deleteRate(int id) async {
    await _isar.writeTxn(() async {
      await _isar.rateModels.delete(id);
    });
  }

  @override
  Future<void> updateRate(RateModel rate) async {
    await _isar.writeTxn(() async {
      await _isar.rateModels.put(rate); // put works for insert+update
    });
  }
}
