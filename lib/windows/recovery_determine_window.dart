// recovery_determine_window.dart
import 'package:flutter/material.dart';
import 'entering_acc_names_window.dart';
import 'home_window.dart';
import 'package:intl/intl.dart';

class RecoveryDetermineWindow extends StatefulWidget {
  const RecoveryDetermineWindow({super.key});

  @override
  State<RecoveryDetermineWindow> createState() => _RecoveryDetermineWindowState();
}

class _RecoveryDetermineWindowState extends State<RecoveryDetermineWindow> {
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController cupatTypeController = TextEditingController();
  String? selectedKhate; // 'खाते' (created account) selected name
  bool potKhateChecked = false; // 'पोट खाते' checkbox
  bool vitraatunVasuli = true; // radio: आहे = true, नाही = false

  @override
  void initState() {
    super.initState();
    // default account number: show nextAccountNumber if present
    accountNumberController.text = DairyDataRepo.instance.nextAccountNumber.value.toString();
  }

  @override
  void dispose() {
    accountNumberController.dispose();
    cupatTypeController.dispose();
    super.dispose();
  }

  // Helper methods
  String _currentDate() => DateFormat('dd-MM-yyyy').format(DateTime.now());

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.all(18),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.report_gmailerrorred, color: Colors.white, size: 28),
          const SizedBox(width: 12),
          const SelectableText(
            'वसुली ठरवणे',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.schedule, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                SelectableText(
                  'दिनांक: ${_currentDate()}',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 0, 18, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildFormSection(),
        ],
      ),
    );
  }

  Widget _buildFormSection() {
    final repo = DairyDataRepo.instance;

    return Container(
      width: 500,
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(24),
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
          // Account Number Field
          _buildCompactInputField(
            "अनु. नं.",
            accountNumberController,
            Icons.numbers,
            readOnly: true,
          ),
          const SizedBox(height: 20),

          // Khate Dropdown
          ValueListenableBuilder<List<CreatedAccount>>(
            valueListenable: repo.createdAccounts,
            builder: (context, createdAccounts, _) {
              final accountNames = getCreatedAccountNames(createdAccounts);
              return _buildCustomDropdown(
                label: 'खाते',
                value: selectedKhate,
                items: accountNames,
                onChanged: (value) {
                  setState(() => selectedKhate = value);
                },
                icon: Icons.account_balance,
              );
            },
          ),
          const SizedBox(height: 20),

          // Pot Khate Checkbox
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFD1D5DB)),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: potKhateChecked,
                  onChanged: (val) => setState(() => potKhateChecked = val ?? false),
                  activeColor: const Color(0xFF2563EB),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                ),
                const SizedBox(width: 4),
                const Text(
                  'पोट खाते',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Conditional Expanded Area for Pot Khate
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: potKhateChecked
                ? Container(
              key: const ValueKey('potArea'),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Vitraatun Vasuli Radio Buttons
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFD1D5DB)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'बिलातून वसुली',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Color(0xFF1E3A8A),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Row(
                              children: [
                                Radio<bool>(
                                  value: true,
                                  groupValue: vitraatunVasuli,
                                  onChanged: (v) => setState(() => vitraatunVasuli = v ?? true),
                                  activeColor: const Color(0xFF2563EB),
                                ),
                                const Text(
                                  'आहे',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Row(
                              children: [
                                Radio<bool>(
                                  value: false,
                                  groupValue: vitraatunVasuli,
                                  onChanged: (v) => setState(() => vitraatunVasuli = v ?? false),
                                  activeColor: const Color(0xFF2563EB),
                                ),
                                const Text(
                                  'नाही',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Cupat Type Input
                  _buildCompactInputField(
                    "कपात प्रकार",
                    cupatTypeController,
                    Icons.type_specimen,
                    hintText: 'कपात प्रकार प्रविष्ट करा',
                  ),
                ],
              ),
            )
                : const SizedBox.shrink(),
          ),

          const SizedBox(height: 30),

          // Action Buttons
          _buildActionButtons(),
        ],
      ),
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
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E3A8A),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 55,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFFD1D5DB)),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down_rounded, color: Color(0xFF6B7280), size: 24),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              border: InputBorder.none,
              prefixIcon: Icon(icon, size: 20, color: const Color(0xFF6B7280)),
            ),
            style: const TextStyle(fontSize: 18, color: Colors.black87),
            hint: Text(
              '$label निवडा',
              style: const TextStyle(fontSize: 18, color: Color(0xFF6B7280)),
            ),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 18),
                ),
              );
            }).toList(),
            onChanged: onChanged,
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
        bool readOnly = false,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E3A8A),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 55,
          child: TextFormField(
            readOnly: readOnly,
            controller: controller,
            style: const TextStyle(fontSize: 18),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(icon, size: 20, color: const Color(0xFF6B7280)),
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
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: 18, color: Color(0xFF6B7280)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSaveButton(),
        const SizedBox(width: 16),
        _buildClearButton(),
      ],
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
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E3A8A).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _onSave,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, size: 20, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'जतन करा',
              style: TextStyle(
                fontSize: 16,
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

  Widget _buildClearButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF3F4F6), Color(0xFFE5E7EB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD1D5DB), width: 1.5),
      ),
      child: ElevatedButton(
        onPressed: _clearFields,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.clear_rounded, size: 20, color: Color(0xFF6B7280)),
            SizedBox(width: 8),
            Text(
              'साफ करा',
              style: TextStyle(
                fontSize: 16,
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

  void _clearFields() {
    setState(() {
      selectedKhate = null;
      potKhateChecked = false;
      vitraatunVasuli = true;
      cupatTypeController.clear();
    });
  }

  // Get created account names for dropdown
  List<String> getCreatedAccountNames(List<CreatedAccount> accounts) {
    return accounts.map((account) => account.name).toList()..sort();
  }

  void _onSave() {
    final khateVal = selectedKhate ?? '-';
    final accNo = accountNumberController.text.trim();
    final cupat = cupatTypeController.text.trim();
    final pot = potKhateChecked ? 'होय' : 'नाही';
    final vit = vitraatunVasuli ? 'आहे' : 'नाही';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('वसुली यशस्वीरित्या जतन केली — खाते: $khateVal | अनु. नं.: $accNo | पोट खाते: $pot | वितरातून वसुली: $vit | कपात: ${potKhateChecked ? cupat : "-"}'),
        backgroundColor: const Color(0xFF1E3A8A),
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