

import '../model/rate_model.dart';
import '../repository/rate_repository.dart';

class RateService {
  final RateRepository _repository;

  RateService(this._repository);

  Future<void> addRate(String name) async {
    final rate = RateModel(name: name);
    await _repository.addRate(rate);
  }

  Future<List<RateModel>> fetchRates() async {
    return await _repository.getAllRates();
  }

  Future<RateModel?> getRate(int id) async {
    return await _repository.getRateById(id);
  }

  Future<void> removeRate(int id) async {
    await _repository.deleteRate(id);
  }

  Future<void> updateRate(int id, String newName) async {
    final existing = await _repository.getRateById(id);
    if (existing != null) {
      existing.name = newName;
      await _repository.updateRate(existing);
    }
  }
}
