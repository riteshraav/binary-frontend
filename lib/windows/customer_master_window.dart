import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:windows_sample/model/rate_group.dart';
import 'package:windows_sample/service/customer_service.dart';
import 'package:windows_sample/service/rate_group_service.dart';
import 'dart:developer';
import '../model/customer_model.dart'; // Add this import
import '../riverpod/providers.dart';


class CustomerMasterWindow extends ConsumerStatefulWidget {
  @override
  _CustomerMasterWindow createState() => _CustomerMasterWindow();
}

class _CustomerMasterWindow extends ConsumerState<CustomerMasterWindow> {
  // Controllers for text fields
  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController casteController = TextEditingController();
  final TextEditingController accountNoController = TextEditingController();
  final TextEditingController sabhasadNoController = TextEditingController();
  final TextEditingController bankCodeController = TextEditingController();
  final TextEditingController bankBranchController = TextEditingController();
  final TextEditingController bankAccountNoController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  final TextEditingController rateGroupController = TextEditingController();
  final TextEditingController localRateGroupController = TextEditingController();
  final TextEditingController mobileNo1Controller = TextEditingController();
  final TextEditingController mobileNo2Controller = TextEditingController();
  final TextEditingController aadharController = TextEditingController();
  final TextEditingController panNoController = TextEditingController();
  final TextEditingController animalCountController = TextEditingController();
  final TextEditingController averageQuantityController = TextEditingController();
  final TextEditingController adminIdController = TextEditingController();
  final TextEditingController adminCodeController = TextEditingController();
  final FocusNode nameFocus = FocusNode();
  final FocusNode branchFocus = FocusNode();
  final FocusNode casteFocus = FocusNode();
  final FocusNode accountNoFocus = FocusNode();
  final FocusNode sabhasadNoFocus = FocusNode();
  final FocusNode bankCodeFocus = FocusNode();
  final FocusNode bankBranchFocus = FocusNode();
  final FocusNode bankAccountNoFocus = FocusNode();
  final FocusNode ifscFocus = FocusNode();
  final FocusNode rateGroupFocus = FocusNode();
  final FocusNode localRateGroupFocus = FocusNode();
  final FocusNode mobileNo1Focus = FocusNode();
  final FocusNode mobileNo2Focus = FocusNode();
  final FocusNode aadharFocus = FocusNode();
  final FocusNode panNoFocus = FocusNode();
  final FocusNode animalCountFocus = FocusNode();
  final FocusNode averageQuantityFocus = FocusNode();
  final FocusNode adminIdFocus = FocusNode();
  final FocusNode adminCodeFocus = FocusNode();
  String adminId = "1";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedRateGroup;
  String? selectedLocalRateGroup;
  late List<String> localRateGroupStringList;
  late final List<RateGroup> localRateGroupList;
  late RateGroupService rateGroupService;
  // Switch button states
  String milkType = 'cow'; // cow, buffalo, mixed
  String classType = 'A'; // A, B, C
  String gender = 'male'; // male, female
  bool milkOn = false; // checkbox state

  // State variables
  late CustomerService customerService;
  late List<CustomerMaster> customerModelList ; // Initialize as empty list
  bool isLoading = true;
  bool expandTable = false;

  FocusNode  codeFocus =FocusNode();
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
      customerService = ref.read(customerServiceProvider); // Use ref.read instead of ref.watch
      final customers = await customerService.fetchAllCustomers(adminId);
      rateGroupService = ref.read(rateGroupProvider);
      localRateGroupList = await rateGroupService.listGroups();
       localRateGroupStringList = localRateGroupList.map((r)=>r.name).toList();
      if (mounted) {
        setState(() {
          customerModelList = customers ?? [];
          customerModelList.sort((a,b)=>int.parse(a.code).compareTo(int.parse(b.code)));
          codeController.text = (customerModelList.length + 1).toString();
          accountNoController.text = codeController.text;

        });
      }

      print('Customer model list length: ${customerModelList.length}');
    } catch (e) {
      print('Error loading data: $e');
      if (mounted) {
        setState(() {
          customerModelList = [];
          codeController.text = '1';
          accountNoController.text = '1';

        });
      }
    }
  }

  void _clearFields() {
    codeController.text = (customerModelList.length + 1).toString();
    accountNoController.text = codeController.text;
    nameController.clear();
    branchController.clear();
    casteController.clear();
    sabhasadNoController.clear();
    bankCodeController.clear();
    bankBranchController.clear();
    bankAccountNoController.clear();
    ifscController.clear();
    rateGroupController.clear();
    localRateGroupController.clear();
    mobileNo1Controller.clear();
    mobileNo2Controller.clear();
    aadharController.clear();
    panNoController.clear();
    animalCountController.clear();
    averageQuantityController.clear();
    adminIdController.clear();
    adminCodeController.clear();

    setState(() {
      milkType = 'cow';
      classType = 'A';
      gender = 'male';
      milkOn = false;
    });
  }

  Future<void> _saveCustomer() async {

    if (!_formKey.currentState!.validate()) return;

    try {
      final customer = CustomerMaster(
        code: codeController.text,
        name: nameController.text,
        branch: branchController.text,
        milkType: milkType,
        classType: classType,
        gender: gender,
        caste: casteController.text,
        milkOn: milkOn,
        accountNo: accountNoController.text,
        sabhasadNo: sabhasadNoController.text,
        bankCode: bankCodeController.text,
        bankBranch: bankBranchController.text,
        bankAccountNo: bankAccountNoController.text,
        ifsc: ifscController.text,
        rateGroup: selectedRateGroup!,
        localRateGroup: selectedLocalRateGroup!,
        mobileNo1: mobileNo1Controller.text,
        mobileNo2: mobileNo2Controller.text,
        aadhar: aadharController.text,
        panNo: panNoController.text,
        animalCount: animalCountController.text,
        averageQuantity: averageQuantityController.text,
        adminId:"1",
        adminCode: adminCodeController.text,
      );
      await customerService.addCustomer(customer);

      setState(() {
        customerModelList.add(customer);
        _clearFields();
      });

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ग्राहक यशस्वीरित्या जतन केला!'),
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

  // Validation methods
  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'कृपया $fieldName प्रविष्ट करा';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'कृपया नाव प्रविष्ट करा';
    }
    if (value.trim().length < 2) {
      return 'नाव किमान २ अक्षरे असावे';
    }

    return null;
  }

  String? _validateMobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Optional field
    }
    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value.trim())) {
      return 'वैध मोबाईल नंबर प्रविष्ट करा (10 अंक)';
    }
    return null;
  }

  String? _validateAadhar(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Optional field
    }
    if (!RegExp(r'^\d{12}$').hasMatch(value.trim())) {
      return 'आधार नंबर 12 अंकांचा असावा';
    }
    return null;
  }

  String? _validatePAN(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Optional field
    }
    if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(value.trim().toUpperCase())) {
      return 'वैध PAN नंबर प्रविष्ट करा (उदा: ABCDE1234F)';
    }
    return null;
  }

  String? _validateIFSC(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Optional field
    }
    if (!RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(value.trim().toUpperCase())) {
      return 'वैध IFSC कोड प्रविष्ट करा (उदा: SBIN0000001)';
    }
    return null;
  }

  String? _validateNumber(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return null; // Optional field
    }
    if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(value.trim())) {
      return '$fieldName मध्ये फक्त संख्या असावी';
    }
    return null;
  }

  String? _validateAccountNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Optional field
    }
    if (!RegExp(r'^\d{9,18}$').hasMatch(value.trim())) {
      return 'खाते नंबर 9-18 अंकांचा असावा';
    }
    return null;
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
    required FocusNode focusNode,
     FocusNode? nextFocus,
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
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
            letterSpacing: 0.1,
          ),
        ),
        const SizedBox(height: 3),
        Container(
          height: 40, // Further reduced height
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
            onFieldSubmitted: (_) {
              if (nextFocus != null) {
                FocusScope.of(context).requestFocus(nextFocus);
              } else {
                focusNode.unfocus();
              }
            },
            textInputAction: nextFocus != null ? TextInputAction.next : TextInputAction.done,
            controller: controller,
            focusNode:focusNode,
            readOnly: readOnly,
            validator: validator,
            keyboardType: keyboardType,
            style: TextStyle(
              fontSize: 20, // Reduced font size
              fontWeight: FontWeight.w500,
              color: readOnly ? const Color(0xFF6B7280) : const Color(0xFF111827),
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: fillColor ?? Colors.white,
            //  hintText: hintText,
              hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 20),
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
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              suffixIcon: suffixIcon != null
                  ? Container(margin: const EdgeInsets.only(right: 4), child: suffixIcon)
                  : null,
              errorStyle: const TextStyle(fontSize: 9, height: 0.5),
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
          const Icon(Icons.person, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          const SelectableText(
            'ग्राहकाची माहिती भरणे',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: () => setState(() => expandTable = !expandTable),
            icon: Icon(expandTable ? Icons.expand_more : Icons.expand_less, size: 16),
            label: Text(expandTable ? 'Minimize Table' : 'Expand Table', style: const TextStyle(fontSize: 12)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.2),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              minimumSize: const Size(0, 0),
            ),
          ),
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
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
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
          if(!expandTable)
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
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
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
              const SizedBox(height: 5),
              _buildPersonalInfoSection(),
              const SizedBox(height: 5),
              _buildMilkDetailsSection(),
              const SizedBox(height: 5),
              _buildBankDetailsSection(),
              const SizedBox(height: 5),
              _buildContactDetailsSection(),
              const SizedBox(height: 5),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormTitle() {
    return const Text(
      'ग्राहक तपशील',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E40AF),
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Use horizontal layout for better space utilization
        Row(
          children: [
            Expanded(flex: 1, child: _buildCodeField()),
            const SizedBox(width: 8),
            Expanded(flex: 2, child: _buildNameField()),
            const SizedBox(width: 8),
            Expanded(flex: 2, child: _buildBranchField()),
            const SizedBox(width: 8),
            Expanded(flex: 1, child: _buildCasteField()),
            const SizedBox(width: 8),
            Expanded(child: _buildGenderSwitch()),
            const SizedBox(width: 8),
            Expanded(child: _buildMilkOnCheckbox()),
          ],
        ),
        const SizedBox(height: 8),

      ],
    );
  }

  Widget _buildMilkDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: _buildMilkTypeSwitch()),
            const SizedBox(width: 8),
            Expanded(child: _buildClassTypeSwitch()),
            const SizedBox(width: 8),
            Expanded(
              child: _buildDropdownField<String>(
                label: 'दर गट *',
                hintText: 'दर गट निवडा',
                value: selectedRateGroup,
                items: localRateGroupStringList,
                onChanged: (val) {
                  setState(() {
                    selectedRateGroup = val;
                  });
                },
                validator: (val) => _validateRequired(val, 'दर गट'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildDropdownField<String>(
                label: 'स्थानिक दर गट *',
                hintText: 'स्थानिक दर गट निवडा',
                value: selectedLocalRateGroup,
                items: localRateGroupStringList,
                onChanged: (val) {
                  setState(() {
                    selectedLocalRateGroup = val;
                  });
                },
                validator: (val) => _validateRequired(val, 'स्थानिक दर गट'),
              ),
            ),

            const SizedBox(width: 8),
            Expanded(child: _buildTextField(
              controller: animalCountController,
              label: 'पशुधन संख्या',
              hintText: 'पशुधन संख्या प्रविष्ट करा',
              keyboardType: TextInputType.number,
              validator: (value) => _validateNumber(value, 'पशुधन संख्या'), focusNode: animalCountFocus, nextFocus: averageQuantityFocus,
            )),
            const SizedBox(width: 8),
            Expanded(child: _buildTextField(
              controller: averageQuantityController,
              label: 'सरासरी दैनंदिन दुध',
              hintText: 'सरासरी प्रमाण प्रविष्ट करा',
              keyboardType: TextInputType.number,
              validator: (value) => _validateNumber(value, 'सरासरी प्रमाण'), focusNode: averageQuantityFocus, nextFocus: accountNoFocus,
            )),
          ],
        ),
        const SizedBox(height: 8),

      ],
    );
  }
  Widget _buildDropdownField<T>({
    required String label,
    required String hintText,
    required T? value,
    required List<T> items,
    required Function(T?) onChanged,
    String? Function(T?)? validator,
    Color? fillColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
            letterSpacing: 0.1,
          ),
        ),
        const SizedBox(height: 3),
        Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1E3A8A).withOpacity(0.03),
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: DropdownButtonFormField<T>(
            value: value,
            validator: validator,
            onChanged: onChanged,
            dropdownColor: Colors.white,
            isExpanded: true,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xFF111827),
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: fillColor ?? Colors.white,
           //   hintText: hintText,
              hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 20),
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
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              errorStyle: const TextStyle(fontSize: 9, height: 0.5),
            ),
            items: items
                .map((e) => DropdownMenuItem<T>(
              value: e,
              child: Text(
                e.toString(),
                style: const TextStyle(fontSize: 18),
              ),
            ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildBankDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: _buildTextField(
              controller: accountNoController,
              label: 'खाते नं.',
              hintText: 'खाते नं. प्रविष्ट करा',
              keyboardType: TextInputType.number, focusNode: accountNoFocus, nextFocus: sabhasadNoFocus,
            )),
            const SizedBox(width: 8),
            Expanded(child: _buildTextField(
              controller: sabhasadNoController,
              label: 'सभासद नं.',
              hintText: 'सभासद नं. प्रविष्ट करा', focusNode: sabhasadNoFocus, nextFocus: bankCodeFocus,
            )),
            const SizedBox(width: 8),
            Expanded(child: _buildTextField(
              controller: bankCodeController,
              label: 'बँक कोड',
              hintText: 'बँक कोड प्रविष्ट करा', focusNode:bankCodeFocus, nextFocus: bankBranchFocus,
            )),
            const SizedBox(width: 8),

            Expanded(child: _buildTextField(
              controller: bankBranchController,
              label: 'बँक शाखा',
              hintText: 'बँक शाखा प्रविष्ट करा', focusNode:bankBranchFocus , nextFocus: bankAccountNoFocus,
            )),
            const SizedBox(width: 8),
            Expanded(child: _buildTextField(
              controller: bankAccountNoController,
              label: 'बँक खाते नं.',
              hintText: 'बँक खाते नं. प्रविष्ट करा',
              validator: _validateAccountNumber,
              keyboardType: TextInputType.number, focusNode: bankAccountNoFocus, nextFocus: ifscFocus ,
            )),
            const SizedBox(width: 8),
            Expanded(child: _buildTextField(
              controller: ifscController,
              label: 'IFSC कोड',
              hintText: 'IFSC कोड प्रविष्ट करा',
              validator: _validateIFSC, focusNode: ifscFocus, nextFocus: mobileNo1Focus,
            )),
          ],
        ),
        const SizedBox(height: 8),

      ],
    );
  }

  Widget _buildContactDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: _buildTextField(
              controller: mobileNo1Controller,
              label: 'मोबाईल नं. १ ',
              hintText: 'मोबाईल नं. प्रविष्ट करा',
              keyboardType: TextInputType.phone, focusNode: mobileNo1Focus, nextFocus: mobileNo2Focus,

            )),
            const SizedBox(width: 8),
            Expanded(child: _buildTextField(
              controller: mobileNo2Controller,
              label: 'मोबाईल नं. २',
              hintText: 'मोबाईल नं. प्रविष्ट करा',
              keyboardType: TextInputType.phone,
              validator: _validateMobile, focusNode: mobileNo2Focus, nextFocus: aadharFocus,
            )),
            const SizedBox(width: 8),
            Expanded(child: _buildTextField(
              controller: aadharController,
              label: 'आधार नं.',
              hintText: 'आधार नं. प्रविष्ट करा',
              keyboardType: TextInputType.number,
              validator: _validateAadhar, focusNode: aadharFocus, nextFocus: panNoFocus,
            )),
            const SizedBox(width: 8),
            Expanded(child: _buildTextField(
              controller: panNoController,
              label: 'पॅन नं.',
              hintText: 'पॅन नं. प्रविष्ट करा',
              validator: _validatePAN, focusNode: panNoFocus, nextFocus: adminIdFocus,
            )),
            const SizedBox(width: 8),
            Expanded(child: _buildTextField(
              controller: adminIdController,
              label: 'प्रशासक ID',
              hintText: 'प्रशासक ID प्रविष्ट करा', focusNode:  adminIdFocus, nextFocus: adminCodeFocus,
            )),
            const SizedBox(width: 8),
            Expanded(child: _buildTextField(
              controller: adminCodeController,
              label: 'प्रशासक कोड',
              hintText: 'प्रशासक कोड प्रविष्ट करा', focusNode: adminCodeFocus, nextFocus: null,
            )),
          ],
        ),
        const SizedBox(height: 8),

      ],
    );
  }

  Widget _buildCodeField() {
    return _buildTextField(
      controller: codeController,
      label: 'कोड',
      readOnly: true,
      suffixIcon: const Icon(Icons.lock_outline, color: Color(0xFF9CA3AF), size: 14), focusNode: codeFocus  , nextFocus: null,
    );
  }

  Widget _buildNameField() {
    return _buildTextField(
      controller: nameController,
      label: 'नाव *',
      hintText: 'नाव प्रविष्ट करा',
      validator: _validateName, focusNode: nameFocus, nextFocus: branchFocus,
    );
  }

  Widget _buildBranchField() {
    return _buildTextField(
      controller: branchController,
      label: 'शाखा *',
      hintText: 'शाखा प्रविष्ट करा',
      validator: (value) => _validateRequired(value, 'शाखा'), focusNode: branchFocus , nextFocus: casteFocus,
    );
  }

  Widget _buildCasteField() {
    return _buildTextField(
      controller: casteController,
      label: 'जात',
      hintText: 'जात प्रविष्ट करा', focusNode: casteFocus, nextFocus: null,
    );
  }

  Widget _buildMilkTypeSwitch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'दुधाचे प्रकार',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 3),
        Container(
          height: 40  ,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFD1D5DB)),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              _buildSwitchButton('गाय', 'cow', milkType == 'cow', (value) {
                setState(() => milkType = 'cow');
              }),
              _buildSwitchButton('म्हैस', 'buffalo', milkType == 'buffalo', (value) {
                setState(() => milkType = 'buffalo');
              }),
              _buildSwitchButton('एकत्र', 'mixed', milkType == 'mixed', (value) {
                setState(() => milkType = 'mixed');
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildClassTypeSwitch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'वर्ग प्रकार',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 3),
        Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFD1D5DB)),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              _buildSwitchButton('A', 'A', classType == 'A', (value) {
                setState(() => classType = 'A');
              }),
              _buildSwitchButton('B', 'B', classType == 'B', (value) {
                setState(() => classType = 'B');
              }),
              _buildSwitchButton('C', 'C', classType == 'C', (value) {
                setState(() => classType = 'C');
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGenderSwitch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'लिंग',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 3),
        Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFD1D5DB)),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              _buildSwitchButton('पुरुष', 'male', gender == 'male', (value) {
                setState(() => gender = 'male');
              }),
              _buildSwitchButton('महिला', 'female', gender == 'female', (value) {
                setState(() => gender = 'female');
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMilkOnCheckbox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'दूध चालू',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 3),
        Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFD1D5DB)),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: milkOn,
                onChanged: (value) {
                  setState(() => milkOn = value ?? false);
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
              const Text(
                'दूध चालू आहे',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF374151),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchButton(String label, String value, bool isSelected, ValueChanged<bool> onChanged) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(true),
        child: Container(
          height: 50,
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
      fontSize: 16,
    );

    return Container(
      height: 40, // Reduced header height
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
              label: SizedBox(width: 40, child: Text("कोड", style: headerStyle)),
            ),
            DataColumn(
              label: SizedBox(width: 180, child: Text("नाव", style: headerStyle)),
            ),
            DataColumn(
              label: SizedBox(width: 140, child: Text("शाखा", style: headerStyle)),
            ),
            DataColumn(
              label: SizedBox(width: 60, child: Text("दूध", style: headerStyle)),
            ),
            DataColumn(
              label: SizedBox(width: 40, child: Text("वर्ग", style: headerStyle)),
            ),
            DataColumn(
              label: SizedBox(width: 50, child: Text("लिंग", style: headerStyle)),
            ),
            DataColumn(
              label: SizedBox(width: 60, child: Text("जात", style: headerStyle)),
            ),
            DataColumn(
              label: SizedBox(width: 60, child: Text("दूध चालू", style: headerStyle)),
            ),
            DataColumn(
              label: SizedBox(width: 180, child: Text("खाते नं.", style: headerStyle)),
            ),
            DataColumn(
              label: SizedBox(width: 180, child: Text("सभासद नं.", style: headerStyle)),
            ),
            DataColumn(
              label: SizedBox(width: 120, child: Text("मोबाईल", style: headerStyle)),
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
                dataRowMinHeight: 43, // Reduced row height
                dataRowMaxHeight: 43,
                border: TableBorder(
                  horizontalInside: BorderSide(color: Colors.grey.shade300, width: 0.5),
                  verticalInside: BorderSide(color: Colors.grey.shade300, width: 0.5),
                ),
                headingRowColor: WidgetStateProperty.all(Colors.transparent),
                columns: const [
                  DataColumn(label: SizedBox(width: 40)),
                  DataColumn(label: SizedBox(width: 180)),
                  DataColumn(label: SizedBox(width: 140)),
                  DataColumn(label: SizedBox(width: 60)),
                  DataColumn(label: SizedBox(width: 40)),
                  DataColumn(label: SizedBox(width: 50)),
                  DataColumn(label: SizedBox(width: 60)),
                  DataColumn(label: SizedBox(width: 60)),
                  DataColumn(label: SizedBox(width: 180)),
                  DataColumn(label: SizedBox(width: 180)),
                  DataColumn(label: SizedBox(width: 120)),
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
            _buildDataCell(entry.code.toString(), 40),
            _buildDataCell(entry.name, 180, overflow: TextOverflow.ellipsis),
            _buildDataCell(entry.branch, 140),
            _buildDataCell(_getMilkTypeDisplay(entry.milkType), 60),
            _buildDataCell(entry.classType, 40),
            _buildDataCell(_getGenderDisplay(entry.gender), 50),
            _buildDataCell(entry.caste, 60),
            _buildDataCell(entry.milkOn ? 'होय' : 'नाही', 60),
            _buildDataCell(entry.accountNo, 180),
            _buildDataCell(entry.sabhasadNo, 180),
            _buildDataCell(entry.mobileNo1, 120),
          ],
        );
      },
    );
  }

  String _getMilkTypeDisplay(String milkType) {
    switch (milkType) {
      case 'cow':
        return 'गाय';
      case 'buffalo':
        return 'म्हैस';
      case 'mixed':
        return 'एकत्र';
      default:
        return milkType;
    }
  }

  String _getGenderDisplay(String gender) {
    switch (gender) {
      case 'male':
        return 'पुरुष';
      case 'female':
        return 'महिला';
      default:
        return gender;
    }
  }

  DataCell _buildDataCell(String text, double width, {TextOverflow? overflow}) {
    return DataCell(
      Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 15, // Reduced font size for table
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
    // Dispose all controllers
    codeController.dispose();
    nameController.dispose();
    branchController.dispose();
    casteController.dispose();
    accountNoController.dispose();
    sabhasadNoController.dispose();
    bankCodeController.dispose();
    bankBranchController.dispose();
    bankAccountNoController.dispose();
    ifscController.dispose();
    rateGroupController.dispose();
    localRateGroupController.dispose();
    mobileNo1Controller.dispose();
    mobileNo2Controller.dispose();
    aadharController.dispose();
    panNoController.dispose();
    animalCountController.dispose();
    averageQuantityController.dispose();
    adminIdController.dispose();
    adminCodeController.dispose();
    super.dispose();
  }
}