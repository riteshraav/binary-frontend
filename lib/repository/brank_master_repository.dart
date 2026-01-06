
// bank_repository.dart
import 'package:isar/isar.dart';

import '../model/bank_model.dart';

abstract class BankRepository {
  /// Get all banks
  Future<List<BankMaster>> getAllBanks();

  /// Get bank by ID
  Future<BankMaster?> getBankById(Id id);

  /// Get bank by code
  Future<BankMaster?> getBankByCode(int code);

  /// Get banks by name (partial match)
  Future<List<BankMaster>> getBanksByName(String name);

  /// Get banks by IFSC code
  Future<BankMaster?> getBankByIfsc(String ifsc);

  /// Add a new bank
  Future<BankMaster> addBank(BankMaster bank);

  /// Add multiple banks
  Future<List<BankMaster>> addBanks(List<BankMaster> banks);

  /// Update existing bank
  Future<BankMaster> updateBank(BankMaster bank);

  /// Delete bank by ID
  Future<bool> deleteBankById(Id id);

  /// Delete bank by code
  Future<bool> deleteBankByCode(int code);

  /// Delete all banks
  Future<void> deleteAllBanks();

  /// Check if bank exists by code
  Future<bool> bankExistsByCode(int code);

  /// Check if bank exists by IFSC
  Future<bool> bankExistsByIfsc(String ifsc);

  /// Get banks count
  Future<int> getBanksCount();
  
}