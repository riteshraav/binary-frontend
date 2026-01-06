import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'entering_acc_names_window.dart';
import 'home_window.dart';

class SubAccountEntry {
  final String name;
  final int number;
  final String? mainAccount;
  final String? openingBalance;
  final bool? isCredit;
  final String? lastAuditDate;

  SubAccountEntry({
    required this.name,
    required this.number,
    this.mainAccount,
    this.openingBalance,
    this.isCredit,
    this.lastAuditDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'number': number,
      'mainAccount': mainAccount,
      'openingBalance': openingBalance,
      'isCredit': isCredit,
      'lastAuditDate': lastAuditDate,
    };
  }

  static SubAccountEntry fromMap(Map<String, dynamic> map) {
    return SubAccountEntry(
      name: map['name'],
      number: map['number'],
      mainAccount: map['mainAccount'],
      openingBalance: map['openingBalance'],
      isCredit: map['isCredit'],
      lastAuditDate: map['lastAuditDate'],
    );
  }
}

class SubAccountDataRepo {
  SubAccountDataRepo._privateConstructor();
  static final SubAccountDataRepo instance = SubAccountDataRepo._privateConstructor();

  final ValueNotifier<int> nextAccountNumber = ValueNotifier<int>(1);
  final ValueNotifier<List<SubAccountEntry>> createdSubAccounts = ValueNotifier<List<SubAccountEntry>>([]);

  void incrementAccountNumber() {
    nextAccountNumber.value = nextAccountNumber.value + 1;
  }

  void addSubAccountEntry(SubAccountEntry entry) {
    final list = List<SubAccountEntry>.from(createdSubAccounts.value);
    list.add(entry);
    createdSubAccounts.value = list;
  }

  void updateSubAccountEntry(SubAccountEntry oldEntry, SubAccountEntry newEntry) {
    final list = List<SubAccountEntry>.from(createdSubAccounts.value);
    final index = list.indexWhere((entry) => entry.number == oldEntry.number);
    if (index != -1) {
      list[index] = newEntry;
      createdSubAccounts.value = list;
    }
  }

  SubAccountEntry? getSubAccountByNumber(int number) {
    try {
      return createdSubAccounts.value.firstWhere((acc) => acc.number == number);
    } catch (e) {
      return null;
    }
  }

  List<String> get subAccountNames {
    return createdSubAccounts.value.map((entry) => entry.name).toList();
  }
}

class EnteringSubAccountNamesWindow extends StatefulWidget {
  const EnteringSubAccountNamesWindow({super.key});

  @override
  State<EnteringSubAccountNamesWindow> createState() =>
      _EnteringSubAccountNamesWindowState();
}

class _EnteringSubAccountNamesWindowState
    extends State<EnteringSubAccountNamesWindow> {
  final TextEditingController openingBalanceController = TextEditingController();
  final TextEditingController subAccountController = TextEditingController();
  final TextEditingController lastAuditDateController = TextEditingController();

  String? selectedMainAccount;
  bool isCredit = true;

  // Simulated main account list (this data comes from main_account_window)
  List<String> mainAccounts = [
    'Milk Purchase Account',
    'Feed Purchase Account',
    'Staff Salary Account',
    'Maintenance Account',
    'Transport Account',
    'Electricity Account',
    'Water Bill Account',
    'Medical Account',
  ];

  int? selectedAccountNumber;
  String? selectedAccountName;

  @override
  void initState() {
    super.initState();
    final repo = SubAccountDataRepo.instance;
    selectedAccountNumber = repo.nextAccountNumber.value;

    // Set default last audit date to today
    final now = DateTime.now();
    lastAuditDateController.text = DateFormat('dd-MM-yyyy').format(now);
  }

  @override
  void dispose() {
    openingBalanceController.dispose();
    subAccountController.dispose();
    lastAuditDateController.dispose();
    super.dispose();
  }

  void _createSubAccount() {
    final repo = SubAccountDataRepo.instance;
    final accountNumber = selectedAccountNumber ?? repo.nextAccountNumber.value;
    final name = subAccountController.text.trim().isEmpty
        ? 'पोट खाते $accountNumber'
        : subAccountController.text.trim();

    final openingBalance = openingBalanceController.text.trim();
    final lastAuditDate = lastAuditDateController.text.trim();

    // Check if we're updating an existing account or creating new one
    final existingAccount = repo.getSubAccountByNumber(accountNumber);

    if (existingAccount != null) {
      // Update existing account
      final updatedAccount = SubAccountEntry(
        name: name,
        number: accountNumber,
        mainAccount: selectedMainAccount,
        openingBalance: openingBalance,
        isCredit: isCredit,
        lastAuditDate: lastAuditDate,
      );
      repo.updateSubAccountEntry(existingAccount, updatedAccount);
    } else {
      // Create new account
      repo.addSubAccountEntry(SubAccountEntry(
        name: name,
        number: accountNumber,
        mainAccount: selectedMainAccount,
        openingBalance: openingBalance,
        isCredit: isCredit,
        lastAuditDate: lastAuditDate,
      ));
      repo.incrementAccountNumber();
    }

    // Clear fields only if creating new account
    if (existingAccount == null) {
      _clearForm();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('पोट खाते ${existingAccount != null ? 'अपडेट' : 'तयार'} करण्यात आले: $name (क्रमांक: $accountNumber)')),
    );
  }

  void _loadSubAccountData(int accountNumber) {
    final repo = SubAccountDataRepo.instance;
    final account = repo.getSubAccountByNumber(accountNumber);

    if (account != null) {
      setState(() {
        subAccountController.text = account.name;
        selectedMainAccount = account.mainAccount;
        openingBalanceController.text = account.openingBalance ?? '';
        isCredit = account.isCredit ?? true;
        lastAuditDateController.text = account.lastAuditDate ?? '';
      });
    } else {
      // New account - clear fields
      _clearForm();
    }
  }

  void _clearForm() {
    setState(() {
      final repo = SubAccountDataRepo.instance;
      selectedAccountNumber = repo.nextAccountNumber.value;
      subAccountController.clear();
      selectedMainAccount = null;
      openingBalanceController.clear();
      isCredit = true;
      final now = DateTime.now();
      lastAuditDateController.text = DateFormat('dd-MM-yyyy').format(now);
    });
  }

  // Helper methods
  String _currentDate() => DateFormat('dd-MM-yyyy').format(DateTime.now());

  // Method to show date picker
  Future<void> _selectLastAuditDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        lastAuditDateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.account_tree_rounded, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          const SelectableText(
            'पोट खाते नावे भरणे',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.schedule, color: Colors.white, size: 12),
                const SizedBox(width: 4),
                SelectableText(
                  'दिनांक: ${_currentDate()}',
                  style: const TextStyle(color: Colors.white, fontSize: 11),
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
        width: 550, // Reduced width
        height: 520, // Fixed height to prevent overflow
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16), // Reduced padding
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: _buildFormSection(),
      ),
    );
  }

  Widget _buildFormSection() {
    final repo = SubAccountDataRepo.instance;

    return Container(
      margin: const EdgeInsets.all(8), // Reduced margin
      padding: const EdgeInsets.all(16), // Reduced padding
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF8FAFC), Color(0xFFEBF4FF), Color(0xFFDBEAFE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF93C5FD).withOpacity(0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E3A8A).withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Account Number and Sub Account Name Row
          Row(
            children: [
              // Account Number - Smaller box
              Expanded(
                flex: 2,
                child: _buildAccountNumberDropdown(repo),
              ),
              const SizedBox(width: 8),

              // Sub Account Name - Smaller box
              Expanded(
                flex: 3,
                child: _buildSubAccountNameField(repo),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Main Account Dropdown with New Button
          Row(
            children: [
              Expanded(
                flex: 4,
                child: _buildCustomDropdown(
                  label: 'मुख्य खाते',
                  value: selectedMainAccount,
                  items: mainAccounts,
                  onChanged: (value) {
                    setState(() {
                      selectedMainAccount = value;
                    });
                  },
                  icon: Icons.account_balance,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: _buildNewMainAccountButton(),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Opening Balance and Balance Type
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Opening Balance Column
              Expanded(
                child: _buildCompactInputField(
                  "आरंभी शिल्लक",
                  openingBalanceController,
                  Icons.currency_rupee,
                  hintText: 'शिल्लक रक्कम',
                ),
              ),
              const SizedBox(width: 12),

              // Balance Type Column
              Expanded(
                child: _buildBalanceTypeButtons(),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Last Audit Date Field
          _buildLastAuditDateField(),
          const SizedBox(height: 4),
          const Padding(
            padding: EdgeInsets.only(left: 4),
            child: Text(
              'या दिनांकापासून नवीन नोंदीची गणना सुरू होईल',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Action Buttons - Smaller and compact
          Center(
            child: _buildActionButtons(repo),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountNumberDropdown(SubAccountDataRepo repo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'खाते नंबर',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E3A8A),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 40, // Reduced height
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFFD1D5DB)),
          ),
          child: ValueListenableBuilder<List<SubAccountEntry>>(
            valueListenable: repo.createdSubAccounts,
            builder: (context, subAccountsList, _) {
              return ValueListenableBuilder<int>(
                valueListenable: repo.nextAccountNumber,
                builder: (context, nextNumber, _) {
                  final allAccountNumbers = {
                    nextNumber,
                    ...subAccountsList.map((acc) => acc.number)
                  }.toList()..sort();

                  return DropdownButton<int>(
                    value: selectedAccountNumber ?? nextNumber,
                    isExpanded: true,
                    underline: const SizedBox(),
                    icon: const Icon(Icons.arrow_drop_down_rounded, color: Color(0xFF6B7280), size: 18),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E3A8A),
                    ),
                    items: allAccountNumbers.map((number) {
                      return DropdownMenuItem<int>(
                        value: number,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(number.toString()),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedAccountNumber = newValue;
                        _loadSubAccountData(newValue!);
                      });
                    },
                    menuMaxHeight: 180,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSubAccountNameField(SubAccountDataRepo repo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'पोट खाते नाव',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E3A8A),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 40, // Reduced height
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFFD1D5DB)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: subAccountController,
                  style: const TextStyle(fontSize: 13),
                  decoration: const InputDecoration(
                    hintText: 'पोट खाते नाव',
                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ),
              ),
              ValueListenableBuilder<List<SubAccountEntry>>(
                valueListenable: repo.createdSubAccounts,
                builder: (context, subAccountsList, _) {
                  if (subAccountsList.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  final accountNames = repo.subAccountNames;

                  return Container(
                    decoration: BoxDecoration(
                      border: Border(left: BorderSide(color: const Color(0xFFD1D5DB))),
                    ),
                    child: DropdownButton<String>(
                      value: null,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.arrow_drop_down_rounded, size: 18, color: Color(0xFF6B7280)),
                      items: accountNames.map((name) {
                        return DropdownMenuItem<String>(
                          value: name,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              name,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (selectedValue) {
                        if (selectedValue != null) {
                          setState(() {
                            subAccountController.text = selectedValue;
                            final account = subAccountsList.firstWhere(
                                  (acc) => acc.name == selectedValue,
                            );
                            selectedAccountNumber = account.number;
                            _loadSubAccountData(account.number);
                          });
                        }
                      },
                      menuMaxHeight: 180,
                    ),
                  );
                },
              ),
              const SizedBox(width: 4),
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
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E3A8A),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 40, // Reduced height
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFFD1D5DB)),
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down_rounded, color: Color(0xFF6B7280), size: 18),
            style: const TextStyle(fontSize: 13, color: Colors.black87),
            hint: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '$label निवडा',
                style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
              ),
            ),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            dropdownColor: Colors.white,
            elevation: 4,
            menuMaxHeight: 180,
            underline: const SizedBox(),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ],
    );
  }

  Widget _buildNewMainAccountButton() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF3F4F6), Color(0xFFE5E7EB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFD1D5DB), width: 1),
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const EnteringAccNamesWindow()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, size: 14, color: Color(0xFF6B7280)),
            SizedBox(width: 4),
            Text(
              'नवीन',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
              ),
            ),
          ],
        ),
      ),
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
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E3A8A),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 40, // Reduced height
          child: TextField(
            controller: controller,
            style: const TextStyle(fontSize: 13),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(icon, size: 16, color: const Color(0xFF6B7280)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: Color(0xFF2563EB),
                  width: 1.5,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBalanceTypeButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'शिल्लक प्रकार',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E3A8A),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 40, // Reduced height
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFFD1D5DB)),
          ),
          child: Row(
            children: [
              _buildSwitchButton('जमा', true, isCredit == true, (value) {
                setState(() => isCredit = true);
              }),
              _buildSwitchButton('नावे', false, isCredit == false, (value) {
                setState(() => isCredit = false);
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchButton(String label, bool value, bool isSelected, ValueChanged<bool> onChanged) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(true),
        child: Container(
          height: 40, // Reduced height
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF2563EB) : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : const Color(0xFF374151),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLastAuditDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'मागील वर्षीचे शेवटचे व्यवहार तारीख',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E3A8A),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 40, // Reduced height
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFFD1D5DB)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: lastAuditDateController,
                  readOnly: true,
                  style: const TextStyle(fontSize: 13),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.calendar_today, size: 16, color: Color(0xFF6B7280)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    hintText: 'दिनांक निवडा',
                    hintStyle: TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_month, color: Color(0xFF6B7280), size: 18),
                onPressed: () => _selectLastAuditDate(context),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              ),
              const SizedBox(width: 4),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(SubAccountDataRepo repo) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      alignment: WrapAlignment.center,
      children: [
        _buildNewAccountButton(repo),
        _buildSaveButton(),
        _buildEditButton(),
        _buildStopButton(),
      ],
    );
  }

  Widget _buildNewAccountButton(SubAccountDataRepo repo) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF3F4F6), Color(0xFFE5E7EB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFD1D5DB), width: 1),
      ),
      child: ElevatedButton(
        onPressed: _clearForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.note_add, size: 14, color: Color(0xFF6B7280)),
            SizedBox(width: 4),
            Text(
              'नवीन',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
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
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E3A8A).withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _createSubAccount,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, size: 14, color: Colors.white),
            SizedBox(width: 4),
            Text(
              'ठीक',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
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
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFEA580C).withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          if (selectedAccountNumber == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("संपादन करण्यासाठी आधी खाते निवडा")),
            );
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("संपादन सुरु झाले")),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.edit, size: 14, color: Colors.white),
            SizedBox(width: 4),
            Text(
              'सुधार',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
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
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4B5563).withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.stop_circle, size: 14, color: Colors.white),
            SizedBox(width: 4),
            Text(
              'थांबवा',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
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
              child: SingleChildScrollView(
                child: _buildMainContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}