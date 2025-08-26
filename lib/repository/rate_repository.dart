import '../model/rate_model.dart';

abstract class RateRepository {
  Future<void> addRate(RateModel rate);
  Future<List<RateModel>> getAllRates();
  Future<RateModel?> getRateById(int id);
  Future<void> deleteRate(int id);
  Future<void> updateRate(RateModel rate);
}
