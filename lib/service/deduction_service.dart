// deduction_service_impl.dart
import '../model/deduction.dart';

import '../repository/deduction_repository.dart';

class DeductionServiceImpl {
  final DeductionRepository _repo;

  DeductionServiceImpl(this._repo);

  Future<int> createDeduction(Deduction item) async {
    try {
      _validateDeduction(item);
      final id = await _repo.create(item);
      print('[DeductionService] ✅ Created deduction with ID: $id');
      return id;
    } catch (e, st) {
      print('[DeductionService] ❌ createDeduction error: $e\n$st');
      rethrow;
    }
  }

  Future<void> updateDeduction(Deduction item) async { 
    try {
      _validateDeduction(item, isUpdate: true);
      await _repo.update(item);
      print('[DeductionService] ✅ Updated deduction: ${item.id}');
    } catch (e, st) {
      print('[DeductionService] ❌ updateDeduction error: $e\n$st');
      rethrow;
    }
  }

  Future<void> deleteDeduction(int id) async {
    try {
      await _repo.delete(id);
      print('[DeductionService] 🗑️ Deleted deduction ID: $id');
    } catch (e, st) {
      print('[DeductionService] ❌ deleteDeduction error: $e\n$st');
      rethrow;
    }
  }

  Future<List<Deduction>> fetchAllDeductions({
    bool sortByPriority = true,
    bool ascending = true,
  }) async {
    try {
      final list = await _repo.getAll(
        sortByPriority: sortByPriority,
        ascending: ascending,
      );
      print('[DeductionService] 📊 Loaded ${list.length} deductions');
      return list;
    } catch (e, st) {
      print('[DeductionService] ❌ fetchAllDeductions error: $e\n$st');
      rethrow;
    }
  }

  Future<void> clearAll() async {
    try {
      await _repo.clearAll();
      print('[DeductionService] 🧹 Cleared all deductions');
    } catch (e, st) {
      print('[DeductionService] ❌ clearAll error: $e\n$st');
      rethrow;
    }
  }

  Stream<List<Deduction>> watchAllDeductions() {
    try {
      print('[DeductionService] 👀 Watching deduction stream...');
      return _repo.watchAll();
    } catch (e, st) {
      print('[DeductionService] ❌ watchAllDeductions error: $e\n$st');
      rethrow;
    }
  }

  // Internal validation
  void _validateDeduction(Deduction item, {bool isUpdate = false}) {

    if (item.name.trim().isEmpty) throw ArgumentError('Deduction name is required.');
    if (item.code.trim().isEmpty) throw ArgumentError('Deduction code is required.');
    if (item.rate < 0) throw ArgumentError('Rate must be non-negative.');
  }
}
