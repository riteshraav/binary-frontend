// lib/repositories/isar_rat_group_repository.dart
import 'package:isar/isar.dart';
import 'dart:developer';

import '../model/rate_group.dart';
import '../repository/rate_group_repository.dart';


class IsarRateGroupRepository implements RateGroupRepository {
  final Isar _isar;

  IsarRateGroupRepository(this._isar);

  @override
  Future<RateGroup?> getById(int id) async {
    log("Fetching RatGroup id=$id");
    final result = await _isar.rateGroups.get(id);
    log(result != null ? "Found RatGroup $id" : "No RatGroup found for id=$id");
    return result;
  }

  @override
  Future<List<RateGroup>> getAll() async {
    log("Fetching all RatGroups");
    final result = await _isar.rateGroups.where().findAll();
    log("Fetched ${result.length} RatGroups");
    return result;
  }

  @override
  Future<int> insert(RateGroup group) async {
    log("Inserting RatGroup: ${group.name}");
    final id = await _isar.writeTxn(() async {
      return await _isar.rateGroups.put(group);
    });
    log("Inserted RatGroup with id=$id");
    return id;
  }

  @override
  Future<bool> update(RateGroup group) async {
    log("Updating RatGroup id=${group.id}");
    final success = await _isar.writeTxn(() async {
      return await _isar.rateGroups.put(group) > 0;
    });
    log(success ? "Update successful id=${group.id}" : "Update failed id=${group.id}");
    return success;
  }

  @override
  Future<bool> delete(int id) async {
    log("Deleting RatGroup id=$id");
    final success = await _isar.writeTxn(() async {
      return await _isar.rateGroups.delete(id);
    });
    log(success ? "Deleted id=$id" : "Delete failed id=$id");
    return success;
  }

  @override
  Future<void> clear() async {
    log("Clearing all RatGroups");
    await _isar.writeTxn(() async {
      await _isar.rateGroups.clear();
    });
    log("Cleared all RatGroups");
  }
}
