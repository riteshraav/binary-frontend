import '../model/local_rate_model.dart';
import '../repository/local_rate_repository.dart';

class LocalRateService {
  final LocalRateRepository _repository;

  LocalRateService(this._repository);

  Future<int> addRate(String name) async {
    final rate = LocalRateModel(name: name);
    return await _repository.addRate(rate);
  }

  Future<List<LocalRateModel>> fetchRates() async {
    return await _repository.getAllRates();
  }

  Future<LocalRateModel?> fetchRateById(int id) async {
    return await _repository.getRateById(id);
  }

  Future<bool> removeRate(int id) async {
    return await _repository.deleteRate(id);
  }

  Future<bool> editRate(int id, String newName) async {
    final rate = await _repository.getRateById(id);
    if (rate == null) return false;

    rate.name = newName;
    return await _repository.updateRate(rate);
  }
}
