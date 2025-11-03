// lib/repositories/rat_group_repository.dart

import '../model/rate_group.dart';

abstract class RateGroupRepository {
  Future<RateGroup?> getById(int id);
  Future<List<RateGroup>> getAll();
  Future<int> insert(RateGroup group);
  Future<bool> update(RateGroup group);
  Future<bool> delete(int id);
  Future<void> clear();
}
