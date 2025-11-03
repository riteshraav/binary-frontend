import '../model/rate_model.dart';


abstract class RateRepository {
  Future<RateModel?> getById(int id);
  Future<List<RateModel>> getAll();
  Future<List<RateModel>> getCurrentRate();
  Future<int> insert(RateModel rate);
  Future<bool> update(RateModel rate);
  Future<bool> delete(int id);
  Future<void> clear();
  Future<List<RateModel>> getLatestRates(DateTime date);
}
