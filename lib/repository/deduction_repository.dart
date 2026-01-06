// file: repositories/deductoin_repository.dart

import '../model/deduction.dart';

abstract class DeductionRepository {
  /// Insert a new record and return generated id
  Future<int> create(Deduction item);

  /// Get by id
  Future<Deduction?> getById(int id);

  /// Get by unique code
  Future<Deduction?> getByCode(String code);

  /// Get all (optionally sorted)
  Future<List<Deduction>> getAll({bool sortByPriority = true, bool ascending = true});

  /// Update existing
  Future<void> update(Deduction item);

  /// Delete by id
  Future<void> delete(int id);

  /// Watch all changes (useful for UI)
  Stream<List<Deduction>> watchAll();

  /// Clear all entries (if needed)
  Future<void> clearAll();
}
