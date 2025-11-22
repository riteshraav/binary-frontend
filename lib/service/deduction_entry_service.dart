import 'dart:developer';

import '../model/deduction_entry_model.dart';
import '../repository/deduction_entry_repository.dart';


class DeductionEntryService {
  final DeductionRepository _repository;

  DeductionEntryService(this._repository);

  Future<void> addDeductionFromJson(DeductionEntry entry) async {
    try {

      await _repository.addDeduction(entry);
    } catch (e, st) {
      log('❌ Error in addDeductionFromJson: $e', stackTrace: st);
    }
  }

  Future<List<DeductionEntry>> fetchAllDeductions() async {
    try {
      final data = await _repository.getAllDeductions();
      log('📊 Total deductions fetched: ${data.length}');
      return data;
    } catch (e, st) {
      log('❌ Error in fetchAllDeductions: $e', stackTrace: st);
      return [];
    }
  }

  Future<void> removeDeduction(int id) async {
    log('🗑️ Removing deduction ID $id');
    await _repository.deleteDeduction(id);
  }

  Future<void> resetAll() async {
    log('🔄 Clearing all deduction entries');
    await _repository.clearAll();
  }
}
