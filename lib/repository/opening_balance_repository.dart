import '../model/opening_balance_model.dart';

abstract class OpeningBalanceRepository {
  Future<void> addOpeningBalance(OpeningBalance balance);
  Future<void> addAll(List<OpeningBalance> balances);
  Future<List<OpeningBalance>> getAll();
  Future<List<OpeningBalance>?> getByCustomerCode(String customerCode);
  Future<void> updateOpeningBalance(OpeningBalance balance);
  Future<void> deleteByCustomerCode(String customerCode);
  Future<void> clearAll();
  Future<OpeningBalance?> getByCustomerCodeAndDeductionCode(String customerCode, String deductionCode);
}
