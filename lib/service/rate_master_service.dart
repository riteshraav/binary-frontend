// lib/services/rate_service.dart
import 'dart:developer';

import '../model/rate_model.dart';
import '../repository/rate_repository.dart';


class RateService {
  final RateRepository _repository;

  RateService(this._repository);

  Future<RateModel?> getRateById(int id) async {
    log("Service: Get rate by id=$id");
    return await _repository.getById(id);
  }

  Future<List<RateModel>> listRates() async {
    log("Service: List all rates");
    return await _repository.getAll();
  }

  Future<int> addRate(RateModel rate) async {
    log("Service: Adding new rate: ${rate.name}");
    _validateRate(rate);
    return await _repository.insert(rate);
  }

  Future<bool> updateRate(RateModel rate) async {
    log("Service: Updating rate id=${rate.id}");
    _validateRate(rate);
    return await _repository.update(rate);
  }

  Future<bool> removeRate(int id) async {
    log("Service: Removing rate id=$id");
    return await _repository.delete(id);
  }

  void _validateRate(RateModel rate) {
    if (rate.minFat > rate.maxFat) {
      throw ArgumentError("minFat cannot be greater than maxFat");
    }
    if (rate.minsnf > rate.maxsnf) {
      throw ArgumentError("minsnf cannot be greater than maxsnf");
    }
    if (rate.minRate > rate.maxRate) {
      throw ArgumentError("minRate cannot be greater than maxRate");
    }
    log("Validation passed for rate: ${rate.name}");
  }

  Future<List<RateModel>> getCurrentRate()async{
    log("fetching current rate");
    return await _repository.getCurrentRate();
  }
  Future<List<RateModel>> getLatestRate(DateTime date)async{
    log("fetching current rate");
    return await _repository.getLatestRates(date);
  }
}
