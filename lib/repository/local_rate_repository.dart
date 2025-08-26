import '../model/local_rate_model.dart';

abstract class LocalRateRepository {
  Future<int> addRate(LocalRateModel rate);
  Future<List<LocalRateModel>> getAllRates();
  Future<LocalRateModel?> getRateById(int id);
  Future<bool> deleteRate(int id);
  Future<bool> updateRate(LocalRateModel rate);
}
