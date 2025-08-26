import 'package:isar/isar.dart';

import '../model/bank_model.dart';
import '../repository/brank_master_repository.dart';


class BankRepositoryIsar extends BankRepository {
  final Isar _isar;

  BankRepositoryIsar(this._isar);

  @override
  Future<List<BankMaster>> getAllBanks() async {
    return await _isar.bankMasters.where().findAll();
  }

  @override
  Future<BankMaster?> getBankById(Id id) async {
    return await _isar.bankMasters.get(id);
  }

  @override
  Future<BankMaster?> getBankByCode(int code) async {
    return await _isar.bankMasters
        .filter()
        .codeEqualTo(code)
        .findFirst();
  }

  @override
  Future<List<BankMaster>> getBanksByName(String name) async {
    return await _isar.bankMasters
        .filter()
        .nameContains(name, caseSensitive: false)
        .findAll();
  }

  @override
  Future<BankMaster?> getBankByIfsc(String ifsc) async {
    return await _isar.bankMasters
        .filter()
        .ifscEqualTo(ifsc)
        .findFirst();
  }

  @override
  Future<BankMaster> addBank(BankMaster bank) async {
    await _isar.writeTxn(() async {
      await _isar.bankMasters.put(bank);
    });
    return bank;
  }

  @override
  Future<List<BankMaster>> addBanks(List<BankMaster> banks) async {
    await _isar.writeTxn(() async {
      await _isar.bankMasters.putAll(banks);
    });
    return banks;
  }

  @override
  Future<BankMaster> updateBank(BankMaster bank) async {
    await _isar.writeTxn(() async {
      await _isar.bankMasters.put(bank);
    });
    return bank;
  }

  @override
  Future<bool> deleteBankById(Id id) async {
    bool deleted = false;
    await _isar.writeTxn(() async {
      deleted = await _isar.bankMasters.delete(id);
    });
    return deleted;
  }

  @override
  Future<bool> deleteBankByCode(int code) async {
    bool deleted = false;
    await _isar.writeTxn(() async {
      final bank = await _isar.bankMasters
          .filter()
          .codeEqualTo(code)
          .findFirst();
      if (bank != null) {
        deleted = await _isar.bankMasters.delete(bank.id);
      }
    });
    return deleted;
  }

  @override
  Future<void> deleteAllBanks() async {
    await _isar.writeTxn(() async {
      await _isar.bankMasters.clear();
    });
  }

  @override
  Future<bool> bankExistsByCode(int code) async {
    final count = await _isar.bankMasters
        .filter()
        .codeEqualTo(code)
        .count();
    return count > 0;
  }

  @override
  Future<bool> bankExistsByIfsc(String ifsc) async {
    final count = await _isar.bankMasters
        .filter()
        .ifscEqualTo(ifsc)
        .count();
    return count > 0;
  }

  @override
  Future<int> getBanksCount() async {
    return await _isar.bankMasters.count();
  }

}