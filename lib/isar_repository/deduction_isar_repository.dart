// lib/repositories/Deduction_repository_isar.dart
import 'package:isar/isar.dart';

import '../model/deduction.dart';
import '../repository/deduction_repository.dart';

class DeductionRepositoryIsar extends DeductionRepository {
  final Isar _isar;

  DeductionRepositoryIsar(this._isar);

  Future<List<Deduction>> getAllDeductions() async {
    try {
      return await _isar.deductions.where().sortByPriority().findAll();
    } catch (e) {
      print('[DeductionRepositoryIsar] getAllDeductions error: $e');
      rethrow;
    }
  }

  @override
  Future<Deduction?> getById(int id) async {
    try {
      return await _isar.deductions.get(id);
    } catch (e) {
      print('[DeductionRepositoryIsar] getById error: $e');
      rethrow;
    }
  }

  @override
  Future<Deduction?> getByCode(String code) async {
    try {
      return await _isar.deductions.filter().codeEqualTo(code).findFirst();
    } catch (e) {
      print('[DeductionRepositoryIsar] getByCode error: $e');
      rethrow;
    }
  }

  @override
  Future<int> insertDeduction(Deduction Deduction) async {
    try {
      return await _isar.writeTxn<int>(() async {
        return await _isar.deductions.put(Deduction);
      });
    } catch (e) {
      print('[DeductionRepositoryIsar] insertDeduction error: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateDeduction(Deduction Deduction) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.deductions.put(Deduction);
      });
    } catch (e) {
      print('[DeductionRepositoryIsar] updateDeduction error: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteDeduction(int id) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.deductions.delete(id);
      });
    } catch (e) {
      print('[DeductionRepositoryIsar] deleteDeduction error: $e');
      rethrow;
    }
  }

  @override
  Future<void> clearAllDeductions() async {
    try {
      await _isar.writeTxn(() async {
        await _isar.deductions.clear();
      });
    } catch (e) {
      print('[DeductionRepositoryIsar] clearAllDeductions error: $e');
      rethrow;
    }
  }
  @override
  Future<void> clearAll() async {
    try {
      await _isar.writeTxn(() async {
        await _isar.deductions.clear();
      });
      print('[DeductionRepositoryIsar] ✅ Cleared all records');
    } catch (e, st) {
      print('[DeductionRepositoryIsar] ❌ clearAll error: $e\n$st');
      rethrow;
    }
  }

  @override
  Future<int> create(Deduction item) async {
    try {
      final id = await _isar.writeTxn<int>(() async {
        return await _isar.deductions.put(item);
      });
      print('[DeductionRepositoryIsar] ✅ Created Deduction ID: $id');
      return id;
    } catch (e, st) {
      print('[DeductionRepositoryIsar] ❌ create error: $e\n$st');
      rethrow;
    }
  }

  @override
  Future<void> delete(int id) async {
    try {
      await _isar.writeTxn(() async {
        final success = await _isar.deductions.delete(id);
        print('[DeductionRepositoryIsar] ✅ Delete ID: $id -> $success');
      });
    } catch (e, st) {
      print('[DeductionRepositoryIsar] ❌ delete error: $e\n$st');
      rethrow;
    }
  }

  @override
  Future<List<Deduction>> getAll({
    bool sortByPriority = true,
    bool ascending = true,
  }) async {
    try {
      final query = _isar.deductions.where();

      if (sortByPriority) {
        return ascending
            ? await query.sortByPriority().findAll()
            : await query.sortByPriorityDesc().findAll();
      } else {
        return await query.findAll();
      }
    } catch (e, st) {
      print('[DeductionRepositoryIsar] ❌ getAll error: $e\n$st');
      rethrow;
    }
  }

  @override
  Future<void> update(Deduction item) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.deductions.put(item);
      });
      print('[DeductionRepositoryIsar] ✅ Updated ID: ${item.id}');
    } catch (e, st) {
      print('[DeductionRepositoryIsar] ❌ update error: $e\n$st');
      rethrow;
    }
  }

  @override
  Stream<List<Deduction>> watchAll() {
    try {
      final stream = _isar.deductions
          .where()
          .watch(fireImmediately: true)
          .map((list) => list..sort((a, b) => a.priority.compareTo(b.priority)));

      print('[DeductionRepositoryIsar] 👀 Watching all deductions...');
      return stream;
    } catch (e, st) {
      print('[DeductionRepositoryIsar] ❌ watchAll error: $e\n$st');
      rethrow;
    }
  }
}
