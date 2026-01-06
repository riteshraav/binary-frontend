// main_account_window.dart
import 'package:flutter/material.dart';
import 'entering_acc_names_window.dart';
import 'home_window.dart';
import 'package:intl/intl.dart';

class MainAccountWindow extends StatefulWidget {
  const MainAccountWindow({super.key});

  @override
  State<MainAccountWindow> createState() => _MainAccountWindowState();
}

class _MainAccountWindowState extends State<MainAccountWindow> {
  String? selectedAccountType;
  String? selectedMainAccount;
  // NEW: unique key for Dropdown value (format: 'number|name')
  String? selectedMainAccountKey;
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController mainAccountSearchController = TextEditingController();
  final TextEditingController secondaryFieldController = TextEditingController();
  bool saveInTalebandh = false;
  bool isJama = true;
  bool _isAccountNumberUnique = true;
  MainAccountEntry? selectedSavedEntry;

  // NEW: Track if user is typing a new account
  bool get isTypingNewAccount => mainAccountSearchController.text.isNotEmpty &&
      selectedMainAccountKey == null &&
      !allMainAccounts.any((account) => account['name'] == mainAccountSearchController.text);

  // Pre-defined main accounts with their numbers and types
  final List<Map<String, String>> predefinedAccounts = [
    // ताळेबंद पत्रक
    {'number': '9', 'name': 'इतर येणे', 'type': 'येणेकरी', 'group': 'ताळेबंद पत्रक'},
    {'number': '1', 'name': 'अधिकृत भागभांडवल', 'type': 'ताळेबंद (इतर)', 'group': 'ताळेबंद पत्रक'},
    {'number': '4', 'name': 'देणी व तरतुदी', 'type': 'देणेकरी', 'group': 'ताळेबंद पत्रक'},
    {'number': '6', 'name': 'गुंतवणूक', 'type': 'ताळेबंद (इतर)', 'group': 'ताळेबंद पत्रक'},
    {'number': '15', 'name': 'शिल्लक माल', 'type': 'शिल्लक माल', 'group': 'ताळेबंद पत्रक'},
    {'number': '15', 'name': 'नफा', 'type': 'ताळेबंद (इतर)', 'group': 'ताळेबंद पत्रक'},
    {'number': '14', 'name': 'नफा तोटा खाते', 'type': 'ताळेबंद (इतर)', 'group': 'ताळेबंद पत्रक'},
    {'number': '20', 'name': 'नफा तोटा खाते', 'type': 'ताळेबंद (इतर)', 'group': 'ताळेबंद पत्रक'},
    {'number': '2', 'name': 'राखीव व इतर निधी', 'type': 'ताळेबंद (इतर)', 'group': 'ताळेबंद पत्रक'},
    {'number': '5', 'name': 'रोख व बँक शिल्लक', 'type': 'रोख व बँक शिल्लक', 'group': 'ताळेबंद पत्रक'},
    {'number': '7', 'name': 'सभासद येणेकरी कर्ज', 'type': 'येणेकरी', 'group': 'ताळेबंद पत्रक'},
    {'number': '8', 'name': 'स्थावर व जंगम मालमत्ता', 'type': 'ताळेबंद (इतर)', 'group': 'ताळेबंद पत्रक'},
    {'number': '3', 'name': 'ठेवी', 'type': 'ताळेबंद (इतर)', 'group': 'ताळेबंद पत्रक'},

    // नफा तोटा पत्रक
    {'number': '10', 'name': 'नफा तोटा पत्रक जमा', 'type': 'नफा तोटा (जमा)', 'group': 'नफा तोटा पत्रक'},
    {'number': '11', 'name': 'नफा तोटा पत्रक जमा', 'type': 'नफा तोटा (नावे)', 'group': 'नफा तोटा पत्रक'},

    // व्यापारी पत्रक
    {'number': '12', 'name': 'व्यापारी पत्रक विक्री', 'type': 'व्यापारी(जमा)', 'group': 'व्यापारी पत्रक'},
    {'number': '13', 'name': 'व्यापारी पत्रक खरेदी', 'type': 'व्यापारी(नावे)', 'group': 'व्यापारी पत्रक'},
  ];

  // Account types list
  final List<String> accountTypes = [
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

  @override
  void initState() {
    super.initState();
    _loadExistingEntries();
    // Load predefined accounts into repository
    _loadPredefinedAccounts();
  }

  void _loadPredefinedAccounts() {
    final repo = DairyDataRepo.instance;
    for (var account in predefinedAccounts) {
      final entry = MainAccountEntry(
        accountNumber: account['number']!,
        accountType: account['type']!,
        mainAccount: account['name']!,
        showInBalance: true,
      );
      // Add to repository if not already exists
      if (!repo.mainAccountEntries.value.any((e) => e.accountNumber == account['number'])) {
        repo.addMainAccountEntry(entry);
      }
    }
  }

  void _loadExistingEntries() {
    // The entries are already in the repository
  }

  // Get ALL main accounts for dropdown (not filtered by type)
  List<Map<String, String>> get allMainAccounts {
    final allAccounts = <Map<String, String>>[];

    // Add predefined accounts
    allAccounts.addAll(predefinedAccounts);

    // Add saved accounts that are not in predefined
    final repo = DairyDataRepo.instance;
    for (var savedEntry in repo.mainAccountEntries.value) {
      if (!allAccounts.any((account) => account['name'] == savedEntry.mainAccount && account['number'] == savedEntry.accountNumber)) {
        allAccounts.add({
          'number': savedEntry.accountNumber,
          'name': savedEntry.mainAccount,
          'type': savedEntry.accountType,
          'group': _getGroupFromType(savedEntry.accountType),
        });
      }
    }

    return allAccounts;
  }

  String _getGroupFromType(String accountType) {
    switch (accountType) {
      case 'ताळेबंद (इतर)':
      case 'देणेकरी':
      case 'येणेकरी':
      case 'शिल्लक माल':
      case 'रोख व बँक शिल्लक':
        return 'ताळेबंद पत्रक';
      case 'नफा तोटा (जमा)':
      case 'नफा तोटा (नावे)':
        return 'नफा तोटा पत्रक';
      case 'व्यापारी(जमा)':
      case 'व्यापारी(नावे)':
        return 'व्यापारी पत्रक';
      default:
        return 'इतर';
    }
  }

  // Get the group for selected main account - COMPLETELY SAFE
  String? get selectedAccountGroup {
    if (selectedMainAccount == null) return null;

    // Safe search without any exceptions
    for (var account in allMainAccounts) {
      if (account['name'] == selectedMainAccount) {
        return account['group'];
      }
    }
    return null;
  }

  void _validateAccountNumber(String value) {
    final repo = DairyDataRepo.instance;
    final isUnique = !repo.mainAccountEntries.value.any((entry) =>
    entry.accountNumber == value &&
        (selectedSavedEntry == null || entry.accountNumber != selectedSavedEntry!.accountNumber));

    setState(() {
      _isAccountNumberUnique = isUnique;
    });
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
          const Icon(Icons.account_balance_rounded, color: Colors.white, size: 24),
          const SizedBox(width: 10),
          const SelectableText(
            'मुख्य खाते नावे भरणे',
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
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
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
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF8FAFC), Color(0xFFEBF4FF), Color(0xFFDBEAFE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
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
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Account Type Dropdown
          _buildCustomDropdown(
            label: 'खाते प्रकार',
            value: selectedAccountType,
            items: accountTypes,
            onChanged: (value) {
              setState(() {
                selectedAccountType = value;
              });
            },
            icon: Icons.account_balance,
          ),
          const SizedBox(height: 16),

          // Main Account Row with Group Type
          _buildMainAccountRow(),
          const SizedBox(height: 16),

          // Account Number Input and Checkbox
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Account Number Column
              Expanded(
                child: _buildAccountNumberField(),
              ),
              const SizedBox(width: 16),

              // Checkbox Column
              Container(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      height: 45,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFD1D5DB)),
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: saveInTalebandh,
                            onChanged: (val) {
                              setState(() => saveInTalebandh = val ?? false);
                            },
                            activeColor: const Color(0xFF2563EB),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                          ),
                          const SizedBox(width: 4),
                          const Expanded(
                            child: Text(
                              'ताळेबंद खातं दाखवा',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E3A8A),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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

  // Main Account Row with Group Type next to it
  Widget _buildMainAccountRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main Account Dropdown
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'मुख्य खाते',
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
                        controller: mainAccountSearchController,
                        style: const TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          border: InputBorder.none,
                          hintText: 'जुने खाते निवडा किंवा नवीन टाइप करा',
                          hintStyle: const TextStyle(fontSize: 15, color: Color(0xFF6B7280)),
                          prefixIcon: const Icon(Icons.search, size: 18, color: Color(0xFF6B7280)),
                        ),
                        onChanged: (value) {
                          setState(() {
                            selectedMainAccount = value;
                            selectedMainAccountKey = null;
                            if (value.isEmpty) {
                              accountNumberController.clear();
                              selectedAccountType = null;
                              selectedSavedEntry = null;
                              saveInTalebandh = false;
                            }
                          });
                        },
                      ),
                    ),
                    if (allMainAccounts.isNotEmpty)
                      Container(
                        decoration: BoxDecoration(
                          border: Border(left: BorderSide(color: const Color(0xFFD1D5DB))),
                        ),
                        child: PopupMenuButton<String>(
                          icon: const Icon(Icons.arrow_drop_down_rounded, color: Color(0xFF6B7280), size: 20),
                          onSelected: (key) {
                            _onMainAccountSelectedByKey(key);
                          },
                          itemBuilder: (context) {
                            return allMainAccounts.map((account) {
                              final key = '${account['number'] ?? ''}|${account['name'] ?? ''}';
                              return PopupMenuItem<String>(
                                value: key,
                                child: Text(
                                  '${account['number']} - ${account['name']}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList();
                          },
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                isTypingNewAccount
                    ? 'टीप: नवीन खाते नाव टाइप करा'
                    : 'टीप: ड्रॉपडाउन आयकॉन वर क्लिक करून जुने खाते निवडा किंवा नवीन टाइप करा',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 16),

        // Group Type Display
        Container(
          width: 180,
          child: Column(
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
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: selectedAccountGroup != null ? const Color(0xFF1E3A8A) : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFD1D5DB)),
                ),
                child: Center(
                  child: Text(
                    selectedAccountGroup ?? '--',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: selectedAccountGroup != null ? Colors.white : const Color(0xFF6B7280),
                    ),
                  ),
                ),
              ),
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
                    _getAccountTypeDisplayName(item),
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

  // NEW: select by unique key
  void _onMainAccountSelectedByKey(String key) {
    // key format: 'number|name'
    final parts = key.split('|');
    if (parts.isEmpty) return;
    final number = parts[0];
    final name = parts.length > 1 ? parts.sublist(1).join('|') : '';

    setState(() {
      selectedMainAccountKey = key;
      selectedMainAccount = name;
      mainAccountSearchController.text = name;
      accountNumberController.text = number;

      // find account type from allMainAccounts
      Map<String, String>? foundAcc;
      for (var a in allMainAccounts) {
        if (a['number'] == number && a['name'] == name) {
          foundAcc = a;
          break;
        }
      }
      if (foundAcc != null) {
        selectedAccountType = foundAcc['type'];
      }

      _isAccountNumberUnique = true;

      // try to find saved repo entry
      final repo = DairyDataRepo.instance;
      MainAccountEntry? foundEntry;
      for (var entry in repo.mainAccountEntries.value) {
        if (entry.mainAccount == name && entry.accountNumber == number) {
          foundEntry = entry;
          break;
        }
      }
      if (foundEntry != null) {
        selectedSavedEntry = foundEntry;
        saveInTalebandh = foundEntry.showInBalance;
      } else {
        selectedSavedEntry = null;
        saveInTalebandh = false;
      }
    });
  }

  // Account Number Field - Read only when account selected
  Widget _buildAccountNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'अनु. नं.',
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
            color: selectedMainAccountKey != null ? const Color(0xFFF3F4F6) : Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: selectedMainAccountKey != null ? const Color(0xFFD1D5DB) :
              _isAccountNumberUnique ? const Color(0xFFD1D5DB) : Colors.red,
              width: 1,
            ),
          ),
          child: TextFormField(
            controller: accountNumberController,
            style: const TextStyle(fontSize: 15),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              hintText: selectedMainAccountKey != null ? '' : 'अनु. नं. प्रविष्ट करा',
              hintStyle: const TextStyle(fontSize: 15, color: Color(0xFF6B7280)),
              errorText: _isAccountNumberUnique ? null : 'हा अनु. नं. आधीच वापरात आहे',
            ),
            readOnly: selectedMainAccountKey != null,
            onChanged: (value) {
              if (selectedMainAccountKey == null) {
                _validateAccountNumber(value);
              }
            },
          ),
        ),
        if (!_isAccountNumberUnique)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'कृपया वेगळा अनु. नं. प्रविष्ट करा',
              style: TextStyle(
                color: Colors.red.shade700,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  // ... (Keep all your existing button methods: _buildActionButtons, _buildNewButton, etc.)

  Widget _buildActionButtons() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: [
        _buildNewButton(),
        _buildSaveButton(),
        _buildUpdateButton(),
        _buildDeleteButton(),
        _buildStopButton(),
      ],
    );
  }

  Widget _buildNewButton() {
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
        onPressed: _clearForm,
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
        onPressed: _saveEntry,
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

  Widget _buildUpdateButton() {
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
        onPressed: _updateEntry,
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
            Icon(Icons.update, size: 16, color: Colors.white),
            SizedBox(width: 6),
            Text(
              'अपडेट',
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

  Widget _buildDeleteButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFDC2626).withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _deleteEntry,
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
            Icon(Icons.delete, size: 16, color: Colors.white),
            SizedBox(width: 6),
            Text(
              'हटवा',
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

  // Method to get display name for account type based on checkbox state
  String _getAccountTypeDisplayName(String accountType) {
    if (accountType == 'ताळेबंद (इतर)' && saveInTalebandh) {
      return 'ताळेबंद';
    }
    return accountType;
  }

  void _clearForm() {
    setState(() {
      selectedSavedEntry = null;
      accountNumberController.clear();
      selectedAccountType = null;
      selectedMainAccount = null;
      selectedMainAccountKey = null;
      saveInTalebandh = false;
      mainAccountSearchController.clear();
      secondaryFieldController.clear();
      isJama = true;
      _isAccountNumberUnique = true;
    });
  }

  void _saveEntry() {
    if (selectedAccountType == null ||
        mainAccountSearchController.text.isEmpty ||
        accountNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("कृपया सर्व आवश्यक फील्ड भरा")),
      );
      return;
    }

    if (!_isAccountNumberUnique) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("कृपया वेगळा अनु. नं. प्रविष्ट करा")),
      );
      return;
    }

    final newEntry = MainAccountEntry(
      accountNumber: accountNumberController.text,
      accountType: selectedAccountType!,
      mainAccount: mainAccountSearchController.text,
      showInBalance: saveInTalebandh,
    );

    final repo = DairyDataRepo.instance;

    if (selectedSavedEntry != null) {
      repo.updateMainAccountEntry(selectedSavedEntry!, newEntry);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("खाते यशस्वीरित्या अपडेट केले")),
      );
    } else {
      repo.addMainAccountEntry(newEntry);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("खाते यशस्वीरित्या जतन केले")),
      );
    }

    _clearForm();
  }

  void _deleteEntry() {
    if (selectedSavedEntry == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("कृपया हटवण्यासाठी खाते निवडा")),
      );
      return;
    }

    final repo = DairyDataRepo.instance;
    repo.deleteMainAccountEntry(selectedSavedEntry!);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("खाते यशस्वीरित्या हटवले: ${selectedSavedEntry!.accountNumber}")),
    );

    _clearForm();
  }

  void _updateEntry() {
    if (selectedSavedEntry == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("कृपया अपडेट करण्यासाठी खाते निवडा")),
      );
      return;
    }

    _saveEntry();
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