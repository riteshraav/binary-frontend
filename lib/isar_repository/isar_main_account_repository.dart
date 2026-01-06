import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import '../repository/main_account_repository.dart';
import '../windows/entering_acc_names_window.dart';

part 'isar_main_account_repository.g.dart';

@collection
class IsarMainAccountEntry {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String accountNumber;

  late String accountType;
  late String mainAccount;
  late bool showInBalance;

  MainAccountEntry toMainAccountEntry() {
    return MainAccountEntry(
      accountNumber: accountNumber,
      accountType: accountType,
      mainAccount: mainAccount,
      showInBalance: showInBalance,
    );
  }

  static IsarMainAccountEntry fromMainAccountEntry(MainAccountEntry entry) {
    return IsarMainAccountEntry()
      ..accountNumber = entry.accountNumber
      ..accountType = entry.accountType
      ..mainAccount = entry.mainAccount
      ..showInBalance = entry.showInBalance;
  }
}

class IsarMainAccountRepository implements MainAccountRepository {
  static IsarMainAccountRepository? _instance;

  factory IsarMainAccountRepository() {
    _instance ??= IsarMainAccountRepository._();
    return _instance!;
  }

  IsarMainAccountRepository._();

  late Isar _isar;
  bool _isInitialized = false;

  // ValueNotifier for ValueListenableBuilder
  final ValueNotifier<List<MainAccountEntry>> _entriesNotifier =
  ValueNotifier<List<MainAccountEntry>>([]);

  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      final dir = await getApplicationDocumentsDirectory();
      _isar = await Isar.open(
        [IsarMainAccountEntrySchema],
        directory: dir.path,
        name: 'MainAccountDB',
      );
      _isInitialized = true;

      // Load initial data
      _loadInitialEntries();
    }
  }

  void _loadInitialEntries() async {
    if (_isInitialized) {
      final entries = await getAllEntries();
      _entriesNotifier.value = entries;
    }
  }

  void _updateNotifier(List<MainAccountEntry> entries) {
    _entriesNotifier.value = entries;
  }

  // Getter for ValueListenableBuilder
  ValueListenable<List<MainAccountEntry>> get entriesListenable => _entriesNotifier;

  @override
  Future<void> addMainAccountEntry(MainAccountEntry entry) async {
    await _ensureInitialized();

    await _isar.writeTxn(() async {
      // Check for duplicate account number
      final existing = await _isar.isarMainAccountEntrys
          .where()
          .accountNumberEqualTo(entry.accountNumber)
          .findFirst();

      if (existing != null) {
        throw Exception('Account number ${entry.accountNumber} already exists');
      }

      final isarEntry = IsarMainAccountEntry.fromMainAccountEntry(entry);
      await _isar.isarMainAccountEntrys.put(isarEntry);
    });

    // Update notifier after adding
    final updatedEntries = await getAllEntries();
    _updateNotifier(updatedEntries);
  }

  @override
  Future<void> updateMainAccountEntry(MainAccountEntry oldEntry, MainAccountEntry newEntry) async {
    await _ensureInitialized();

    await _isar.writeTxn(() async {
      final existing = await _isar.isarMainAccountEntrys
          .where()
          .accountNumberEqualTo(oldEntry.accountNumber)
          .findFirst();

      if (existing != null) {
        // Update the existing entry
        existing.accountNumber = newEntry.accountNumber;
        existing.accountType = newEntry.accountType;
        existing.mainAccount = newEntry.mainAccount;
        existing.showInBalance = newEntry.showInBalance;

        await _isar.isarMainAccountEntrys.put(existing);
      }
    });

    // Update notifier after updating
    final updatedEntries = await getAllEntries();
    _updateNotifier(updatedEntries);
  }

  @override
  Future<void> deleteMainAccountEntry(MainAccountEntry entry) async {
    await _ensureInitialized();

    await _isar.writeTxn(() async {
      final existing = await _isar.isarMainAccountEntrys
          .where()
          .accountNumberEqualTo(entry.accountNumber)
          .findFirst();

      if (existing != null) {
        await _isar.isarMainAccountEntrys.delete(existing.id);
      }
    });

    // Update notifier after deleting
    final updatedEntries = await getAllEntries();
    _updateNotifier(updatedEntries);
  }

  @override
  Future<List<MainAccountEntry>> getAllEntries() async {
    await _ensureInitialized();

    final entries = await _isar.isarMainAccountEntrys.where().findAll();
    return entries.map((e) => e.toMainAccountEntry()).toList();
  }

  @override
  Future<MainAccountEntry?> getEntryByAccountNumber(String accountNumber) async {
    await _ensureInitialized();

    final entry = await _isar.isarMainAccountEntrys
        .where()
        .accountNumberEqualTo(accountNumber)
        .findFirst();

    return entry?.toMainAccountEntry();
  }

  @override
  Future<List<String>> getMainAccountNames() async {
    await _ensureInitialized();

    final entries = await getAllEntries();
    final names = entries.map((e) => e.mainAccount).toSet().toList();
    names.sort();
    return names;
  }

  @override
  Future<bool> isAccountNumberUnique(String accountNumber, {String? excludeAccountNumber}) async {
    await _ensureInitialized();

    final existing = await getEntryByAccountNumber(accountNumber);
    if (existing == null) return true;

    return excludeAccountNumber != null && existing.accountNumber == excludeAccountNumber;
  }

  @override
  Stream<List<MainAccountEntry>> watchAllEntries() {
    if (!_isInitialized) {
      return Stream.value([]);
    }

    return _isar.isarMainAccountEntrys
        .where()
        .watch(fireImmediately: true)
        .asyncMap((isarEntries) async {
      final entries = isarEntries.map((e) => e.toMainAccountEntry()).toList();
      _updateNotifier(entries); // Update notifier when stream emits
      return entries;
    });
  }

  @override
  Future<void> close() async {
    if (_isInitialized) {
      await _isar.close();
      _isInitialized = false;
    }
  }
}