import '../model/deduction_entry_model.dart';

abstract class DeductionRepository {
  Future<void> addDeduction(DeductionEntry entry);
  Future<List<DeductionEntry>> getAllDeductions();
  Future<void> deleteDeduction(int id);
  Future<void> clearAll();
}
