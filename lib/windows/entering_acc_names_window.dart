import 'package:flutter/material.dart';
import 'home_window.dart';
import 'main_account_window.dart';
import 'package:intl/intl.dart';

// Data Models and Repository
class MainAccountEntry {
  final String accountNumber;
  final String accountType;
  final String mainAccount;
  final bool showInBalance;

  MainAccountEntry({
    required this.accountNumber,
    required this.accountType,
    required this.mainAccount,
    required this.showInBalance,
  });

  @override
  String toString() {
    return '$accountNumber - $mainAccount ($accountType)';
  }
}

class CreatedAccount {
  final String name;
  final int number;
  final String? mainAccount;
  final String? financialBalance;
  final bool? isJama;

  CreatedAccount({
    required this.name,
    required this.number,
    this.mainAccount,
    this.financialBalance,
    this.isJama,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'number': number,
      'mainAccount': mainAccount,
      'financialBalance': financialBalance,
      'isJama': isJama,
    };
  }

  static CreatedAccount fromMap(Map<String, dynamic> map) {
    return CreatedAccount(
      name: map['name'],
      number: map['number'],
      mainAccount: map['mainAccount'],
      financialBalance: map['financialBalance'],
      isJama: map['isJama'],
    );
  }
}

/// Shared data repository
class DairyDataRepo {
  DairyDataRepo._privateConstructor();
  static final DairyDataRepo instance = DairyDataRepo._privateConstructor();

  // For main account entries from MainAccountWindow
  final ValueNotifier<List<MainAccountEntry>> mainAccountEntries = ValueNotifier<List<MainAccountEntry>>([]);

  // For created accounts from EnteringAccNamesWindow
  final ValueNotifier<int> nextAccountNumber = ValueNotifier<int>(1);
  final ValueNotifier<List<CreatedAccount>> createdAccounts = ValueNotifier<List<CreatedAccount>>([]);

  // Get main account names for dropdown
  List<String> get mainAccountNames {
    return mainAccountEntries.value.map((entry) => entry.mainAccount).toSet().toList()..sort();
  }

  void addMainAccountEntry(MainAccountEntry entry) {
    final list = List<MainAccountEntry>.from(mainAccountEntries.value);
    list.add(entry);
    mainAccountEntries.value = list;
  }

  void updateMainAccountEntry(MainAccountEntry oldEntry, MainAccountEntry newEntry) {
    final list = List<MainAccountEntry>.from(mainAccountEntries.value);
    final index = list.indexWhere((entry) => entry.accountNumber == oldEntry.accountNumber);
    if (index != -1) {
      list[index] = newEntry;
      mainAccountEntries.value = list;
    }
  }

  void deleteMainAccountEntry(MainAccountEntry entry) {
    final list = List<MainAccountEntry>.from(mainAccountEntries.value);
    list.removeWhere((e) => e.accountNumber == entry.accountNumber);
    mainAccountEntries.value = list;
  }

  void incrementAccountNumber() {
    nextAccountNumber.value = nextAccountNumber.value + 1;
  }

  void addCreatedAccount(String name, int number, {String? mainAccount, String? financialBalance, bool? isJama}) {
    final list = List<CreatedAccount>.from(createdAccounts.value);
    list.add(CreatedAccount(
      name: name,
      number: number,
      mainAccount: mainAccount,
      financialBalance: financialBalance,
      isJama: isJama,
    ));
    createdAccounts.value = list;
  }

  void updateCreatedAccount(CreatedAccount oldAccount, CreatedAccount newAccount) {
    final list = List<CreatedAccount>.from(createdAccounts.value);
    final index = list.indexWhere((acc) => acc.number == oldAccount.number);
    if (index != -1) {
      list[index] = newAccount;
      createdAccounts.value = list;
    }
  }

  CreatedAccount? getAccountByNumber(int number) {
    try {
      return createdAccounts.value.firstWhere((acc) => acc.number == number);
    } catch (e) {
      return null;
    }
  }
}

class EnteringAccNamesWindow extends StatefulWidget {
  const EnteringAccNamesWindow({super.key});

  @override
  State<EnteringAccNamesWindow> createState() => _EnteringAccNamesWindowState();
}

class _EnteringAccNamesWindowState extends State<EnteringAccNamesWindow> {
  String? selectedMainAccount;
  final TextEditingController accNameController = TextEditingController();
  final TextEditingController secondaryFieldController = TextEditingController();
  int amountType = 0; // 0 for जमा, 1 for नावे

  int? selectedAccountNumber;
  String? selectedAccountName;

  @override
  void initState() {
    super.initState();
    final repo = DairyDataRepo.instance;
    selectedAccountNumber = repo.nextAccountNumber.value;
  }

  @override
  void dispose() {
    accNameController.dispose();
    secondaryFieldController.dispose();
    super.dispose();
  }

  void _createNewAccount() {
    final repo = DairyDataRepo.instance;
    final accountNumber = selectedAccountNumber ?? repo.nextAccountNumber.value;
    final name = accNameController.text.trim().isEmpty
        ? 'नवीन खाते $accountNumber'
        : accNameController.text.trim();

    final financialBalance = secondaryFieldController.text.trim();

    // Check if we're updating an existing account or creating new one
    final existingAccount = repo.getAccountByNumber(accountNumber);

    if (existingAccount != null) {
      // Update existing account
      final updatedAccount = CreatedAccount(
        name: name,
        number: accountNumber,
        mainAccount: selectedMainAccount,
        financialBalance: financialBalance,
        isJama: amountType == 0, // true for जमा, false for नावे
      );
      repo.updateCreatedAccount(existingAccount, updatedAccount);
    } else {
      // Create new account
      repo.addCreatedAccount(
        name,
        accountNumber,
        mainAccount: selectedMainAccount,
        financialBalance: financialBalance,
        isJama: amountType == 0, // true for जमा, false for नावे
      );
      repo.incrementAccountNumber();
    }

    // Clear fields only if creating new account
    if (existingAccount == null) {
      accNameController.clear();
      secondaryFieldController.clear();
      setState(() {
        selectedAccountNumber = repo.nextAccountNumber.value;
        selectedAccountName = null;
        selectedMainAccount = null;
        amountType = 0;
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('खातं ${existingAccount != null ? 'अपडेट' : 'तयार'} करण्यात आले: $name (क्रमांक: $accountNumber)')),
    );
  }

  void _loadAccountData(int accountNumber) {
    final repo = DairyDataRepo.instance;
    final account = repo.getAccountByNumber(accountNumber);

    if (account != null) {
      setState(() {
        accNameController.text = account.name;
        selectedMainAccount = account.mainAccount;
        secondaryFieldController.text = account.financialBalance ?? '';
        amountType = account.isJama == true ? 0 : 1;
      });
    } else {
      // New account - clear fields
      setState(() {
        accNameController.clear();
        secondaryFieldController.clear();
        selectedMainAccount = null;
        amountType = 0;
      });
    }
  }

  // Helper methods
  String _currentDate() => DateFormat('dd-MM-yyyy').format(DateTime.now());

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 24),
          const SizedBox(width: 10),
          const SelectableText(
            'खाते नावे भरणे',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.schedule, color: Colors.white, size: 14),
                const SizedBox(width: 6),
                SelectableText(
                  'दिनांक: ${_currentDate()}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Center(
      child: Container(
        width: 600,
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: _buildFormSection(),
      ),
    );
  }

  Widget _buildFormSection() {
    final repo = DairyDataRepo.instance;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF8FAFC), Color(0xFFEBF4FF), Color(0xFFDBEAFE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF93C5FD).withOpacity(0.5),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E3A8A).withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Account Number and Name Row
          Row(
            children: [
              // Account Number - Small box
              Expanded(
                child: _buildAccountNumberDropdown(),
              ),
              const SizedBox(width: 10),

              // Account Name - Medium box with text field and dropdown
              Expanded(
                child: _buildAccountNameField(),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Main Account Dropdown - EXTENDED FULL WIDTH
          _buildCustomDropdown(
            label: 'मुख्य खाते',
            value: selectedMainAccount,
            items: repo.mainAccountNames,
            onChanged: (value) {
              setState(() {
                selectedMainAccount = value;
              });
            },
            icon: Icons.account_balance,
          ),
          const SizedBox(height: 16),

          // Financial Balance and Radio Buttons
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Financial Balance Column
              Expanded(
                child: _buildCompactInputField(
                  "आर्थिक शिल्लक",
                  secondaryFieldController,
                  Icons.currency_rupee,
                  hintText: 'शिल्लक रक्कम प्रविष्ट करा',
                ),
              ),
              const SizedBox(width: 16),

              // Radio Buttons Column - UPDATED LIKE POTKHATE
              Expanded(
                child: _buildAmountTypeButtons(),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Action Buttons
          Center(
            child: _buildActionButtons(),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountNumberDropdown() {
    final repo = DairyDataRepo.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'खाते नंबर',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E3A8A),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFFD1D5DB)),
          ),
          child: ValueListenableBuilder<List<CreatedAccount>>(
            valueListenable: repo.createdAccounts,
            builder: (context, createdAccountsList, _) {
              return ValueListenableBuilder<int>(
                valueListenable: repo.nextAccountNumber,
                builder: (context, nextNumber, _) {
                  final allAccountNumbers = {
                    nextNumber,
                    ...createdAccountsList.map((acc) => acc.number)
                  }.toList()..sort();

                  return DropdownButton<int>(
                    value: selectedAccountNumber ?? nextNumber,
                    isExpanded: true,
                    underline: const SizedBox(),
                    icon: const Icon(Icons.arrow_drop_down_rounded, color: Color(0xFF6B7280), size: 20),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E3A8A),
                    ),
                    items: allAccountNumbers.map((number) {
                      return DropdownMenuItem<int>(
                        value: number,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(number.toString()),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedAccountNumber = newValue;
                        _loadAccountData(newValue!);
                      });
                    },
                    menuMaxHeight: 200,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAccountNameField() {
    final repo = DairyDataRepo.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'खाते नाव',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E3A8A),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFFD1D5DB)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: accNameController,
                  style: const TextStyle(fontSize: 15),
                  decoration: const InputDecoration(
                    hintText: 'खाते नाव प्रविष्ट करा',
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ),
              ),
              ValueListenableBuilder<List<CreatedAccount>>(
                valueListenable: repo.createdAccounts,
                builder: (context, createdAccountsList, _) {
                  if (createdAccountsList.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  final accountNames = createdAccountsList.map((account) => account.name).toList();

                  return Container(
                    decoration: BoxDecoration(
                      border: Border(left: BorderSide(color: const Color(0xFFD1D5DB))),
                    ),
                    child: DropdownButton<String>(
                      value: null,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.arrow_drop_down_rounded, size: 20, color: Color(0xFF6B7280)),
                      items: accountNames.map((name) {
                        return DropdownMenuItem<String>(
                          value: name,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              name,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (selectedValue) {
                        if (selectedValue != null) {
                          setState(() {
                            accNameController.text = selectedValue;
                            final account = createdAccountsList.firstWhere(
                                  (acc) => acc.name == selectedValue,
                            );
                            selectedAccountNumber = account.number;
                            _loadAccountData(account.number);
                          });
                        }
                      },
                      menuMaxHeight: 200,
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCustomDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E3A8A),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFFD1D5DB)),
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down_rounded, color: Color(0xFF6B7280), size: 20),
            style: const TextStyle(fontSize: 15, color: Colors.black87),
            hint: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                '$label निवडा',
                style: const TextStyle(fontSize: 15, color: Color(0xFF6B7280)),
              ),
            ),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            dropdownColor: Colors.white,
            elevation: 4,
            menuMaxHeight: 200,
            underline: const SizedBox(),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ],
    );
  }

  Widget _buildCompactInputField(
      String label,
      TextEditingController controller,
      IconData icon, {
        String? hintText,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E3A8A),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 45,
          child: TextField(
            controller: controller,
            style: const TextStyle(fontSize: 15),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(icon, size: 18, color: const Color(0xFF6B7280)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: Color(0xFF2563EB),
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: 15, color: Color(0xFF6B7280)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAmountTypeButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'प्रकार',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E3A8A),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFFD1D5DB)),
          ),
          child: Row(
            children: [
              _buildSwitchButton('जमा', 0, amountType == 0, (value) {
                setState(() => amountType = 0);
              }),
              _buildSwitchButton('नावे', 1, amountType == 1, (value) {
                setState(() => amountType = 1);
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchButton(String label, int value, bool isSelected, ValueChanged<bool> onChanged) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(true),
        child: Container(
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF2563EB) : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : const Color(0xFF374151),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    final repo = DairyDataRepo.instance;

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: [
        _buildNewAccountButton(repo),
        _buildSaveButton(),
        _buildEditButton(),
        _buildStopButton(),
      ],
    );
  }

  Widget _buildNewAccountButton(DairyDataRepo repo) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF3F4F6), Color(0xFFE5E7EB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD1D5DB), width: 1.5),
      ),
      child: ElevatedButton(
        onPressed: () {
          accNameController.clear();
          secondaryFieldController.clear();
          setState(() {
            selectedAccountNumber = repo.nextAccountNumber.value;
            selectedMainAccount = null;
            amountType = 0;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.note_add, size: 16, color: Color(0xFF6B7280)),
            SizedBox(width: 6),
            Text(
              'नवीन',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E3A8A).withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _createNewAccount,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, size: 16, color: Colors.white),
            SizedBox(width: 6),
            Text(
              'जतन करा',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFB923C), Color(0xFFEA580C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFEA580C).withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const MainAccountWindow()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.edit, size: 16, color: Colors.white),
            SizedBox(width: 6),
            Text(
              'संपादन',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStopButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6B7280), Color(0xFF4B5563)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4B5563).withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.stop_circle, size: 16, color: Colors.white),
            SizedBox(width: 6),
            Text(
              'थांबवा',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
          ),
        ),
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _buildMainContent(),
            ),
          ],
        ),
      ),
    );
  }
}