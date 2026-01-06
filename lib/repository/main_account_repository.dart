// main_account_repository.dart
import 'package:flutter/foundation.dart';
import '../windows/entering_acc_names_window.dart';

abstract class MainAccountRepository {
  // CRUD operations
  Future<void> addMainAccountEntry(MainAccountEntry entry);
  Future<void> updateMainAccountEntry(MainAccountEntry oldEntry, MainAccountEntry newEntry);
  Future<void> deleteMainAccountEntry(MainAccountEntry entry);

  // Query operations
  Future<List<MainAccountEntry>> getAllEntries();
  Future<MainAccountEntry?> getEntryByAccountNumber(String accountNumber);
  Future<List<String>> getMainAccountNames();
  Future<bool> isAccountNumberUnique(String accountNumber, {String? excludeAccountNumber});

  // Stream for real-time updates
  Stream<List<MainAccountEntry>> watchAllEntries();

  // ValueListenable for ValueListenableBuilder
  ValueListenable<List<MainAccountEntry>> get entriesListenable;

  // Close database
  Future<void> close();
}