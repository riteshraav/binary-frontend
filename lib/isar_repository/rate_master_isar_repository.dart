// lib/repositories/isar_rate_repository.dart
import 'package:isar/isar.dart';
import 'dart:developer';

import '../model/rate_model.dart';
import '../repository/rate_repository.dart';


class IsarRateRepository implements RateRepository {
  final Isar _isar;

  IsarRateRepository(this._isar);

  @override
  Future<RateModel?> getById(int id) async {
    log("Fetching RateModel with id=$id");
    final result = await _isar.rateModels.get(id);
    log(result != null ? "Found record id=$id" : "No record found id=$id");
    return result;
  }

  @override
  Future<List<RateModel>> getAll() async {
    log("Fetching all RateModels");
    final result = await _isar.rateModels.where().findAll();
    log("Fetched ${result.length} records");
    return result;
  }

  @override
  Future<int> insert(RateModel rate) async {
    log("Inserting RateModel: ${rate.name}, date=${rate.date}");
    final id = await _isar.writeTxn(() async {
      return await _isar.rateModels.put(rate);
    });
    log("Inserted RateModel with id=$id");
    return id;
  }

  @override
  Future<bool> update(RateModel rate) async {
    log("Updating RateModel id=${rate.id}");
    final success = await _isar.writeTxn(() async {
      return await _isar.rateModels.put(rate) > 0;
    });
    log(success ? "Update successful id=${rate.id}" : "Update failed id=${rate.id}");
    return success;
  }

  @override
  Future<bool> delete(int id) async {
    log("Deleting RateModel id=$id");
    final success = await _isar.writeTxn(() async {
      return await _isar.rateModels.delete(id);
    });
    log(success ? "Deleted id=$id" : "Delete failed id=$id");
    return success;
  }

  @override
  Future<void> clear() async {
    log("Clearing all RateModels");
    await _isar.writeTxn(() async {
      await _isar.rateModels.clear();
    });
    log("Cleared all RateModels");
  }

  @override
  Future<List<RateModel>> getCurrentRate() async{
    final results = await _isar.rateModels
        .filter()
        .isCurrentEqualTo(true)
        .findAll();

    log("Found ${results.length} records with isCurrent=true");
    return results;
  }

  @override
  Future<List<RateModel>> getLatestRates(DateTime date) async {
    print('date is ${date.day}');
    // Step 1: Fetch all rate models before or on the given date
    final results = await _isar.rateModels
        .filter()
        .dateLessThan(date,include:true)
        .findAll();

    log("Found ${results.length} records before or on $date");

    // Step 2: Group by name + milkType
    final Map<String, RateModel> latestByGroup = {};

    for (final model in results) {
      final key = "${model.name}_${model.milkType}";

      // Step 3: Keep only the most recent record for each unique group
      if (!latestByGroup.containsKey(key) ||
          model.date.isAfter(latestByGroup[key]!.date)) {
        latestByGroup[key] = model;
      }
    }

    final latestModels = latestByGroup.values.toList();
    for(var model in latestModels)
      {
        log('${model.name} with date ${model.date} and milktype ${model.milkType}');
      }
    log("Returning ${latestModels.length} unique latest records");

    return latestModels;
  }
}
