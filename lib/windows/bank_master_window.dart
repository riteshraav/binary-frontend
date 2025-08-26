import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:intl/intl.dart';
import 'dart:developer';
import 'package:windows_sample/isar_repository/branch_master_isar_repository.dart';
import 'package:windows_sample/model/bank_model.dart';
import 'package:windows_sample/model/rate_model.dart';
import '../model/branch_model.dart';
import '../riverpod/providers.dart';
import '../widget/animated_button_widget.dart';
import 'package:flutter/services.dart';

class BankMasterWindow extends ConsumerStatefulWidget {
  @override
  _BankMasterWindowState createState() => _BankMasterWindowState();
}

class _BankMasterWindowState extends ConsumerState<BankMasterWindow> {
  // Controllers
  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final saveFocus = FocusNode();
  final FocusNode bankNameFocusNode = FocusNode();
  final FocusNode branchNameFocusNode = FocusNode();
  final FocusNode ifscFocusNode = FocusNode();

  // State variables
  late final bankService;
  late List<BankMaster> bankModelList;
  bool isLoading = true;

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
    bankService = ref.watch(bankServiceProvider);
    bankModelList = await bankService.getAllBanks();
    print('Bank model list length: ${bankModelList.length}');
    codeController.text = (bankModelList.length + 1).toString();
  }

  void _clearFields() {
    codeController.text = (bankModelList.length + 1).toString();
    nameController.clear();
    branchController.clear();
    ifscController.clear();
  }

  Future<void> _saveBank() async {
    log('_saveBank called');

    if (!_formKey.currentState!.validate()) return;

    try {
      await bankService.createBank(
        code: int.parse(codeController.text),
        name: nameController.text,
        branch: branchController.text,
        ifsc: ifscController.text,
      );

      final bank = BankMaster(
        name: nameController.text,
        branch: branchController.text,
        ifsc: ifscController.text,
        code: int.parse(codeController.text),
      );

      setState(() {
        bankModelList.add(bank);
        _clearFields();
      });

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('बँक यशस्वीरित्या जतन केला!'),
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
          const Icon(Icons.local_drink, color: Colors.white, size: 28),
          const SizedBox(width: 12),
          const SelectableText(
            'बँक नावे भरणे',
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
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: _buildTable(),
            ),
          ),
        ],
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
          _buildFormTitle(),
          const SizedBox(height: 20),
          _buildFormFields(),
          const SizedBox(height: 28),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildFormTitle() {
    return const Text(
      'बँक तपशील',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E40AF),
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildFormFields() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildCodeField()),
        const SizedBox(width: 24),
        Expanded(flex: 5, child: _buildNameField()),
        const SizedBox(width: 24),
        Expanded(flex: 2, child: _buildBranchField()),
        const SizedBox(width: 24),
        Expanded(flex: 2, child: _buildIfscField()),
      ],
    );
  }

  Widget _buildCodeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.qr_code_rounded, size: 16, color: Color(0xFF6B7280)),
            const SizedBox(width: 6),
            const Text(
              'बँकेचा कोड',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildTextField(
          controller: codeController,
          readOnly: true,
          validator: (value) => value?.isEmpty == true ? 'कृपया कोड प्रविष्ट करा' : null,
            suffixIcon: const Icon(Icons.lock_outline, color: Color(0xFF9CA3AF), size: 18),
          fillColor: const Color(0xFFF9FAFB),
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.business_rounded, size: 16, color: Color(0xFF6B7280)),
            const SizedBox(width: 6),
            const Text(
              'बँकेचे नाव',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
                letterSpacing: 0.2,
              ),
            ),
            const Text(
              ' *',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFFDC2626),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildTextField(
          controller: nameController,
          hintText: 'बँकेचे नाव प्रविष्ट करा',
          validator: (value) {
            if (value?.isEmpty == true) return 'कृपया बँकेचे नाव प्रविष्ट करा';
            if (value!.length < 3) return 'बँकेचे नाव किमान ३ अक्षरे असावे';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildBranchField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'शाखा',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 8),
        _buildTextField(
          controller: branchController,
          hintText: 'शाखेचे नाव प्रविष्ट करा',
          validator: (value) {
            if (value?.isEmpty == true) return 'कृपया शाखेचे नाव प्रविष्ट करा';
            if (value!.length < 3) return 'शाखेचे नाव किमान ३ अक्षरे असावे';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildIfscField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'आय एफ एस सी कोड',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 8),
        _buildTextField(
          controller: ifscController,
          hintText: 'आय एफ एस सी कोड प्रविष्ट करा',
          validator: (value) {
            if (value?.isEmpty == true) return 'कृपया बँकेचा आय एफ एस सी कोड प्रविष्ट करा';
            if (value!.length < 6) return 'आय एफ एस सी कोड किमान 6 अक्षरे असावे';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    String? hintText,
    String? Function(String?)? validator,
    bool readOnly = false,
    Widget? suffixIcon,
    Color? fillColor,
     FocusNode? focusNode,
  }) {
    focusNode ??= FocusNode();
    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E3A8A).withOpacity(0.04),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: RawKeyboardListener(
        focusNode: focusNode,
        onKey: (event) {
          if (event is RawKeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.space) {
            // 👇 Custom spacebar behavior
            final text = controller.text;
            final selection = controller.selection;

            // Insert a space manually instead of letting IME glitch
            final newText = text.replaceRange(
              selection.start,
              selection.end,
              " ",
            );

            TextEditingValue value = TextEditingValue(
              text: newText,
              selection: TextSelection.collapsed(offset: selection.start + 1),
            );

            switch(hintText){
              case 'बँकेचे नाव प्रविष्ट करा':
                nameController.value = value;
                break;
              case 'आय एफ एस सी कोड प्रविष्ट करा':
                ifscController.value = value;
              case 'शाखेचे नाव प्रविष्ट करा':
                branchController.value = value;

            }
          }
        },
        child: TextFormField(
          controller: controller,
          readOnly: readOnly,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor ?? Colors.white,
            hintText: hintText,
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB), width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2563EB), width: 2.5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            suffixIcon: suffixIcon != null
                ? Container(margin: const EdgeInsets.only(right: 8), child: suffixIcon)
                : null,
          ),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: readOnly ? const Color(0xFF6B7280) : const Color(0xFF111827),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        AnimatedSaveButton(
            focusNode: saveFocus,
            onPressed: _saveBank),
        const SizedBox(width: 16),
        _buildClearButton(),
      ],
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
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.clear_rounded, size: 18, color: Color(0xFF6B7280)),
            SizedBox(width: 8),
            Text(
              'Clear',
              style: TextStyle(
                fontSize: 15,
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

  Widget _buildTable() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
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
          columnSpacing: 16,
          headingRowHeight: 50,
          dataRowMinHeight: 0,
          dataRowMaxHeight: 0,
          headingRowColor: WidgetStateProperty.all(Colors.transparent),
          columns: const [
            DataColumn(
              label: SizedBox(
                width: 120,
                child: Text("कोड", style: headerStyle),
              ),
            ),
            DataColumn(
              label: SizedBox(
                width: 300,
                child: Text("बँकेचे नाव", style: headerStyle),
              ),
            ),
            DataColumn(
              label: SizedBox(
                width: 120,
                child: Text("शाखा", style: headerStyle),
              ),
            ),
            DataColumn(
              label: SizedBox(
                width: 120,
                child: Text("आय एफ एस सी", style: headerStyle),
              ),
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
                columnSpacing: 16,
                headingRowHeight: 0,
                dataRowMinHeight: 48,
                dataRowMaxHeight: 48,
                border: TableBorder(
                  horizontalInside: BorderSide(color: Colors.grey.shade300, width: 0.5),
                  verticalInside: BorderSide(color: Colors.grey.shade300, width: 0.5),
                ),
                headingRowColor: WidgetStateProperty.all(Colors.transparent),
                columns: const [
                  DataColumn(label: SizedBox(width: 120)),
                  DataColumn(label: SizedBox(width: 300)),
                  DataColumn(label: SizedBox(width: 120)),
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
      bankModelList.length,
          (index) {
        final entry = bankModelList.reversed.toList()[index];
        final isEven = index % 2 == 0;

        return DataRow(
          color: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered)) {
                return const Color(0xFF3B82F6).withOpacity(0.1);
              }
              return isEven ? Colors.white : Colors.grey[100];
            },
          ),
          cells: [
            _buildDataCell(entry.code.toString(), 120),
            _buildDataCell(entry.name, 300, overflow: TextOverflow.ellipsis),
            _buildDataCell(entry.branch, 120),
            _buildDataCell(entry.ifsc, 120),
          ],
        );
      },
    );
  }

  DataCell _buildDataCell(String text, double width, {TextOverflow? overflow}) {
    return DataCell(
      Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
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
    properties.add(IterableProperty<BankMaster>('bankModelList', bankModelList));
  }

  @override
  void dispose() {
    codeController.dispose();
    nameController.dispose();
    branchController.dispose();
    ifscController.dispose();
    super.dispose();
  }
}