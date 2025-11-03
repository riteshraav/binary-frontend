import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:windows_sample/model/customer_model.dart';
import 'package:windows_sample/model/daily_collection_data.dart';
import 'package:windows_sample/model/milk_collection_model.dart';
import 'package:windows_sample/model/rate_model.dart';
import 'package:windows_sample/riverpod/providers.dart';
import 'package:windows_sample/service/customer_service.dart';
import 'package:windows_sample/service/daily_collection_service.dart';
import 'package:windows_sample/service/milk_collection_service.dart';
import 'package:windows_sample/service/rate_chart_service.dart';
import 'package:windows_sample/service/rate_master_service.dart';
import 'package:windows_sample/widget/animated_button_widget.dart';import '../api/milk_collection_api.dart';

class MilkCollectionWindow extends ConsumerStatefulWidget {
  @override
  _MilkCollectionWindowState createState() => _MilkCollectionWindowState();
}

class _MilkCollectionWindowState extends ConsumerState<MilkCollectionWindow> {
  TextEditingController codeController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  final TextEditingController fatController = TextEditingController();
  final TextEditingController snfController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  late DailyCollectionData? buffaloCollectionData;
  late DailyCollectionData? cowCollectionData;
  late Map<String,RateModel> rateMap = {};
  late DailyCollectionService dailyCollectionService;
  bool isSaving = false;
  final fatFocus = FocusNode();
  final snfFocus = FocusNode();
  final quantityFocus = FocusNode();
  final customerFocus = FocusNode();
  final saveFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool isEditing = false;
  late MilkCollectionService milkCollectionService;
  CustomerMaster? selectedCustomer;
  late CustomerService customerService;
  bool isCowMilk = true; // true for cow, false for buffalo
  late List<CustomerMaster> customerModelList;
  bool isLoading = true;
  String adminId = "1";
  List<MilkCollectionModel> milkCollectionList = [];
  MilkCollectionModel? editingMilkCollectionModel;
  late List<RateModel> rateModelList;
  late RateService rateService;
  late RateChartService rateChartService;
  DateTime selectedDate = DateTime.now().copyWith(
    hour: 0,
    minute: 0,
    second: 0,
    millisecond: 0,
    microsecond: 0,
  );  // Sample data for demonstration
  void _clearFields() {
    codeController.clear();
    customerNameController.clear();
    fatController.clear();
    snfController.clear();
    rateController.clear();
    amountController.clear();
    quantityController.clear();
    editingMilkCollectionModel = null;
    isEditing = false;
    selectedCustomer = null;
    setState(() {});
  }

  void _clearNumericFields() {
    fatController.clear();
    snfController.clear();
    rateController.clear();
    amountController.clear();
    quantityController.clear();
    editingMilkCollectionModel = null;
    isEditing = false;
    setState(() {});
  }

  CustomerMaster? findCustomer(String code) {
    for (CustomerMaster c in customerModelList) {
      if (c.code == code) {
        return c;
      }
    }
    return null;
  }

  void _editMilkCollection(MilkCollectionModel milkCollectionModel) {
    isEditing = true;
    selectedCustomer = findCustomer(milkCollectionModel.customerId);
    codeController.text = milkCollectionModel.customerId;
    customerNameController.text = findCustomerName(
      milkCollectionModel.customerId,
    );
    fatController.text = milkCollectionModel.fat.toString();
    snfController.text = milkCollectionModel.snf.toString();
    rateController.text = milkCollectionModel.rate.toString();
    amountController.text = milkCollectionModel.amount.toString();
    quantityController.text = milkCollectionModel.quantity.toString();
    editingMilkCollectionModel = milkCollectionModel;
    if (milkCollectionModel.milkType == 0) {
      isCowMilk = true;
    } else {
      isCowMilk = false;
    }
    setState(() {});
    print('is editing is $isEditing');
  }

  Future<void> _deleteMilkCollection(
    MilkCollectionModel milkCollectionModel,
  )
  async {
    milkCollectionService.deleteCollection(milkCollectionModel.id.toInt());
    milkCollectionList.remove(milkCollectionModel);
    if (milkCollectionModel.milkType == 0) {
      cowCollectionData!.totalAmount -= milkCollectionModel.amount;
      cowCollectionData!.quantity -= milkCollectionModel.quantity;
      cowCollectionData!.avgFat =
          (cowCollectionData!.customerCount - 1 == 0)
              ? ((cowCollectionData!.avgFat *
                      cowCollectionData!.customerCount) -
                  milkCollectionModel.fat)
              : ((cowCollectionData!.avgFat *
                          cowCollectionData!.customerCount) -
                      milkCollectionModel.fat) /
                  (cowCollectionData!.customerCount - 1);
      cowCollectionData!.avgSnf =
          (cowCollectionData!.customerCount - 1 == 0)
              ? ((cowCollectionData!.avgSnf *
                      cowCollectionData!.customerCount) -
                  milkCollectionModel.snf)
              : ((cowCollectionData!.avgSnf *
                          cowCollectionData!.customerCount) -
                      milkCollectionModel.snf) /
                  (cowCollectionData!.customerCount - 1);
      cowCollectionData!.customerCount -= 1;
      dailyCollectionService.updateCollection(cowCollectionData!);
    } else {
      buffaloCollectionData!.totalAmount -= milkCollectionModel.amount;
      buffaloCollectionData!.quantity -= milkCollectionModel.quantity;
      buffaloCollectionData!.avgFat =
          (buffaloCollectionData!.customerCount - 1 == 0)
              ? ((buffaloCollectionData!.avgFat *
                      buffaloCollectionData!.customerCount) -
                  milkCollectionModel.fat)
              : ((buffaloCollectionData!.avgFat *
                          buffaloCollectionData!.customerCount) -
                      milkCollectionModel.fat) /
                  (buffaloCollectionData!.customerCount - 1);
      buffaloCollectionData!.avgSnf =
          (buffaloCollectionData!.customerCount - 1 == 0)
              ? ((buffaloCollectionData!.avgSnf *
                      buffaloCollectionData!.customerCount) -
                  milkCollectionModel.snf)
              : ((buffaloCollectionData!.avgSnf *
                          buffaloCollectionData!.customerCount) -
                      milkCollectionModel.snf) /
                  (buffaloCollectionData!.customerCount - 1);
      buffaloCollectionData!.customerCount -= 1;
      dailyCollectionService.updateCollection(buffaloCollectionData!);
    }
    setState(() {});
    showToast(
      isEditing ? "Entry edited" : "Entry deleted",
      backgroundColor: Colors.green,
      position: ToastPosition.top,
      textStyle: const TextStyle(fontSize: 16, color: Colors.white),
      duration: const Duration(seconds: 2),
    );
  }

  String _currentDate() => DateFormat('dd-MM-yyyy').format(selectedDate);
  void _dateChange() async {
    final DateTime? picked =
    await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null &&
        picked != selectedDate) {
      rateModelList = await rateService.getLatestRate(picked);
      milkCollectionList =await milkCollectionService.getCollectionsByDateAndByAdminId(selectedDate, adminId);
      setState(() {
        selectedDate = picked;
      });
    }
  }
  void findRate(String value) {

    if (fatController.text.isEmpty ||
        snfController.text.isEmpty ||
        quantityController.text.isEmpty || selectedCustomer == null) {
      showToast("all fields are required");
      return;
    }
    double fat = double.parse(fatController.text);
    double snf = double.parse(snfController.text);
    double quantity = double.parse(quantityController.text);
    // TODO: when we will add rategrop for customers update here to find  rate for selected customer
    print('');
    RateModel? currentRate;
    isCowMilk = selectedCustomer!.milkType == 'buffalo'?false:true;

      currentRate = rateMap['${selectedCustomer!.rateGroup}-${isCowMilk?'c':'b'}'] ;


    double rate;
    if(currentRate == null)
      {
        print('${selectedCustomer!.rateGroup}-${isCowMilk?'c':'b'}');
        showToast("No rate chart available for current customer");
        rateController.clear();
        amountController.clear();
        return;
      }
    print('selected customer rate group is ${selectedCustomer!.rateGroup} and rategropu of current rate is ${currentRate.name} with milktype ${currentRate.milkType}');
    if(isCowMilk)
      {
      rate =  rateChartService.findRateForCow(currentRate,currentRate.excel ,fat, snf);
      }
    else{
      print('rat for buffalo called');
      rate =  rateChartService.findRateForBuffalo(currentRate,currentRate.excel ,fat, snf);
      }
    if(rate != 0) {
      rate +=  currentRate.increment;
    }
    double amount = rate * quantity;

    rateController.text = rate.toStringAsFixed(2);
   amountController.text = amount.toStringAsFixed(2);
  }

  @override
  void initState() {
    super.initState();
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

  Future<void> _saveData() async {
    isSaving = true;
    setState(() {});
    log("Saving data...");
    print('is editing is ${isEditing}');
    if (isEditing) {
      print('deleting entry');
      await _deleteMilkCollection(editingMilkCollectionModel!);
    }
    try {
      MilkCollectionModel milkCollectionModel = MilkCollectionModel(
        customerId: selectedCustomer!.code,
        adminId: adminId,
        fat: double.parse(fatController.text),
        snf: double.parse(snfController.text),
        milkType:
            (selectedCustomer!.milkType == "mixed")
                ? isCowMilk
                    ? 0
                    : 1
                : (selectedCustomer!.milkType != "buffalo")
                ? 0
                : 1,
        time: (DateTime.now().hour < 14) ? 0 : 1,
        date: DateTime.now(),
        rate: double.parse(rateController.text),
        amount: double.parse(amountController.text),
        quantity: double.parse(quantityController.text),
      );
      print(
        'milkcollecti milktype is ${milkCollectionModel.milkType} and is cowmilk is $isCowMilk',
      );
      int? id = await milkCollectionService.addCollection(milkCollectionModel);

      if (id == null) {
        log("duplicate entry exist");
        showToast(
          "duplicate entry",
          backgroundColor: Colors.redAccent,
          position: ToastPosition.top,
          textStyle: const TextStyle(fontSize: 16, color: Colors.white),
          duration: const Duration(seconds: 2),
        );
        return;
      }
      milkCollectionList.add(milkCollectionModel);
      await MilkCollectionApi().saveMilkCollection(milkCollectionModel);
      if (isCowMilk) {
        cowCollectionData!.totalAmount += milkCollectionModel.amount;
        cowCollectionData!.quantity += milkCollectionModel.quantity;
        cowCollectionData!.avgFat =
            ((cowCollectionData!.avgFat * cowCollectionData!.customerCount) +
                milkCollectionModel.fat) /
            (cowCollectionData!.customerCount + 1);
        cowCollectionData!.avgSnf =
            ((cowCollectionData!.avgSnf * cowCollectionData!.customerCount) +
                milkCollectionModel.snf) /
            (cowCollectionData!.customerCount + 1);
        cowCollectionData!.customerCount += 1;
        dailyCollectionService.updateCollection(cowCollectionData!);
      } else {
        buffaloCollectionData!.totalAmount += milkCollectionModel.amount;
        buffaloCollectionData!.quantity += milkCollectionModel.quantity;
        buffaloCollectionData!.avgFat =
            ((buffaloCollectionData!.avgFat *
                    buffaloCollectionData!.customerCount) +
                milkCollectionModel.fat) /
            (buffaloCollectionData!.customerCount + 1);
        buffaloCollectionData!.avgSnf =
            ((buffaloCollectionData!.avgSnf *
                    buffaloCollectionData!.customerCount) +
                milkCollectionModel.snf) /
            (buffaloCollectionData!.customerCount + 1);
        buffaloCollectionData!.customerCount += 1;
        dailyCollectionService.updateCollection(buffaloCollectionData!);
      }
      _clearFields();
      milkCollectionList = await milkCollectionService.getCollectionsByDate(
        DateTime.now(),
      );
      setState(() {});

    } catch (e) {
      log("exception in save data : $e");
    } finally {
      isSaving = false;
      setState(() {});
    }
  }

  Future<void> _loadData() async {
    try {
      customerService = ref.read(
        customerServiceProvider,
      ); // Use ref.read instead of ref.watch
      final customers = await customerService.fetchAllCustomers(adminId);
      milkCollectionService = ref.read(milkCollectionProvider);
      milkCollectionList = await milkCollectionService.getCollectionsByDateAndByAdminId(
        DateTime.now(),adminId
      );
      Set<String> set = {};
      for(MilkCollectionModel m in milkCollectionList)
        {
            set.add('${m.adminId}-${m.customerId}');
        }
      print('set is ${set}');
      rateService = ref.read(rateMasterProvider);
      rateModelList = await rateService.getLatestRate(selectedDate);
      rateChartService = ref.read(cowRateChartProvider);
      print('rate chart service is initialized');
      for (var rate in rateModelList) {rateMap['${rate.name}-${rate.milkType==0?'c':'b'}'] = rate;}
      if (mounted) {
        setState(() {
          customerModelList = customers ;
        });
      }

      print('Customer model list length: ${customerModelList.length}');

      dailyCollectionService = ref.read(dataCollectionServiceProvider);
      cowCollectionData = await dailyCollectionService.fetchCollectionsByDate(
        DateTime.now(),
        0,
      );
      buffaloCollectionData = await dailyCollectionService
          .fetchCollectionsByDate(DateTime.now(), 1);
      print('Buffalo collection data: ${buffaloCollectionData.toString()}');
      print('Cow collection data: ${cowCollectionData.toString()}');
      cowCollectionData ??= DailyCollectionData(
        DateTime.now(),
        0,
        adminId,
        0,
        0,
        0,
        0,
        0,
        0,
      );
      buffaloCollectionData ??= DailyCollectionData(
        DateTime.now(),
        0,
        adminId,
        1,
        0,
        0,
        0,
        0,
        0,
      );
      setState(() {});
    } catch (e) {
      print('Error loading data: $e');
      if (mounted) {
        setState(() {
          customerModelList = [];
          codeController.text = '1';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // Compact Header
              Container(
                height: 60,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.local_drink, color: Colors.white, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'दुध संकलन व्यवस्थापन',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: _dateChange,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          'दिनांक: ${_currentDate()}',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 8),

              // Main Content
              if (isLoading)
                Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                )
              else
                Expanded(
                  child: Row(
                    children: [
                      // Left Panel - Input Form (Compact)
                      Container(
                        width: 550,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              // Customer Info Section
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFEBF4FF),
                                      Color(0xFFDBEAFE),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xFF93C5FD),
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: Color(0xFF2563EB),
                                          size: 20, // Increased from 16
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          'सदस्य माहिती',
                                          style: TextStyle(
                                            fontSize: 18, // Increased from 14
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF1E3A8A),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    _buildCompactAutocompleteField(
                                      mainContext: context,
                                      label: 'उत्पादक',
                                      icon: Icons.person,
                                      codeController: codeController,
                                      nameController: customerNameController,
                                      options: customerModelList,
                                      onSelected: (CustomerMaster c) async {
                                        selectedCustomer = c;
                                        final hasDuplicate = await _checkDuplicate();

                                        if (hasDuplicate) {
                                          // stop execution completely
                                          print(
                                            'found duplicate for ${c.code}',
                                          );
                                          return;
                                        }
                                        print(
                                          'no duplicate found for ${c.code}',
                                        );
                                        isEditing = false;
                                        _clearNumericFields();
                                        editingMilkCollectionModel = null;
                                        customerFocus.unfocus();

                                        FocusScope.of(
                                          context,
                                        ).requestFocus(quantityFocus);
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 12),

                              // Milk Details Section
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFF0F9FF),
                                      Color(0xFFE0F2FE),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xFF7DD3FC),
                                    width: 1,
                                  ),
                                ),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.analytics,
                                            color: Color(0xFF0284C7),
                                            size: 20, // Increased from 16
                                          ),
                                          SizedBox(width: 6),
                                          Text(
                                            'दूध मापन',
                                            style: TextStyle(
                                              fontSize: 18, // Increased from 14
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF0C4A6E),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),

                                      // Milk Type Switch
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          border: Border.all(
                                            color: Color(0xFFD1D5DB),
                                          ),
                                        ),
                                        child: (selectedCustomer == null ||
                                            selectedCustomer!.milkType == 'mixed')
                                            ? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'गाय',
                                              style: TextStyle(
                                                fontSize: 16, // Added font size
                                                color: isCowMilk
                                                    ? Color(0xFF2563EB)
                                                    : Color(0xFF6B7280),
                                                fontWeight: isCowMilk
                                                    ? FontWeight.w600
                                                    : FontWeight.normal,
                                              ),
                                            ),
                                            Switch(
                                              value: !isCowMilk,
                                              onChanged: (value) async {
                                                setState(() {
                                                  isCowMilk = !value;
                                                });
                                                await _checkDuplicate();
                                                isEditing = false;
                                              },
                                              inactiveTrackColor: Colors.blue[100],
                                              inactiveThumbColor: Colors.blue,
                                              activeColor: Color(0xFF8B5CF6),
                                            ),
                                            Text(
                                              'म्हैस',
                                              style: TextStyle(
                                                fontSize: 16, // Added font size
                                                color: !isCowMilk
                                                    ? Color(0xFF8B5CF6)
                                                    : Color(0xFF6B7280),
                                                fontWeight: !isCowMilk
                                                    ? FontWeight.w600
                                                    : FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        )
                                            : Text(
                                          selectedCustomer!.milkType == "cow" ? 'गाय' : 'म्हैस',
                                          style: TextStyle(
                                            fontSize: 16, // Added font size
                                            color: isCowMilk
                                                ? Color(0xFF2563EB)
                                                : Color(0xFF6B7280),
                                            fontWeight: isCowMilk
                                                ? FontWeight.w600
                                                : FontWeight.normal,
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: 8),

                                      // Input Fields Row 1
                                      Row(
                                        children: [
                                          Expanded(
                                            child: _buildCompactInputField(
                                              context: context,
                                              'प्रमाण (L)',
                                              quantityController,
                                              Icons.local_drink,
                                              currentFocus: quantityFocus,
                                              nextFocus: fatFocus,
                                              onChanged: findRate,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: _buildCompactInputField(
                                              context: context,
                                              'फॅट (%)',
                                              fatController,
                                              Icons.opacity,
                                              currentFocus: fatFocus,
                                              nextFocus: snfFocus,
                                              onChanged: findRate,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: _buildCompactInputField(
                                              context: context,
                                              'SNF (%)',
                                              snfController,
                                              Icons.grain,
                                              currentFocus: snfFocus,
                                              nextFocus: saveFocus,
                                              onChanged: findRate,
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 8),

                                      // Input Fields Row 2
                                      Row(
                                        children: [
                                          Expanded(
                                            child: _buildCompactInputField(
                                              'दर (₹)',
                                              rateController,
                                              Icons.currency_rupee,
                                              readOnly: true,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: _buildCompactInputField(
                                              'रकम (₹)',
                                              amountController,
                                              Icons.account_balance_wallet,
                                              readOnly: true,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: 12),

                              // Action Buttons (Compact)
                              _buildActionButtons(),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8),

                      // Center Panel - Data Table
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFFE5E7EB)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
// Table Content
                            Expanded(
                              child: SingleChildScrollView(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF1E3A8A),
                                        Color(0xFF2563EB),
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                  ),
                                  child: _buildTable(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                      SizedBox(width: 8),

                      // Right Panel - Summary (Compact)
                      Container(
                        width: 250, // Increased from 200
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFF1E3A8A), Color(0xFF1E40AF)],
                          ),
                          borderRadius: BorderRadius.circular(14), // Increased from 12
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8, // Increased from 6
                              offset: Offset(0, 3), // Increased from 2
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(14), // Increased from 12
                          child: Column(
                            children: [
                              // Summary Header
                              Container(
                                padding: EdgeInsets.all(10), // Increased from 8
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8), // Increased from 6
                                  border: Border.all(
                                    color: Colors.redAccent.withOpacity(0.3),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(5), // Increased from 4
                                          decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius: BorderRadius.circular(5), // Increased from 4
                                          ),
                                          child: Icon(
                                            Icons.calendar_month,
                                            color: Colors.white,
                                            size: 20, // Increased from 12
                                          ),
                                        ),
                                        SizedBox(width: 8), // Increased from 6
                                        Expanded(
                                          child: Text(
                                            "तपशील",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20, // Increased from 13
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12), // Increased from 10
                                    Text(
                                      "विभाग : मुख्यसंस्था",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18, // Increased from 12
                                      ),
                                    ),
                                    Text(
                                      "वेळ : ${DateTime.now().hour > 14 ? "संध्याकाळ" : "सकाळ"}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18, // Increased from 12
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5), // Increased from 8

                              // गाय Summary
                              _buildCompactSummaryCard(
                                'गाय दूध',
                                Icons.pets,
                                Color(0xFF10B981),
                                '${cowCollectionData?.customerCount ?? 0} सदस्य',
                                '${cowCollectionData?.quantity ?? 0} लिटर',
                                '${cowCollectionData?.avgFat ?? 0} फॅट',
                                '${cowCollectionData?.totalAmount ?? 0}',
                                cowCollectionData!.totalCan,
                              ),

                              SizedBox(height: 10), // Increased from 8

                              // म्हैस Summary
                              _buildCompactSummaryCard(
                                'म्हैस दूध',
                                Icons.agriculture,
                                Color(0xFFF59E0B),
                                '${buffaloCollectionData?.customerCount ?? 0} सदस्य',
                                '${buffaloCollectionData?.quantity ?? 0} लिटर',
                                '${buffaloCollectionData?.avgFat ?? 0} फॅट',
                                '${buffaloCollectionData?.totalAmount ?? 0}',
                                buffaloCollectionData!.totalCan,
                              ),

                              SizedBox(height: 10), // Increased from 8

                              // एकूण Summary
                              Container(
                                padding: EdgeInsets.all(12), // Increased from 10
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF8B5CF6),
                                      Color(0xFF7C3AED),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10), // Increased from 8
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.analytics,
                                          color: Colors.white,
                                          size: 16, // Increased from 14
                                        ),
                                        SizedBox(width: 6), // Increased from 4
                                        Text(
                                          'एकूण',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16, // Increased from 12
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8), // Increased from 6
                                    Text(
                                      'सदस्य: ${milkCollectionList.length}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16, // Increased from 12
                                      ),
                                    ),
                                    Text(
                                      'लिटर: ${(buffaloCollectionData?.quantity ?? 0) + (cowCollectionData?.quantity ?? 0)}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16, // Increased from 12
                                      ),
                                    ),
                                    Text(
                                      'सरासरी फॅट: ${((buffaloCollectionData?.avgFat ?? 0) + (cowCollectionData?.avgFat ?? 0)) / 2}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16, // Increased from 12
                                      ),
                                    ),
                                    Text(
                                      'रकम: ₹ ${(buffaloCollectionData?.totalAmount ?? 0) + (cowCollectionData!.totalAmount)}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16, // Increased from 12
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),                    ],
                  ),
                ),
            ],
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
    return isSaving
        ? CircularProgressIndicator()
        : AnimatedSaveButton(
          focusNode: saveFocus,
          onPressed: () {
            if (selectedCustomer == null) {
              showToast(
                "कृपया उत्पादक निवडा",
                backgroundColor: Colors.redAccent,
                position: ToastPosition.top,
                textStyle: const TextStyle(fontSize: 16, color: Colors.white),
                duration: const Duration(seconds: 2),
              );

              return;
            }
            if (_formKey.currentState!.validate()) {
              // ✅ All required fields filled
              _saveData();
            } else {
              // ❌ Show error messages automatically
              showToast(
                "कृपया सर्व आवश्यक फील्ड भरा",
                backgroundColor: Colors.redAccent,
                position: ToastPosition.top,
                textStyle: const TextStyle(fontSize: 16, color: Colors.white),
                duration: const Duration(seconds: 2),
              );
            }
          },
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
            fontSize: 15,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
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


  Widget _buildCompactAutocompleteField({
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

  Widget _buildTable() {
    return DataTable(
      headingRowHeight: 40,
      dataRowHeight: 36,
      columnSpacing: 12, // Reduced spacing between columns
      horizontalMargin: 12,
      headingTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
      dataTextStyle: const TextStyle(fontSize: 13, color: Colors.black87),
      headingRowColor: MaterialStateProperty.all(Colors.transparent),
      columns: const [
        DataColumn(
          label: Expanded(
            child: Text("कोड", textAlign: TextAlign.center),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text("नाव", textAlign: TextAlign.left),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text("प्रकार", textAlign: TextAlign.center),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text("Qty", textAlign: TextAlign.center),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text("Fat", textAlign: TextAlign.center),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text("SNF", textAlign: TextAlign.center),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text("दर", textAlign: TextAlign.center),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text("किंमत", textAlign: TextAlign.center),
          ),
        ),
      ],
      rows: List.generate(milkCollectionList.length, (index) {
        final data = milkCollectionList.reversed.toList()[index];

        return DataRow(
          color: MaterialStateProperty.resolveWith((Set states) {
            return index % 2 == 0 ? Colors.white : Colors.blue[50];
          }),
          cells: [
            DataCell(
              GestureDetector(
                onTapDown: (details) {
                  _showContextMenu(context, details.globalPosition, data);
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    data.customerId.toString(),
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
            DataCell(
              GestureDetector(
                onTapDown: (details) {
                  _showContextMenu(context, details.globalPosition, data);
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    findCustomerName(data.customerId),
                    style: TextStyle(fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
            ),
            DataCell(
              GestureDetector(
                onTapDown: (details) {
                  _showContextMenu(context, details.globalPosition, data);
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    data.milkType == 0 ? "गाय" : "म्हैस",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
            DataCell(
              GestureDetector(
                onTapDown: (details) {
                  _showContextMenu(context, details.globalPosition, data);
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    data.quantity.toStringAsFixed(1),
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
            DataCell(
              GestureDetector(
                onTapDown: (details) {
                  _showContextMenu(context, details.globalPosition, data);
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    data.fat.toStringAsFixed(1),
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
            DataCell(
              GestureDetector(
                onTapDown: (details) {
                  _showContextMenu(context, details.globalPosition, data);
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    data.snf.toStringAsFixed(1),
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
            DataCell(
              GestureDetector(
                onTapDown: (details) {
                  _showContextMenu(context, details.globalPosition, data);
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    data.rate.toStringAsFixed(1),
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
            DataCell(
              GestureDetector(
                onTapDown: (details) {
                  _showContextMenu(context, details.globalPosition, data);
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    data.amount.toStringAsFixed(0),
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
  void _showContextMenu(
    BuildContext context,
    Offset position,
    MilkCollectionModel data,
  )
  async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final result = await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromLTWH(position.dx, position.dy, 0, 0),
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem(
          enabled: false,
          padding: EdgeInsets.zero,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF6A5ACD),
                  Color(0xFF8A2BE2),
                ], // blue-violet gradient
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "उत्पादक: ${findCustomerName(data.customerId)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "दुध : ${data.milkType == 0 ? "गाय" : "म्हैस"}",
                  style: const TextStyle(color: Colors.white70),
                ),
                const Divider(color: Colors.white54),
              ],
            ),
          ),
        ),
        const PopupMenuItem(value: "edit", child: Text("✏️ Edit")),
        const PopupMenuItem(value: "delete", child: Text("🗑️ Delete")),
        const PopupMenuItem(value: "cancel", child: Text("❌ Cancel")),
      ],
    );

    if (result == "edit") {
      _editMilkCollection(data);
    } else if (result == "delete") {
      _deleteMilkCollection(data);
    }
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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

  Widget _buildCompactSummaryCard(
      String title,
      IconData icon,
      Color color,
      String members,
      String liters,
      String fat,
      String amount,
      int canCount,
      ) {
    // Extract liters value from the string (assuming format like "10 लिटर")
    double litersValue = double.tryParse(liters.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(icon, color: Colors.white, size: 14),
              ),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),

          // Row with can visualization and text details
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Can visualization
              _buildCanWithLiquid(litersValue),

              SizedBox(width: 12),

              // Text details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(members, style: TextStyle(color: Colors.white, fontSize: 14)),
                    SizedBox(height: 4),
                    Text(liters, style: TextStyle(color: Colors.white, fontSize: 14)),
                    SizedBox(height: 4),
                    Text(fat, style: TextStyle(color: Colors.white, fontSize: 14)),
                    SizedBox(height: 4),
                    Text(
                      'कॅन: $canCount',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    SizedBox(height: 4),
                    Text(
                      amount,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCanWithLiquid(double liters, {double canCapacity = 30.0}) {
    double remainingLiters = liters % canCapacity;

    double fillPercentage = (remainingLiters / canCapacity).clamp(0.0, 1.0);

    return Container(
      width: 70,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Main can body
          Positioned(
            bottom: 0,
            child: Container(
              width: 50,
              height: 110,
              decoration: BoxDecoration(
                color: Color(0xFFD4C84A), // Yellowish can color
                border: Border(
                  left: BorderSide(color: Color(0xFF8B7E3A), width: 2),
                  right: BorderSide(color: Color(0xFF8B7E3A), width: 2),
                  bottom: BorderSide(color: Color(0xFF8B7E3A), width: 2),
                  // top: BorderSide.none  // optional, not needed by default
                ),                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),

          // Liquid fill inside can
          Positioned(
            bottom: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                width: 46,
                height: 106 * fillPercentage,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue[300]!,
                      Colors.blue[600]!,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: 30,
              height: 8,
              decoration: BoxDecoration(
                color: Color(0xFFE5D96B),
                border: Border(
                  left: BorderSide(color: Color(0xFF8B7E3A), width: 2),
                  right: BorderSide(color: Color(0xFF8B7E3A), width: 2),
                  top: BorderSide(color: Color(0xFF8B7E3A), width: 2),
                )
              ),
            ),
          ),
          // // Can neck/top
          Positioned(
            top: 7,
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Color(0xFFD4C84A),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3),
                  topRight: Radius.circular(3),
                ),
              ),
            ),
          ),

          // Top rim/cap



          // Current liters text overlay
          Positioned(
            top: 60,
            child: Text(
              '${liters.toStringAsFixed(1)}L',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 2,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildCapacityMarker(String text, double position) {
    return Container(
      height: 1,
      width: 8,
      color: Colors.grey[600],
      child: Align(
        alignment: Alignment.centerLeft,
        child: Transform.translate(
          offset: Offset(-12, 0),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 8,
            ),
          ),
        ),
      ),
    );
  }

  String findCustomerName(String customerId) {
    for (var customer in customerModelList) {
      if (customer.code == customerId) {
        return customer.name;
      }
    }
    return '';
  }

  Future<bool> _checkDuplicate() async {
    if (selectedCustomer == null) {
      return false;
    }
    print('checking duplicate for ${selectedCustomer!.code}');
    int milkType =
        (selectedCustomer!.milkType == "mixed")
            ? isCowMilk
                ? 0
                : 1
            : (selectedCustomer!.milkType != "buffalo")
            ? 0
            : 1;

    MilkCollectionModel? milkCollectionModel =
        milkCollectionList
            .where(
              (element) =>
                  generateUniqueKey(
                    element.customerId,
                    element.adminId,
                    element.milkType,
                    element.time,
                  ) ==
                  generateUniqueKey(
                    selectedCustomer!.code,
                    adminId,
                    milkType,
                    DateTime.now().hour > 14 ? 1 : 0,
                  ),
            )
            .firstOrNull;
    if (milkCollectionModel == null) {
      fatController.clear();
      snfController.clear();
      rateController.clear();
      amountController.clear();
      quantityController.clear();
      editingMilkCollectionModel = null;
      isEditing = false;
      return false;
    }
    showToast("entry exist");
      _editMilkCollection(milkCollectionModel);
    return true;
  }

  String generateUniqueKey(
    String customerId,
    String adminId,
    int milkType,
    int time,
  )
  {
    DateTime date = DateTime.now();

    // Ensure DateTime is normalized (only date part if needed)
    final dateStr = "${date.year}-${date.month}-${date.day}";
    return "$customerId|$adminId|$milkType|$time|$dateStr";
  }

  void _showScaffoldMessage(MilkCollectionModel existing) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(
            "Duplicate Entry",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            "An entry for ${selectedCustomer!.code} already exists.\n"
            "Would you like to edit it instead?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false); // user chose No
                showToast(
                  "Keeping existing entry.",
                  backgroundColor: Colors.redAccent,
                  position: ToastPosition.top,
                  textStyle: const TextStyle(fontSize: 16, color: Colors.white),
                  duration: const Duration(seconds: 2),
                );
                if (selectedCustomer!.milkType == "mixed") {
                  isCowMilk = existing.milkType == 0 ? false : true;
                  setState(() {});
                  return;
                }
                _clearFields();
              },
              child: const Text("No"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(true); // user chose Yes
                // 🔹 Navigate to edit screen or trigger edit flow
                _editMilkCollection(existing);
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}
