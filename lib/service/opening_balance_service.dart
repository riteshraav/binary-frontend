import 'dart:developer' as developer;

import '../model/opening_balance_model.dart';
import '../repository/opening_balance_repository.dart';


class OpeningBalanceService {
  final OpeningBalanceRepository _repository;

  OpeningBalanceService(this._repository);

  Future<void> addBalance(OpeningBalance balance) async {
    developer.log("Service: Adding new opening balance");
    await _repository.addOpeningBalance(balance);
  }

  Future<void> importBalances(List<OpeningBalance> list) async {
    developer.log("Service: Importing ${list.length} opening balances");
    await _repository.addAll(list);
  }

  Future<List<OpeningBalance>> fetchAllBalances() async {
    developer.log("Service: Fetching all balances");
    return await _repository.getAll();
  }

  Future<List<OpeningBalance>?> findBalance(String customerCode) async {
    developer.log("Service: Searching for $customerCode");
    return await _repository.getByCustomerCode(customerCode);
  }

  Future<void> updateBalance(OpeningBalance balance) async {
    developer.log("Service: Updating balance for ${balance.customerCode}");
    await _repository.updateOpeningBalance(balance);
  }

  Future<void> deleteBalance(String customerCode) async {
    developer.log("Service: Deleting balance for $customerCode");
    await _repository.deleteByCustomerCode(customerCode);
  }

  Future<void> clearAllBalances() async {
    developer.log("Service: Clearing all balances");
    await _repository.clearAll();
  }

  Future<OpeningBalance?> findBalanceByCustomerAndDeduction(String customerCode, String deductionCode) async{

    developer.log("Service: Searching for $customerCode and $deductionCode");
    return await _repository.getByCustomerCodeAndDeductionCode(customerCode,deductionCode);
  }
}
