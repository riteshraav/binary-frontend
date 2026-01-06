// main_account_service.dart
import '../repository/main_account_repository.dart';
import '../windows/entering_acc_names_window.dart';

class MainAccountService {
  final MainAccountRepository repository;

  MainAccountService(this.repository);

  // Business logic for adding account
  Future<void> addAccount({
    required String accountNumber,
    required String accountType,
    required String mainAccount,
    required bool showInBalance,
  }) async {
    // Validate business rules
    if (accountNumber.isEmpty) {
      throw Exception('अनु. नं. आवश्यक आहे');
    }
    if (accountType.isEmpty) {
      throw Exception('खाते प्रकार निवडा');
    }
    if (mainAccount.isEmpty) {
      throw Exception('मुख्य खाते नाव आवश्यक आहे');
    }

    // Check uniqueness
    final isUnique = await repository.isAccountNumberUnique(accountNumber);
    if (!isUnique) {
      throw Exception('हा अनु. नं. आधीच वापरात आहे');
    }

    final entry = MainAccountEntry(
      accountNumber: accountNumber,
      accountType: accountType,
      mainAccount: mainAccount,
      showInBalance: showInBalance,
    );

    await repository.addMainAccountEntry(entry);
  }

  // Business logic for updating account
  Future<void> updateAccount({
    required MainAccountEntry oldEntry,
    required String newAccountNumber,
    required String newAccountType,
    required String newMainAccount,
    required bool newShowInBalance,
  }) async {
    // Validate business rules
    if (newAccountNumber.isEmpty) {
      throw Exception('अनु. नं. आवश्यक आहे');
    }
    if (newAccountType.isEmpty) {
      throw Exception('खाते प्रकार निवडा');
    }
    if (newMainAccount.isEmpty) {
      throw Exception('मुख्य खाते नाव आवश्यक आहे');
    }

    // Check uniqueness (excluding current account number)
    final isUnique = await repository.isAccountNumberUnique(
      newAccountNumber,
      excludeAccountNumber: oldEntry.accountNumber,
    );
    if (!isUnique) {
      throw Exception('हा अनु. नं. आधीच वापरात आहे');
    }

    final newEntry = MainAccountEntry(
      accountNumber: newAccountNumber,
      accountType: newAccountType,
      mainAccount: newMainAccount,
      showInBalance: newShowInBalance,
    );

    await repository.updateMainAccountEntry(oldEntry, newEntry);
  }

  // Business logic for deleting account
  Future<void> deleteAccount(MainAccountEntry entry) async {
    await repository.deleteMainAccountEntry(entry);
  }

  // Get all entries
  Future<List<MainAccountEntry>> getAllEntries() async {
    return await repository.getAllEntries();
  }

  // Check if account number is unique
  Future<bool> isAccountNumberUnique(String accountNumber, {String? excludeAccountNumber}) async {
    return await repository.isAccountNumberUnique(
        accountNumber,
        excludeAccountNumber: excludeAccountNumber
    );
  }

  // Get all account types with business logic
  List<String> getAccountTypes() {
    return [
      'देणेकरी',
      'शिल्लक माल',
      'नफा तोटा (जमा)',
      'नफा तोटा (नावे)',
      'रोख व बँक शिल्लक',
      'ताळेबंद (इतर)',
      'व्यापारी(जमा)',
      'व्यापारी(नावे)',
      'येणेकरी'
    ];
  }

  // Get display name with business logic
  String getAccountTypeDisplayName(String accountType, bool saveInTalebandh) {
    if (accountType == 'ताळेबंद (इतर)' && saveInTalebandh) {
      return 'ताळेबंद';
    }
    return accountType;
  }

  // Stream for UI updates
  Stream<List<MainAccountEntry>> watchAllEntries() {
    return repository.watchAllEntries();
  }

  // Get main account names
  Future<List<String>> getMainAccountNames() async {
    return await repository.getMainAccountNames();
  }

  // Get entry by account number
  Future<MainAccountEntry?> getEntryByAccountNumber(String accountNumber) async {
    return await repository.getEntryByAccountNumber(accountNumber);
  }

  // Close repository
  Future<void> close() async {
    await repository.close();
  }

  // Getter to access repository directly for ValueListenableBuilder
  MainAccountRepository get repo => repository;
}