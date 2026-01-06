import 'dart:developer' as developer;
import 'package:isar/isar.dart';

import '../model/opening_balance_model.dart';
import '../repository/opening_balance_repository.dart';


class IsarOpeningBalanceRepository implements OpeningBalanceRepository {
  final Isar _isar;

  IsarOpeningBalanceRepository(this._isar);

  @override
  Future<void> addOpeningBalance(OpeningBalance balance) async {
    developer.log("Upsert started for ${balance.deductionCode}-${balance.customerCode}");

    final existing = await _isar.openingBalances
        .filter()
        .deductionCodeEqualTo(balance.deductionCode)
        .and()
        .customerCodeEqualTo(balance.customerCode)
        .findFirst();

    await _isar.writeTxn(() async {
      if (existing != null) {
        developer.log("Existing record found → updating...");
        existing.openingBalance = balance.openingBalance;
        existing.crTot = balance.crTot;
        existing.drTot = balance.drTot;
        existing.clBal = balance.clBal;
        existing.clTot = balance.clTot;
        await _isar.openingBalances.put(existing);
      } else {
        developer.log("No record found → inserting new entry...");
        await _isar.openingBalances.put(balance);
      }
    });

    developer.log("Upsert completed successfully.");
  }

  @override
  Future<void> addAll(List<OpeningBalance> balances) async {
    await _isar.writeTxn(() async {
      developer.log("Adding ${balances.length} opening balances");
      await _isar.openingBalances.putAll(balances);
    });
  }

  @override
  Future<List<OpeningBalance>> getAll() async {
    final all = await _isar.openingBalances.where().findAll();
    developer.log("Fetched ${all.length} records");
    return all;
  }

  @override
  Future<List<OpeningBalance>?> getByCustomerCode(String customerCode) async {
    final result = await _isar.openingBalances
        .filter()
        .customerCodeEqualTo(customerCode)
        .findAll();
    developer.log("Fetched record for customerCode=$customerCode → $result");
    return result;
  }

  @override
  Future<void> updateOpeningBalance(OpeningBalance balance) async {
    await _isar.writeTxn(() async {
      developer.log("Updating record for customerCode=${balance.customerCode}");
      await _isar.openingBalances.put(balance);
    });
  }

  @override
  Future<void> deleteByCustomerCode(String customerCode) async {
    await _isar.writeTxn(() async {
      final result = await _isar.openingBalances
          .filter()
          .customerCodeEqualTo(customerCode)
          .findFirst();
      if (result != null) {
        developer.log("Deleting record for $customerCode");
        await _isar.openingBalances.delete(result.id);
      }
    });
  }

  @override
  Future<void> clearAll() async {
    await _isar.writeTxn(() async {
      developer.log("Clearing all opening balances");
      await _isar.openingBalances.clear();
    });
  }

  @override
  Future<OpeningBalance?> getByCustomerCodeAndDeductionCode(String customerCode, String deductionCode)async {
    final result = await _isar.openingBalances
        .filter()
        .customerCodeEqualTo(customerCode)
        .deductionCodeEqualTo(deductionCode)
        .findFirst();
    developer.log("Fetched record for customerCode=$customerCode → $result");
    return result;
  }
}
