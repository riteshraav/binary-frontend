import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'dart:developer';
import 'package:windows_sample/model/customer_model.dart';
import 'package:windows_sample/model/deduction.dart';
import 'package:windows_sample/model/opening_balance_model.dart';
import 'package:windows_sample/service/customer_service.dart';
import 'package:windows_sample/service/deduction_service.dart';
import 'package:windows_sample/service/opening_balance_service.dart';
import '../riverpod/providers.dart';
import '../widget/animated_button_widget.dart';
import 'package:flutter/services.dart';

class PotKhateNaveBharaneWindow extends ConsumerStatefulWidget {
  @override
  _BankMasterWindowState createState() => _BankMasterWindowState();
}

class _BankMasterWindowState extends ConsumerState<PotKhateNaveBharaneWindow> {
  // Controllers
  final TextEditingController customerCodeController = TextEditingController();
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController deductionCodeController = TextEditingController();
  final TextEditingController deductionNameController = TextEditingController();
  final TextEditingController aarambhiShillakController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final saveFocus = FocusNode();
  String adminId = '1';
   int amountType = 0 ;
  // State variables
  late DeductionServiceImpl deductionServiceImpl;
  late List<Deduction> deductionList;
  late OpeningBalanceService openingBalanceService;
  late List<CustomerMaster> customerMasterList;
  late CustomerService customerService;
  late CustomerMaster? selectedCustomer;
  late Deduction selectedDeduction;
  late OpeningBalance currentOpeningBalance;
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
    deductionServiceImpl = ref.watch(deductionProvider);
    deductionList = await deductionServiceImpl.fetchAllDeductions();
    print('Bank model list length: ${deductionList.length}');
    customerService = ref.watch(customerServiceProvider);

    customerMasterList =await customerService.fetchAllCustomers(adminId);
    openingBalanceService = ref.watch(openingBalanceProvider);
    selectedDeduction = deductionList.first;
    deductionCodeController.text = selectedDeduction.code;
    deductionNameController.text = selectedDeduction.name;
  }

  void _clearFields() {
    selectedCustomer = null;
    customerNameController.clear();
    customerCodeController.clear();
    aarambhiShillakController.clear();
    setState(() {

    });
  }
  void _searchDeduction()async{
    if(selectedCustomer == null)
      {
        return;
      }
    OpeningBalance? balance =await openingBalanceService.findBalanceByCustomerAndDeduction(selectedCustomer!.code,selectedDeduction.code);
    if(balance == null)
      {
        return;
      }
    currentOpeningBalance = balance;
    double currentOpening = currentOpeningBalance.openingBalance;
    if(currentOpening < 0)
      {
        aarambhiShillakController.text = (currentOpening * -1).toStringAsFixed(2);
        amountType = 1;
      }
    else {
      aarambhiShillakController.text = currentOpeningBalance.openingBalance.toStringAsFixed(2);
      amountType = 0;

    }
    setState(() {

    });
  }

  Future<void> _saveOpeningBalance() async {
    log('_save opening balance called called');

    try {
    if(selectedCustomer == null )
      {
        return;
      }
    double balance = double.tryParse(aarambhiShillakController.text)??0 ;
    if(balance ==0) return;

    if(amountType  == 1 )
      {
        balance = balance * -1;
      }
    print('amount type is $amountType');
    print('balance becomes $balance');
    OpeningBalance openingBalance =
    OpeningBalance(
        deductionCode: selectedDeduction.code,
        customerCode: selectedCustomer!.code,
        openingBalance: balance,
        crTot: 0,
        drTot: 0,
        clBal: 0,
        clTot: 0);
    openingBalanceService.addBalance(openingBalance);
    _clearFields();
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
            'पोट खाते नावे भरणे',
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
          SizedBox(width: 1000,)
        ],
      ),
    );
  }

  Widget _buildFormSection() {
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

          _buildDeductionAutocompleteField(
            mainContext: context,
            label: 'खात्याचे नाव',
            icon: Icons.book,
            codeController: deductionCodeController,
            nameController: deductionNameController,
            options: deductionList,
            onSelected: (Deduction d) async {
              selectedDeduction = d;
              _searchDeduction();

              setState(() {});
            },
          ),
         SizedBox(height: 20,),
         _buildCustomerAutocompleteField(
           mainContext: context,
           label: 'उत्पादक',
           icon: Icons.person,
           codeController: customerCodeController,
           nameController: customerNameController,
           options: customerMasterList,
           onSelected: (CustomerMaster c) async {
             selectedCustomer = c;
             _searchDeduction();
             setState(() {});
           },
         ),
          SizedBox(height: 20,),
          Row(
            children: [
              Expanded(child: _buildCompactInputField("आरंभी शिल्लक", aarambhiShillakController, Icons.currency_rupee)),
              SizedBox(width: 20,),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFFD1D5DB)),
                    borderRadius: BorderRadius.circular(6),
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
              ),
            ],
          ),
          SizedBox(height: 20,),
          _buildActionButtons()
        ],
      ),
    );
  }


  Widget _buildSwitchButton(String label,int  value, bool isSelected, ValueChanged<bool> onChanged) {
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
  Widget _buildCustomerAutocompleteField({
    required BuildContext mainContext,
    required String label,
    required IconData icon,
    required TextEditingController codeController,
    required TextEditingController nameController,
    required List<CustomerMaster> options,
    required void Function(CustomerMaster) onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18, // Increased from 14
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E3A8A),
          ),
        ),
        SizedBox(height: 10,),
        Container(
          height: 45,
          child: Autocomplete<CustomerMaster>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return const Iterable<CustomerMaster>.empty();
              }
              return options.where(
                    (c) =>
                c.code.toLowerCase().contains(
                  textEditingValue.text.trim().toLowerCase(),
                ) ||
                    c.name.toLowerCase().contains(
                      textEditingValue.text.trim().toLowerCase(),
                    ),
              );
            },
            displayStringForOption: (CustomerMaster option) =>
            "${option.code} - ${option.name}",
            onSelected: (CustomerMaster selection) {
              codeController.text = selection.code;
              nameController.text = selection.name;
              onSelected(selection);
            },
            // 👇 Custom dropdown list
            optionsViewBuilder: (context, onSelected, options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4,
                  child: SizedBox(
                    height: 250, // 👈 Increase dropdown height
                    width: 400,  // 👈 Adjust width if needed
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final CustomerMaster option = options.elementAt(index);
                        return InkWell(
                          onTap: () => onSelected(option),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0), // 👈 Bigger padding for larger items
                            child: Text(
                              "${option.code} - ${option.name}",
                              style: const TextStyle(fontSize: 18), // 👈 Bigger font size
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },

            fieldViewBuilder: (
                context,
                controller,
                focusNode,
                onEditingComplete,
                ) {
              controller.text = '${codeController.text} ${nameController.text}';
              return TextField(
                onEditingComplete:onEditingComplete,
                controller: controller,
                focusNode: focusNode,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    icon,
                    size: 20,
                    color: const Color(0xFF6B7280),
                  ),
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
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear, size: 20),
                    onPressed: () {
                      controller.clear();
                      codeController.clear();
                      nameController.clear();
                      selectedCustomer = null;
                      setState(() {});
                    },
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
  Widget _buildDeductionAutocompleteField({
    required BuildContext mainContext,
    required String label,
    required IconData icon,
    required TextEditingController codeController,
    required TextEditingController nameController,
    required List<Deduction> options,
    required void Function(Deduction) onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18, // Increased from 14
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E3A8A),
          ),
        ),
        SizedBox(height: 10,),
        Container(
          height: 45,
          child: Autocomplete<Deduction>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return const Iterable<Deduction>.empty();
              }
              return options.where(
                    (c) =>
                c.code.toLowerCase().contains(
                  textEditingValue.text.trim().toLowerCase(),
                ) ||
                    c.name.toLowerCase().contains(
                      textEditingValue.text.trim().toLowerCase(),
                    ),
              );
            },
            displayStringForOption: (Deduction option) =>
            "${option.code} - ${option.name}",
            onSelected: (Deduction selection) {
              codeController.text = selection.code;
              nameController.text = selection.name;
              onSelected(selection);
            },
            // 👇 Custom dropdown list
            optionsViewBuilder: (context, onSelected, options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4,
                  child: SizedBox(
                    height: 250, // 👈 Increase dropdown height
                    width: 400,  // 👈 Adjust width if needed
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Deduction option = options.elementAt(index);
                        return InkWell(
                          onTap: () => onSelected(option),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0), // 👈 Bigger padding for larger items
                            child: Text(
                              "${option.code} - ${option.name}",
                              style: const TextStyle(fontSize: 18), // 👈 Bigger font size
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },

            fieldViewBuilder: (
                context,
                controller,
                focusNode,
                onEditingComplete,
                ) {
              controller.text = '${codeController.text} ${nameController.text}';
              return TextField(
                onEditingComplete:onEditingComplete,
                controller: controller,
                focusNode: focusNode,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    icon,
                    size: 20,
                    color: const Color(0xFF6B7280),
                  ),
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
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear, size: 20),
                    onPressed: () {
                      controller.clear();
                      codeController.clear();
                      nameController.clear();
                      selectedCustomer = null;
                      setState(() {});
                    },
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
  Widget _buildCompactInputField(
      String label,
      TextEditingController controller,
      IconData icon, {
        BuildContext? context,
        FocusNode? currentFocus,
        FocusNode? nextFocus,
        TextInputType keyboardType = TextInputType.number,
        bool isRequired = true,
        bool readOnly = false,
        void Function(String)? onChanged,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18, // Increased from 14
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E3A8A),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 55,
          child: TextFormField(
            focusNode: currentFocus,
            onEditingComplete: () {
              currentFocus?.unfocus();
              if (context != null) {
                FocusScope.of(context).requestFocus(nextFocus);
              }
            },
            onChanged: onChanged,
            readOnly: readOnly,
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
              signed: false,
            ),
            style: const TextStyle(fontSize: 20),

            // 👇 Add this to only allow doubles (digits + 1 optional decimal point)
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
            ],

            validator: (value) {
              if (isRequired && (value == null || value.trim().isEmpty)) {
                return ''; // empty string → red border but no error text
              }
              // Validate it's a double
              if (value != null && value.isNotEmpty) {
                final parsed = double.tryParse(value);
                if (parsed == null) {
                  return ''; // invalid number → red border
                }
              }
              return null;
            },

            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(icon, size: 14, color: const Color(0xFF6B7280)),
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
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildActionButtons() {
    return Row(
      children: [
        AnimatedSaveButton(
            focusNode: saveFocus,
            onPressed: _saveOpeningBalance),
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



  @override
  void dispose() {
    customerCodeController.dispose();

    super.dispose();
  }
}