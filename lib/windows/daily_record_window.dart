import 'package:flutter/material.dart';
import 'package:windows_sample/windows/home_window.dart';
import 'entering_acc_names_window.dart';
import 'package:intl/intl.dart';

class DailyRecordWindow extends StatefulWidget {
  const DailyRecordWindow({super.key});

  @override
  State<DailyRecordWindow> createState() => _DailyRecordWindowState();
}

class _DailyRecordWindowState extends State<DailyRecordWindow> {
  DateTime selectedDate = DateTime.now();
  String? transactionType = 'कॅश';
  String? selectedMainAccount;
  String? selectedSubAccount;
  String? selectedNarrationType;
  String? accountType = 'जमा खाते';
  final TextEditingController serialController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController narrationController = TextEditingController();

  List<String> mainAccounts = [
    'अँड्र गंग',
    'गणेश',
    'डिपॉझि�ट खाते',
  ];

  List<String> subAccounts = [
    'दूध खाते',
    'खर्च खाते',
    'बोनस खाते',
  ];

  List<String> narrationTypes = [
    'दूध विक्री',
    'खर्च',
    'बोनस',
    'इतर',
  ];

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
          const Icon(Icons.today_rounded, color: Colors.white, size: 28),
          const SizedBox(width: 12),
          const SelectableText(
            'रोजकीर्द मधील नोंद',
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
      child: SingleChildScrollView(
        child: _buildFormSection(),
      ),
    );
  }

  Widget _buildFormSection() {
    return Container(
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
          // First Row: Date, Transaction Type, Serial Number
          Row(
            children: [
              Expanded(
                child: _buildDateField(),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTransactionType(),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildCompactInputField(
                  "अनु. क्र.",
                  serialController,
                  Icons.numbers,
                  hintText: 'अनुक्रमांक',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Account Type and Main Account in same row
          Row(
            children: [
              Expanded(
                child: _buildAccountType(),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildCustomDropdown(
                  label: 'मुख्य खाते',
                  value: selectedMainAccount,
                  items: mainAccounts,
                  onChanged: (val) {
                    setState(() => selectedMainAccount = val);
                  },
                  icon: Icons.account_balance,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Sub Account Dropdown
          _buildCustomDropdown(
            label: 'पोट खाते',
            value: selectedSubAccount,
            items: subAccounts,
            onChanged: (val) {
              setState(() => selectedSubAccount = val);
            },
            icon: Icons.account_balance_wallet,
          ),
          const SizedBox(height: 20),

          // Narration Field in two parts - Dropdown and Input
          Row(
            children: [
              Expanded(
                child: _buildCustomDropdown(
                  label: 'तपशील प्रकार',
                  value: selectedNarrationType,
                  items: narrationTypes,
                  onChanged: (val) {
                    setState(() => selectedNarrationType = val);
                  },
                  icon: Icons.description,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildCompactInputField(
                  "तपशील",
                  narrationController,
                  Icons.note,
                  hintText: 'व्यवहार तपशील प्रविष्ट करा',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Amount Field
          _buildCompactInputField(
            "रक्कम",
            amountController,
            Icons.currency_rupee,
            hintText: 'रक्कम प्रविष्ट करा',
          ),
          const SizedBox(height: 30),

          // Action Buttons
          _buildActionButtons(),
          const SizedBox(height: 30),

          // Data Table
          const Text(
            'आजचे व्यवहार',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E3A8A),
            ),
          ),
          const SizedBox(height: 10),
          _buildDataTable(),
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
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down_rounded, color: Color(0xFF6B7280), size: 24),
            style: const TextStyle(fontSize: 18, color: Colors.black87),
            hint: Container(
              // Wrap hint in container to align properly
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                '$label निवडा',
                style: const TextStyle(fontSize: 18, color: Color(0xFF6B7280)),
              ),
            ),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            dropdownColor: Colors.white,
            elevation: 4,
            menuMaxHeight: 250,
            // 👇 Add these properties for perfect border alignment
            underline: const SizedBox(), // Remove default underline
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

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'दिनांक',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E3A8A),
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: _pickDate,
          child: Container(
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFD1D5DB)),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 20, color: const Color(0xFF6B7280)),
                const SizedBox(width: 12),
                Text(
                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'व्यवहार प्रकार',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E3A8A),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFFD1D5DB)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        value: 'कॅश',
                        groupValue: transactionType,
                        onChanged: (val) => setState(() => transactionType = val),
                        activeColor: const Color(0xFF2563EB),
                      ),
                      const Text(
                        'कॅश',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'ट्रान्सफर',
                        groupValue: transactionType,
                        onChanged: (val) => setState(() => transactionType = val),
                        activeColor: const Color(0xFF2563EB),
                      ),
                      const Text(
                        'ट्रान्सफर',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAccountType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'खाते प्रकार',
          style: TextStyle(
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
          child: DropdownButton<String>(
            value: accountType,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down_rounded, color: Color(0xFF6B7280), size: 24),
            style: const TextStyle(fontSize: 18, color: Colors.black87),
            items: [
              DropdownMenuItem(
                value: 'जमा खाते',
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text('जमा खाते', style: const TextStyle(fontSize: 18)),
                ),
              ),
              DropdownMenuItem(
                value: 'नावे खाते',
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text('नावे खाते', style: const TextStyle(fontSize: 18)),
                ),
              ),
            ],
            onChanged: (val) {
              setState(() => accountType = val);
            },
            dropdownColor: Colors.white,
            elevation: 4,
            menuMaxHeight: 250,
            underline: const SizedBox(), // Remove default underline
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildNewButton(),
        const SizedBox(width: 16),
        _buildOkButton(),
        const SizedBox(width: 16),
        _buildEditButton(),
        const SizedBox(width: 16),
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
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD1D5DB), width: 1.5),
      ),
      child: ElevatedButton(
        onPressed: () {
          serialController.clear();
          narrationController.clear();
          amountController.clear();
          setState(() {
            transactionType = 'कॅश';
            accountType = 'जमा खाते';
            selectedMainAccount = null;
            selectedSubAccount = null;
            selectedNarrationType = null;
          });
        },
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
            Icon(Icons.note_add, size: 20, color: Color(0xFF6B7280)),
            SizedBox(width: 8),
            Text(
              'नवीन',
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

  Widget _buildOkButton() {
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
        onPressed: () {
          if (selectedMainAccount == null || selectedSubAccount == null || amountController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("कृपया सर्व आवश्यक फील्ड भरा")),
            );
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("व्यवहार यशस्वीरित्या नोंदवला गेला")),
          );
        },
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
              'ठीक',
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

  Widget _buildEditButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFB923C), Color(0xFFEA580C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFEA580C).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("संपादन सुरु झाले")),
          );
        },
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
            Icon(Icons.edit, size: 20, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'सुधार',
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

  Widget _buildStopButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFDC2626).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
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
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.stop_circle, size: 20, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'थांबवा',
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

  Widget _buildDataTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFD1D5DB)),
      ),
      child: DataTable(
        headingRowColor: WidgetStateProperty.all<Color>(const Color(0xFF1E3A8A).withOpacity(0.1)),
        columns: const [
          DataColumn(label: Text('अ.क्र.', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF1E3A8A), fontSize: 16))),
          DataColumn(label: Text('प्रकार', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF1E3A8A), fontSize: 16))),
          DataColumn(label: Text('खाते नाव', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF1E3A8A), fontSize: 16))),
          DataColumn(label: Text('पोट खाते', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF1E3A8A), fontSize: 16))),
          DataColumn(label: Text('रक्कम', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF1E3A8A), fontSize: 16))),
          DataColumn(label: Text('तपशील', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF1E3A8A), fontSize: 16))),
        ],
        rows: const [
          DataRow(cells: [
            DataCell(Text('1', style: TextStyle(fontSize: 16))),
            DataCell(Text('जमा', style: TextStyle(fontSize: 16))),
            DataCell(Text('अँड्र्युसन गंग', style: TextStyle(fontSize: 16))),
            DataCell(Text('गंग दूध खाते', style: TextStyle(fontSize: 16))),
            DataCell(Text('५,००० ₹', style: TextStyle(fontSize: 16))),
            DataCell(Text('दूध विक्री', style: TextStyle(fontSize: 16))),
          ]),
        ],
      ),
    );
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
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

  @override
  void dispose() {
    serialController.dispose();
    noteController.dispose();
    amountController.dispose();
    narrationController.dispose();
    super.dispose();
  }
}