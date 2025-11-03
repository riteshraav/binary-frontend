import 'package:isar/isar.dart';
import 'dart:developer';

import '../model/deduction_entry_model.dart';
import '../repository/deduction_entry_repository.dart';


class IsarDeductionEntryRepository implements DeductionRepository {
  final Isar _isar;

  IsarDeductionEntryRepository(this._isar);

  @override
  Future<void> addDeduction(DeductionEntry entry) async {
    log('🟢 Adding DeductionEntry: ${entry.toJson()}');
    await _isar.writeTxn(() async {
      await _isar.deductionEntrys.put(entry);
    });
  }

  @override
  Future<List<DeductionEntry>> getAllDeductions() async {
    log('📥 Fetching all DeductionEntries from Isar');
    return await _isar.deductionEntrys.where().findAll();
  }

  @override
  Future<void> deleteDeduction(int id) async {
    log('🗑️ Deleting DeductionEntry with id: $id');
    await _isar.writeTxn(() async {
      await _isar.deductionEntrys.delete(id);
    });
  }

  @override
  Future<void> clearAll() async {
    log('⚠️ Clearing all DeductionEntries');
    await _isar.writeTxn(() async {
      await _isar.deductionEntrys.clear();
    });
  }
}
