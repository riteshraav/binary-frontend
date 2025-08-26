import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'dart:developer';
import '../model/customer_model.dart'; // Add this import
import '../riverpod/providers.dart';


class RateSetupWindow extends ConsumerStatefulWidget {
  @override
  _RateSetupWindow createState() => _RateSetupWindow();
}

class _RateSetupWindow extends ConsumerState<RateSetupWindow> {
  // Controllers for Cow Milk (गाय)
  final TextEditingController cowFatController = TextEditingController();
  final TextEditingController cowSnfController = TextEditingController();
  final TextEditingController cowRateController = TextEditingController();
  final TextEditingController cowTotalFatController = TextEditingController();
  final TextEditingController cowTotalSnfController = TextEditingController();
  final TextEditingController cowTotalRateController = TextEditingController();

  // Controllers for Buffalo Milk (म्हैस)
  final TextEditingController buffaloFatController = TextEditingController();
  final TextEditingController buffaloSnfController = TextEditingController();
  final TextEditingController buffaloRateController = TextEditingController();
  final TextEditingController buffaloTotalFatController = TextEditingController();
  final TextEditingController buffaloTotalSnfController = TextEditingController();
  final TextEditingController buffaloTotalRateController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // State variables
  dynamic customerService;
  late List<CustomerMaster> customerModelList ;
  bool isLoading = true;
  bool showForm = false;
  String adminId = "1";
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  // Helper methods
  String _currentDate() => DateFormat('dd-MM-yyyy').format(DateTime.now());

  Future<void> _initializeData() async {
    print("InitState running...");

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print("PostFrameCallback running...");
      try {
        await _loadData();
      } catch (e, st) {
        print("Error in loadData: $e");
        print(st);
      } finally {
        if (mounted) {
          setState(() => isLoading = false);
        }
      }
    });
  }

  Future<void> _loadData() async {
    try {
      customerService = ref.watch(customerServiceProvider); // Update provider name
      customerModelList = await customerService.fetchAllCustomers(adminId) ?? [];
      print('Customer model list length: ${customerModelList.length}');
    } catch (e) {
      print('Error loading data: $e');
      customerModelList = [];
    }
  }

  void _clearFields() {
    // Clear Cow fields
    cowFatController.clear();
    cowSnfController.clear();
    cowRateController.clear();
    cowTotalFatController.clear();
    cowTotalSnfController.clear();
    cowTotalRateController.clear();

    // Clear Buffalo fields
    buffaloFatController.clear();
    buffaloSnfController.clear();
    buffaloRateController.clear();
    buffaloTotalFatController.clear();
    buffaloTotalSnfController.clear();
    buffaloTotalRateController.clear();
  }

  Future<void> _saveCustomer() async {
    log('_saveCustomer called');

    if (!_formKey.currentState!.validate()) return;

    try {
      // Create customer with new fields (you'll need to update CustomerMaster model accordingly)
      final customer = CustomerMaster(
        code: (customerModelList.length + 1).toString(),
        name: "Sample Customer", // You can add name field if needed
        branch: "Main Branch", // You can add branch field if needed
        milkType: "mixed", // Since we have both cow and buffalo
        classType: "A",
        gender: "male",
        caste: "",
        milkOn: true,
        accountNo: "",
        sabhasadNo: "",
        bankCode: "",
        bankBranch: "",
        bankAccountNo: "",
        ifsc: "",
        rateGroup: "",
        localRateGroup: "",
        mobileNo1: "",
        mobileNo2: "",
        aadhar: "",
        panNo: "",
        animalCount: "",
        averageQuantity: "",
        adminId: "",
        adminCode: "",
      );

      await customerService.addCustomer(customer);

      setState(() {
        customerModelList.add(customer);
        _clearFields();
        showForm = false;
      });

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('दूध डेटा यशस्वीरित्या जतन केला!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('त्रुटी: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: _buildMainContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hintText,
    String? Function(String?)? validator,
    bool readOnly = false,
    Widget? suffixIcon,
    Color? fillColor,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
            letterSpacing: 0.1,
          ),
        ),
        const SizedBox(height: 3),
        Container(
          height: 32, // Further reduced height
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1E3A8A).withOpacity(0.03),
                spreadRadius: 0,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            readOnly: readOnly,
            validator: validator,
            keyboardType: keyboardType,
            style: TextStyle(
              fontSize: 11, // Reduced font size
              fontWeight: FontWeight.w500,
              color: readOnly ? const Color(0xFF6B7280) : const Color(0xFF111827),
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: fillColor ?? Colors.white,
              hintText: hintText,
              hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFFD1D5DB), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFF2563EB), width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              suffixIcon: suffixIcon != null
                  ? Container(margin: const EdgeInsets.only(right: 4), child: suffixIcon)
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
        ),
        borderRadius: BorderRadius.circular(12),
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
          const Icon(Icons.local_drink, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          const SelectableText(
            'दूध दर सेटप',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.schedule, color: Colors.white, size: 14),
                const SizedBox(width: 6),
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
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
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
      child: Column(
        children: [
          _buildFormSection(),
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: _buildTable(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
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
            color: const Color(0xFF1E3A8A).withOpacity(0.06),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.45, // Reduced height
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildFormTitle(),
              const SizedBox(height: 16),
              _buildCowMilkSection(),
              const SizedBox(height: 16),
              _buildBuffaloMilkSection(),
              const SizedBox(height: 16),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormTitle() {
    return const Text(
      'दूध संग्रह तपशील',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E40AF),
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _buildCowMilkSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.shade200, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.pets, color: Colors.green.shade700, size: 16),
              const SizedBox(width: 8),
              Text(
                'गाय दूध तपशील',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildTextField(
                controller: cowFatController,
                label: 'फॅट (%)',
                hintText: 'फॅट टक्केवारी प्रविष्ट करा',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value?.isNotEmpty == true) {
                    final fat = double.tryParse(value!);
                    if (fat == null || fat < 0 || fat > 10) {
                      return 'वैध फॅट टक्केवारी प्रविष्ट करा (0-10%)';
                    }
                  }
                  return null;
                },
              )),
              const SizedBox(width: 8),
              Expanded(child: _buildTextField(
                controller: cowSnfController,
                label: 'SNF (%)',
                hintText: 'SNF टक्केवारी प्रविष्ट करा',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value?.isNotEmpty == true) {
                    final snf = double.tryParse(value!);
                    if (snf == null || snf < 0 || snf > 15) {
                      return 'वैध SNF टक्केवारी प्रविष्ट करा (0-15%)';
                    }
                  }
                  return null;
                },
              )),
              const SizedBox(width: 8),
              Expanded(child: _buildTextField(
                controller: cowRateController,
                label: 'दर (₹/लीटर)',
                hintText: 'दर प्रविष्ट करा',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value?.isNotEmpty == true) {
                    final rate = double.tryParse(value!);
                    if (rate == null || rate < 0) {
                      return 'वैध दर प्रविष्ट करा';
                    }
                  }
                  return null;
                },
              )),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildTextField(
                controller: cowTotalFatController,
                label: 'एकूण फॅट',
                hintText: 'एकूण फॅट प्रविष्ट करा',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              )),
              const SizedBox(width: 8),
              Expanded(child: _buildTextField(
                controller: cowTotalSnfController,
                label: 'एकूण SNF',
                hintText: 'एकूण SNF प्रविष्ट करा',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              )),
              const SizedBox(width: 8),
              Expanded(child: _buildTextField(
                controller: cowTotalRateController,
                label: 'एकूण दर (₹)',
                hintText: 'एकूण दर प्रविष्ट करा',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBuffaloMilkSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.agriculture, color: Colors.blue.shade700, size: 16),
              const SizedBox(width: 8),
              Text(
                'म्हैस दूध तपशील',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildTextField(
                controller: buffaloFatController,
                label: 'फॅट (%)',
                hintText: 'फॅट टक्केवारी प्रविष्ट करा',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value?.isNotEmpty == true) {
                    final fat = double.tryParse(value!);
                    if (fat == null || fat < 0 || fat > 12) {
                      return 'वैध फॅट टक्केवारी प्रविष्ट करा (0-12%)';
                    }
                  }
                  return null;
                },
              )),
              const SizedBox(width: 8),
              Expanded(child: _buildTextField(
                controller: buffaloSnfController,
                label: 'SNF (%)',
                hintText: 'SNF टक्केवारी प्रविष्ट करा',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value?.isNotEmpty == true) {
                    final snf = double.tryParse(value!);
                    if (snf == null || snf < 0 || snf > 18) {
                      return 'वैध SNF टक्केवारी प्रविष्ट करा (0-18%)';
                    }
                  }
                  return null;
                },
              )),
              const SizedBox(width: 8),
              Expanded(child: _buildTextField(
                controller: buffaloRateController,
                label: 'दर (₹/लीटर)',
                hintText: 'दर प्रविष्ट करा',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value?.isNotEmpty == true) {
                    final rate = double.tryParse(value!);
                    if (rate == null || rate < 0) {
                      return 'वैध दर प्रविष्ट करा';
                    }
                  }
                  return null;
                },
              )),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildTextField(
                controller: buffaloTotalFatController,
                label: 'एकूण फॅट',
                hintText: 'एकूण फॅट प्रविष्ट करा',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              )),
              const SizedBox(width: 8),
              Expanded(child: _buildTextField(
                controller: buffaloTotalSnfController,
                label: 'एकूण SNF',
                hintText: 'एकूण SNF प्रविष्ट करा',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              )),
              const SizedBox(width: 8),
              Expanded(child: _buildTextField(
                controller: buffaloTotalRateController,
                label: 'एकूण दर (₹)',
                hintText: 'एकूण दर प्रविष्ट करा',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        _buildCompactSaveButton(),
        const SizedBox(width: 12),
        _buildCompactClearButton(),
      ],
    );
  }

  Widget _buildCompactSaveButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2563EB).withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _saveCustomer,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.save_rounded, size: 14, color: Colors.white),
            SizedBox(width: 6),
            Text(
              'Save',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactClearButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF3F4F6), Color(0xFFE5E7EB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD1D5DB), width: 1),
      ),
      child: ElevatedButton(
        onPressed: _clearFields,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.clear_rounded, size: 14, color: Color(0xFF6B7280)),
            SizedBox(width: 6),
            Text(
              'Clear',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTable() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: [
            _buildTableHeader(),
            Expanded(child: _buildTableData()),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    const headerStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 11,
    );

    return Container(
      height: 35, // Reduced header height
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 8,
          headingRowHeight: 35,
          dataRowMinHeight: 0,
          dataRowMaxHeight: 0,
          headingRowColor: WidgetStateProperty.all(Colors.transparent),
          columns: const [
            DataColumn(
              label: SizedBox(width: 60, child: Text("गाय फॅट %", style: headerStyle)),
            ),
            DataColumn(
              label: SizedBox(width: 60, child: Text("गाय SNF %", style: headerStyle)),
            ),
            DataColumn(
              label: SizedBox(width: 80, child: Text("गाय दर", style: headerStyle)),
            ),
            DataColumn(
              label: SizedBox(width: 80, child: Text("गाय एकूण फॅट", style: headerStyle)),
            ),
            DataColumn(
              label: SizedBox(width: 80, child: Text("गाय एकूण SNF", style: headerStyle)),
            ),
            DataColumn(
              label: SizedBox(width: 80, child: Text("गाय एकूण दर", style: headerStyle)),
            ),
            DataColumn(
              label: SizedBox(width: 60, child: Text("म्हैस फॅट %", style: headerStyle)),
            ),
            DataColumn(
              label: SizedBox(width: 60, child: Text("म्हैस SNF %", style: headerStyle)),
            ),
            DataColumn(
              label: SizedBox(width: 80, child: Text("म्हैस दर", style: headerStyle)),
            ),
            DataColumn(
              label: SizedBox(width: 80, child: Text("म्हैस एकूण फॅट", style: headerStyle)),
            ),
            DataColumn(
              label: SizedBox(width: 80, child: Text("म्हैस एकूण SNF", style: headerStyle)),
            ),
            DataColumn(
              label: SizedBox(width: 80, child: Text("म्हैस एकूण दर", style: headerStyle)),
            ),
          ],
          rows: const [],
        ),
      ),
    );
  }

  Widget _buildTableData() {
    return Container(
      color: Colors.white,
      child: Scrollbar(
        thumbVisibility: true,
        trackVisibility: true,
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  left: BorderSide(color: Colors.grey.shade300, width: 0.5),
                  right: BorderSide(color: Colors.grey.shade300, width: 0.5),
                  bottom: BorderSide(color: Colors.grey.shade300, width: 0.5),
                ),
              ),
              child: DataTable(
                columnSpacing: 8,
                headingRowHeight: 0,
                dataRowMinHeight: 32, // Reduced row height
                dataRowMaxHeight: 32,
                border: TableBorder(
                  horizontalInside: BorderSide(color: Colors.grey.shade300, width: 0.5),
                  verticalInside: BorderSide(color: Colors.grey.shade300, width: 0.5),
                ),
                headingRowColor: WidgetStateProperty.all(Colors.transparent),
                columns: const [
                  DataColumn(label: SizedBox(width: 60)),
                  DataColumn(label: SizedBox(width: 60)),
                  DataColumn(label: SizedBox(width: 80)),
                  DataColumn(label: SizedBox(width: 80)),
                  DataColumn(label: SizedBox(width: 80)),
                  DataColumn(label: SizedBox(width: 80)),
                  DataColumn(label: SizedBox(width: 60)),
                  DataColumn(label: SizedBox(width: 60)),
                  DataColumn(label: SizedBox(width: 80)),
                  DataColumn(label: SizedBox(width: 80)),
                  DataColumn(label: SizedBox(width: 80)),
                  DataColumn(label: SizedBox(width: 80)),
                ],
                rows: _buildDataRows(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<DataRow> _buildDataRows() {
    return List.generate(
      customerModelList.length,
          (index) {
        final entry = customerModelList.reversed.toList()[index];
        final isEven = index % 2 == 0;

        return DataRow(
          color: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered)) {
                return const Color(0xFF3B82F6).withOpacity(0.1);
              }
              return isEven ? Colors.white : Colors.grey[50];
            },
          ),
          cells: [
            _buildDataCell("0.0", 60), // Cow Fat %
            _buildDataCell("0.0", 60), // Cow SNF %
            _buildDataCell("₹0.0", 80), // Cow Rate
            _buildDataCell("0.0", 80), // Cow Total Fat
            _buildDataCell("0.0", 80), // Cow Total SNF
            _buildDataCell("₹0.0", 80), // Cow Total Rate
            _buildDataCell("0.0", 60), // Buffalo Fat %
            _buildDataCell("0.0", 60), // Buffalo SNF %
            _buildDataCell("₹0.0", 80), // Buffalo Rate
            _buildDataCell("0.0", 80), // Buffalo Total Fat
            _buildDataCell("0.0", 80), // Buffalo Total SNF
            _buildDataCell("₹0.0", 80), // Buffalo Total Rate
          ],
        );
      },
    );
  }

  DataCell _buildDataCell(String text, double width, {TextOverflow? overflow}) {
    return DataCell(
      Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 10, // Reduced font size for table
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151),
          ),
          overflow: overflow,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<CustomerMaster>('customerModelList', customerModelList));
  }

  @override
  void dispose() {
    // Dispose Cow controllers
    cowFatController.dispose();
    cowSnfController.dispose();
    cowRateController.dispose();
    cowTotalFatController.dispose();
    cowTotalSnfController.dispose();
    cowTotalRateController.dispose();

    // Dispose Buffalo controllers
    buffaloFatController.dispose();
    buffaloSnfController.dispose();
    buffaloRateController.dispose();
    buffaloTotalFatController.dispose();
    buffaloTotalSnfController.dispose();
    buffaloTotalRateController.dispose();

    super.dispose();
  }
}