import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oktoast/oktoast.dart';
import 'package:windows_sample/model/deduction.dart';
import 'package:windows_sample/model/deduction_entry_model.dart';
import 'package:windows_sample/model/milk_collection_model.dart';
import 'package:windows_sample/model/opening_balance_model.dart';
import 'package:windows_sample/service/deduction_entry_service.dart';
import 'package:windows_sample/service/deduction_service.dart';
import 'package:windows_sample/service/milk_collection_service.dart';
import 'package:windows_sample/service/opening_balance_service.dart';
import '../model/customer_model.dart';
import '../riverpod/providers.dart';
import '../service/customer_service.dart';
import 'dart:developer' as developer;
import 'package:flutter/services.dart';
import '../widget/animated_button_widget.dart';

class DeductionWindow extends ConsumerStatefulWidget {
  const DeductionWindow({Key? key}) : super(key: key);

  @override
  ConsumerState<DeductionWindow> createState() => _DeductionWindowState();
}

class _DeductionWindowState extends ConsumerState<DeductionWindow> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  TextEditingController codeController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  final TextEditingController ekkunLiterController = TextEditingController();
  final TextEditingController ekkunBilController = TextEditingController();
  final TextEditingController totalField1Controller = TextEditingController();
  final TextEditingController totalField2Controller = TextEditingController();
  final TextEditingController totalField3Controller = TextEditingController();
  final TextEditingController totalField4Controller = TextEditingController();
  final TextEditingController billController = TextEditingController();
  final List<FocusNode> cellFocusNode = [];
  late DeductionEntryService deductionEntryService;
  final firstDayFocus = FocusNode();
  final firstMonthFocus = FocusNode();
  final firstYearFocus = FocusNode();
  final secondDayFocus = FocusNode();
  final secondMonthFocus = FocusNode();
  final secondYearFocus = FocusNode();

  CustomerMaster? selectedCustomer;
  FocusNode saveFocus = FocusNode();
  late List<OpeningBalance> currentOpeningBalance;
  late DeductionServiceImpl deductionService;
  late List<CustomerMaster> customerModelList;
  late OpeningBalanceService openingBalanceService;
  late CustomerService customerService;
  String adminId = "1";
  DateTime? selectedPasunDate;
  DateTime? selectedParyantDate ;
  bool isLoading = true;
  String selectedBillType = 'दुध बिल';
  int selectedMilk = 0;
  late List<Deduction> deductionList;
  late MilkCollectionService milkCollectionService;
  late List<MilkCollectionModel> milkCollectionList;

  @override
  void dispose() {
    codeController.dispose();
    customerNameController.dispose();
    ekkunLiterController.dispose();
    ekkunBilController.dispose();
    totalField1Controller.dispose();
    totalField2Controller.dispose();
    totalField3Controller.dispose();
    cellControllers.forEach((key, controllers) {
      controllers.forEach((_, controller) => controller.dispose());
    });
    super.dispose();
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
  void calculateEkunRakkam(bool isKapat) {
    double ekunAarambhiBaki = 0;
    double ekunKapatRakkam = 0;
    double jmaYeneBaki = 0;

    if(isKapat) {
      for (var i = 0; i < deductionList.length; i++) {
     double kapatRakkam =   double.tryParse(cellControllers[i.toString()]!['kapatRakkam']!.text) ?? 0;
     if(kapatRakkam == 0) {
       cellControllers[i.toString()]!['jamaYene']!.clear();

       continue;
     }
     final rawText = cellControllers[i.toString()]!['arambhiBaki']!.text.trim();
     final bool isJama = RegExp(r'जमा$', caseSensitive: false).hasMatch(rawText);
     final cleanedText = rawText
         .replaceAll(RegExp(r'(नावे|जमा)$', caseSensitive: false), '')
         .trim();

     // Parse safely to double
        final arambhiBaki = double.tryParse(cleanedText) ?? 0.0;
     double jmaYene;
     String jmaYeneString;

     if(isJama)
          {
          jmaYene =   arambhiBaki - kapatRakkam;
          jmaYeneString ='${(jmaYene).toStringAsFixed(2)} जमा';

          }
     else{
       jmaYene =  arambhiBaki + kapatRakkam;
       jmaYeneString ='${(jmaYene).toStringAsFixed(2)} नावे';
     }

     print('arambhi baki  from controller is ${cellControllers[i.toString()]!['arambhiBaki']!.text }');

     print('jmayene is ${jmaYene} and kapatrakkma is ${kapatRakkam}');
    cellControllers[i.toString()]!['jamaYene']!.text  = jmaYeneString;
     print('jma yene from controller is ${cellControllers[i.toString()]!['jamaYene']!.text }');
     print('kapat rakkam  from controller is ${cellControllers[i.toString()]!['kapatRakkam']!.text }');
      }
    }
    for (var i = 0; i < deductionList.length; i++) {
      final rawText1 = cellControllers[i.toString()]!['arambhiBaki']!.text.trim();
      final cleanedText = rawText1
          .replaceAll(RegExp(r'(नावे|जमा)$', caseSensitive: false), '')
          .trim();

// Parse safely to double
      final arambhiBaki = double.tryParse(cleanedText) ?? 0.0;
      ekunAarambhiBaki += arambhiBaki;
      ekunKapatRakkam += double.tryParse(cellControllers[i.toString()]!['kapatRakkam']!.text) ?? 0;
      String rawText = cellControllers[i.toString()]!['jamaYene']!.text.trim();
      final bool isJama = RegExp(r'जमा$', caseSensitive: false).hasMatch(rawText);

// Take only the part before the first space
      String numericPart = rawText.split(' ').first;


// Try to parse that substring
      double jamaYene = double.tryParse(numericPart) ?? 0;
      if(isJama)
      {
        print('its jmayene');
        jamaYene = jamaYene * -1;
      }
      print('Parsed jamaYene = $jamaYene from text "$rawText"');
      jmaYeneBaki +=jamaYene;
    }
    String jmaYeneBakiString = '${ (jmaYeneBaki < 0 ? jmaYeneBaki * -1 : jmaYeneBaki).toStringAsFixed(2)} ${(jmaYeneBaki < 0)? 'जमा':'नावे'}';

    totalField1Controller.text = '${ekunAarambhiBaki.toStringAsFixed(2)} ${(ekunAarambhiBaki < 0)? 'जमा':'नावे'}';
    totalField2Controller.text = ekunKapatRakkam.toStringAsFixed(2);
    totalField3Controller.text = jmaYeneBakiString;
    totalField4Controller.text = (ekunAarambhiBaki - ekunKapatRakkam).toStringAsFixed(2);
  }
  void findCustomer(bool isNext) {
    if (selectedCustomer == null) return;

    int index = customerModelList.indexOf(selectedCustomer!);
    if (isNext) {
      if (index < customerModelList.length - 1) {
        selectedCustomer = customerModelList[index + 1];
      }
    } else {
      if (index > 0) {
        selectedCustomer = customerModelList[index - 1];
      }
    }



    // 🔹 Update autocomplete text field directly
    autoCompleteTextController?.text =
    "${selectedCustomer!.code}-${selectedCustomer!.name}";
    codeController.text = selectedCustomer!.code;
    customerNameController.text = selectedCustomer!.name;
    print('autocmplete widget text is ${autoCompleteTextController?.text}');
    findOpeningBalance();
    findCurrentData();
    setState(() {});
  }
  Future<void> _loadData() async {
    try {
      customerService = ref.read(
        customerServiceProvider,
      ); // Use ref.read instead of ref.watch
      List<CustomerMaster> customers = await customerService.fetchAllCustomers(adminId);
      customers.sort((a,b)=> int.parse(a.code).compareTo(int.parse(b.code)));
      openingBalanceService = ref.watch(openingBalanceProvider);

      milkCollectionService = ref.read(milkCollectionProvider);
      deductionService = ref.read(deductionProvider);
      deductionList =  await deductionService.fetchAllDeductions();
      for (var i = 0; i < deductionList.length; i++) {
        cellControllers[i.toString()] = {
          'arambhiBaki': TextEditingController(),
          'kapatRakkam': TextEditingController(),
          'jamaYene': TextEditingController(),
        };
        cellControllers[i.toString()]!['arambhiBaki']!.addListener((){calculateEkunRakkam(false);});
        cellControllers[i.toString()]!['kapatRakkam']!.addListener((){calculateEkunRakkam(true);});
        cellControllers[i.toString()]!['jamaYene']!.addListener((){calculateEkunRakkam(false);});
        cellFocusNode.add(FocusNode());
      }
      deductionEntryService = ref.watch(deductionEntryProvider);

      if (mounted) {
        setState(() {
          customerModelList = customers ;
        });
      }

      print('Customer model list length: ${customerModelList.length}');

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
  void findOpeningBalance()async{
    if (selectedCustomer == null) return;
    List<OpeningBalance>? balance = await openingBalanceService.findBalance(selectedCustomer!.code);
    if(balance == null || balance.isEmpty) {
      showToast("Opening balance not available for ${selectedCustomer!.name}");
      for (var i = 0; i < deductionList.length; i++) {
        cellControllers[i.toString()]!['arambhiBaki']!.text = 0.toString();
      }
      return;
    }
    else {
      currentOpeningBalance = balance;
    }
    for (var i = 0; i < deductionList.length; i++) {
      OpeningBalance temp = currentOpeningBalance.firstWhere((e)=> e.deductionCode == deductionList[i].code);
      double aarambhiBaki = temp.openingBalance;
      String aarambhiBakiStringg;
      if(aarambhiBaki < 0) {
       aarambhiBakiStringg =   '${(aarambhiBaki * -1).toStringAsFixed(2)} जमा';
      } else {
        aarambhiBakiStringg= '${(aarambhiBaki).toStringAsFixed(2)} नावे';
      }

      cellControllers[i.toString()]!['arambhiBaki']!.text =  aarambhiBakiStringg;
      cellControllers[i.toString()]!['jamaYene']!.clear();
      cellControllers[i.toString()]!['kapatRakkam']!.clear();
    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:isLoading
          ? CircularProgressIndicator(): Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF1E3A8A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1E40AF), Color(0xFF3B82F6)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 20,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                          Icons.receipt_long, color: Colors.white, size: 28),
                    ),
                    SizedBox(width: 16),
                    Text(
                      'कपात भरणे',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),

              // Main Content
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    color: Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        // Top Section - Bill Type and Filters
                        _buildTopSection(),

                        SizedBox(height: 24),

                        // Main Content Area
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // Right Side - Summary and Actions
                              Container(
                                width: 500,
                                child: _buildRightPanel(),
                              ),
                              SizedBox(width: 24),
                              // Left Side - Table
                              Expanded(
                                flex: 3,
                                child: _buildKryatTable(),
                              ),


                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFE2E8F0), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Bill Type Switch
              _buildBillTypeSwitch(),

              SizedBox(width: 20),

              // Date Selection or Bill View
              Expanded(
                child: selectedBillType == 'दुध बिल'
                    ? _buildDateAndViewRow()
                    : _buildBillView(),
              ),
            ],
          ),

          // Producer Search
          _buildProducerSearch(),

        ],
      ),
    );
  }

  Widget _buildBillTypeSwitch() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFE2E8F0), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSwitchTab('दुध बिल', selectedBillType == 'दुध बिल'),
          _buildSwitchTab('फरक बिल', selectedBillType == 'फरक बिल'),
        ],
      ),
    );
  }

  Widget _buildSwitchTab(String label, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => selectedBillType = label),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(colors: [Color(0xFF3B82F6), Color(0xFF2563EB)])
              : null,
          color: isSelected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected ? [
            BoxShadow(
              color: Color(0xFF3B82F6).withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ] : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Color(0xFF64748B),
          ),
        ),
      ),
    );
  }

  Widget _buildDateAndViewRow() {
    return Row(
      children: [
        _buildDatePicker('पासून', selectedPasunDate, true,  (newDate) {              // 👈 this is the onDateChanged function
          setState(() {
            selectedPasunDate = newDate;
          });
        },
          firstDayFocus,firstMonthFocus,firstYearFocus,secondDayFocus
        ),
        SizedBox(width: 50,),
        _buildDatePicker('पर्यंत', selectedParyantDate, false,  (newDate) {              // 👈 this is the onDateChanged function
          setState(() {
            selectedParyantDate = newDate;
          });
        },
            secondDayFocus,secondMonthFocus,secondYearFocus, saveFocus,

        ),
        SizedBox(width: 50,),
        _buildViewSelector(),
      ],
    );
  }

  void findCurrentData() async {
    developer.log('findCurrentData called', name: 'MilkCollection');

    try {
      developer.log('Checking selectedCustomer', name: 'MilkCollection');
      if (selectedCustomer == null) {
        developer.log('selectedCustomer is null - returning early', name: 'MilkCollection');
        return;
      }
      developer.log('selectedCustomer: ${selectedCustomer!.code}', name: 'MilkCollection');

      developer.log('Checking bill type and date conditions', name: 'MilkCollection');
      developer.log('selectedBillType: $selectedBillType', name: 'MilkCollection');
      developer.log('selectedPasunDate: $selectedPasunDate', name: 'MilkCollection');
      developer.log('selectedParyantDate: $selectedParyantDate', name: 'MilkCollection');

      if (selectedBillType == 'दुध बिल' && (selectedPasunDate == null || selectedParyantDate == null)) {
        developer.log('Milk bill with valid dates - returning early', name: 'MilkCollection');
        return;
      }

      developer.log('Fetching milk collections from service', name: 'MilkCollection');
      developer.log('Parameters - customerCode: ${selectedCustomer!.code}, milkType: $selectedMilk, fromDate: $selectedPasunDate, toDate: $selectedParyantDate, adminId: $adminId', name: 'MilkCollection');

      milkCollectionList = await milkCollectionService.getCollectionsBetweenAndByAdminIdAndCustomerAndMilkType(
          selectedCustomer!.code,
          selectedMilk,
          selectedPasunDate!,
          selectedParyantDate!,
          adminId
      );

      developer.log('Milk collections fetched successfully', name: 'MilkCollection');
      developer.log('Number of records: ${milkCollectionList.length}', name: 'MilkCollection');

      double ekunLiter = 0, ekunBill = 0;
      developer.log('Calculating total liters and bill amount', name: 'MilkCollection');

      for (MilkCollectionModel m in milkCollectionList) {
        ekunLiter += m.quantity;
        ekunBill += m.amount;
        developer.log('Record - Customer ${selectedCustomer!.name}, Quantity: ${m.quantity}, Amount: ${m.amount}, Running Total - Liters: $ekunLiter, Bill: $ekunBill',
            name: 'MilkCollection');
      }

      developer.log('Final totals - Total Liters: $ekunLiter, Total Bill: $ekunBill', name: 'MilkCollection');

      ekkunLiterController.text = ekunLiter.toStringAsFixed(2);
      ekkunBilController.text = ekunBill.toStringAsFixed(2);

      developer.log('Controllers updated - ekkunLiterController: ${ekkunLiterController.text}, ekkunBilController: ${ekkunBilController.text}',
          name: 'MilkCollection');

      developer.log('Calling setState to update UI', name: 'MilkCollection');
      setState(() {});

      developer.log('findCurrentData completed successfully', name: 'MilkCollection');

    } catch (e, stackTrace) {
      developer.log('Error in findCurrentData: $e',
          name: 'MilkCollection',
          error: e,
          stackTrace: stackTrace);
      developer.log('Stack trace: $stackTrace', name: 'MilkCollection');
      rethrow;
    }
  }
  Widget _buildDatePicker(
      String label,
      DateTime? date,
      bool isPasun,
      void Function(DateTime newDate) onDateChanged,
      FocusNode dayFocus,
      FocusNode monthFocus,
      FocusNode yearFocus,
      FocusNode nextFocus,
      ) {
    // 🕓 Track last valid date
    DateTime previousDate = date ?? DateTime.now();

    final dayController = TextEditingController(text: date != null ? date.day.toString().padLeft(2, '0') : '');
    final monthController = TextEditingController(text: date != null ? date.month.toString().padLeft(2, '0') : '');
    final yearController = TextEditingController(text: date != null ? date.year.toString() : '');

    // 🧠 Auto-select logic with frame delay
    void setupAutoSelect(FocusNode node, TextEditingController controller) {
      bool isSelecting = false;
      node.addListener(() {
        if (node.hasFocus && !isSelecting) {
          isSelecting = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, () {
              if (node.hasFocus) {
                controller.selection = TextSelection(baseOffset: 0, extentOffset: controller.text.length);
              }
            });
            Future.delayed(const Duration(milliseconds: 50), () {
              if (node.hasFocus) {
                controller.selection = TextSelection(baseOffset: 0, extentOffset: controller.text.length);
                isSelecting = false;
              }
            });
          });
        } else if (!node.hasFocus) {
          isSelecting = false;
        }
      });
    }

    setupAutoSelect(dayFocus, dayController);
    setupAutoSelect(monthFocus, monthController);
    setupAutoSelect(yearFocus, yearController);

    // 🧩 Validation logic with smart year fix
    Future<void> validateAndUpdateDate(
        bool isDay,
        FocusNode nextFocusInDate,
        TextEditingController currentController,
        ) async {
      print("------------------------------------------------------------");
      print("[validateAndUpdateDate] START");
      print("Triggered by: ${isDay ? "Day field" : "Month/Year field"}");
      print("Current controller text: '${currentController.text}'");
      print("Initial values -> Day: '${dayController.text}', Month: '${monthController.text}', Year: '${yearController.text}'");
      print("Previous valid date: ${previousDate.toIso8601String()}");

      try {
        // --- Check for blank fields ---
        if (dayController.text.trim().isEmpty ||
            monthController.text.trim().isEmpty ||
            yearController.text.trim().isEmpty) {
          print("[validateAndUpdateDate] One or more date fields empty → Moving focus to $nextFocusInDate");
          FocusScope.of(context).requestFocus(nextFocusInDate);
          print("[validateAndUpdateDate] END (early exit due to empty fields)");
          print("------------------------------------------------------------");
          return;
        }

        // --- Extract numeric values ---
        int day = int.tryParse(dayController.text) ?? previousDate.day;
        int month = int.tryParse(monthController.text) ?? previousDate.month;
        int year = int.tryParse(yearController.text) ?? previousDate.year;
        print("Parsed values -> day: $day, month: $month, year: $year");

        // --- Expand short year (e.g., 25 → 2025) ---
        if (year < 100) {
          final oldYear = year;
          year += 2000;
          yearController.text = year.toString();
          print("Year auto-expanded: $oldYear → $year");
        }

        // --- Range checks ---
        if (month < 1 || month > 12) {
          print("Invalid month detected: $month");
          throw Exception("Invalid month");
        }
        if (day < 1 || day > 31) {
          print("Invalid day detected: $day");
          throw Exception("Invalid day");
        }

        // --- Attempt date creation ---
        DateTime? newDate;
        try {
          newDate = DateTime(year, month, day);
        } catch (err) {
          print("DateTime constructor failed: $err");
          newDate = null;
        }

        // --- Validate day/month combo (avoid auto-roll) ---
        final isValidCombo =
            newDate != null && newDate.month == month && newDate.day == day;
        print("Date validation result: ${isValidCombo ? "VALID" : "INVALID"} -> ${newDate?.toIso8601String() ?? "null"}");

        if (!isValidCombo) {
          throw Exception("Invalid date combination (auto-rolled by Dart DateTime)");
        }

        // --- Passed validation ---
        previousDate = newDate!;
        print("✅ Valid date accepted: ${newDate.toIso8601String()}");

        // --- Update controllers ---
        dayController.text = newDate.day.toString().padLeft(2, '0');
        monthController.text = newDate.month.toString().padLeft(2, '0');
        yearController.text = newDate.year.toString();

        // --- Update state ---
        if (isPasun) {
          setState(() => selectedPasunDate = newDate);

          print("Updated selectedPasunDate → ${selectedPasunDate?.toIso8601String()}");
        } else {
          setState(() => selectedParyantDate = newDate);
          print("Updated selectedParyantDate → ${selectedParyantDate?.toIso8601String()}");
        }
        if(selectedParyantDate != null && selectedPasunDate != null)
        {
          findCurrentData();
        }

        // --- Move focus ---
        FocusScope.of(context).requestFocus(nextFocusInDate);
        print("Focus moved to nextFocusInDate → $nextFocusInDate");

        print("[validateAndUpdateDate] END (success)");
      } catch (e, stack) {
        // --- Invalid date: revert to last valid date ---
        print("❌ Exception caught: $e");
        debugPrint("Stack trace:\n$stack");

        dayController.text = previousDate.day.toString().padLeft(2, '0');
        monthController.text = previousDate.month.toString().padLeft(2, '0');
        yearController.text = previousDate.year.toString();

        print("Reverted to previous valid date: ${previousDate.toIso8601String()}");
        print("[validateAndUpdateDate] END (reverted due to error)");
      }

      print("------------------------------------------------------------");
    }




    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF475569),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 200,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFCBD5E1), width: 1.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 🗓 Day field
              SizedBox(
                width: 30,
                child: TextField(
                  focusNode: dayFocus,
                  controller: dayController,
                  maxLength: 2,
                  decoration: const InputDecoration(
                    counterText: '',
                    hint: Text('DD'),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onSubmitted: (_) => validateAndUpdateDate(true,monthFocus, dayController),
                ),
              ),
              const Text("/"),

              // 🗓 Month field
              SizedBox(
                width: 30,
                child: TextField(
                  focusNode: monthFocus,
                  controller: monthController,
                  maxLength: 2,
                  decoration:  InputDecoration(
                    hint: Text('MM'),
                    counterText: '',
                    border: InputBorder.none,
                  ),
                 // keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onSubmitted: (_) => validateAndUpdateDate(false,yearFocus, monthController),
                ),
              ),
              const Text("/"),

              // 🗓 Year field
              SizedBox(
                width: 40,
                child: TextField(
                  focusNode: yearFocus,
                  controller: yearController,
                  maxLength: 4,
                  decoration: const InputDecoration(
                    counterText: '',
                    hintText: 'YYYY',
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onSubmitted: (_) => validateAndUpdateDate(false,nextFocus, yearController),
                ),
              ),

              // 📅 Calendar icon
              GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: previousDate,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    previousDate = picked;
                    dayController.text = picked.day.toString().padLeft(2, '0');
                    monthController.text = picked.month.toString().padLeft(2, '0');
                    yearController.text = picked.year.toString();
                    onDateChanged(picked);
                  }
                },
                child: const Icon(Icons.calendar_today, size: 16, color: Color(0xFF64748B)),
              ),
            ],
          ),
        ),
      ],
    );
  }



  Widget _buildViewSelector() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFFCBD5E1), width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildRadio('म्हैस', 1),
          SizedBox(width: 12),
          _buildRadio('गाय', 0),
        ],
      ),
    );
  }

  Widget _buildRadio(String label, int value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<int>(
          value: value,
          groupValue: selectedMilk,
          onChanged: (val) {
            setState(() => selectedMilk = val!);
            findCurrentData();
          },
          activeColor: Color(0xFF3B82F6),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF334155),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBillView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'बिल',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF475569),
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: billController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFF8FAFC),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xFFCBD5E1), width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xFFCBD5E1), width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xFF3B82F6), width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          ),
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildProducerSearch() {
    return Row(
      children: [
       Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(
             'उत्पादक',
             style: TextStyle(
               fontSize: 14,
               fontWeight: FontWeight.w600,
               color: Color(0xFF475569),
             ),
           ),
           SizedBox(width: 16),
           _buildCompactAutocompleteField(
             mainContext: context,
             icon: Icons.person,
             codeController: codeController,
             nameController: customerNameController,
             options: customerModelList,
             onSelected: (CustomerMaster c) async {
               selectedCustomer = c;
               _clearNumericFields();
               findOpeningBalance();
               findCurrentData();

               setState(() {});
             },
           ),
         ],
       ),
        SizedBox(width: 12),
        _buildNavigationControls(),
        SizedBox(width: 12),
        _buildActionButtons(),
      ],
    );
  }

  void _clearNumericFields() {
    ekkunBilController.clear();
    ekkunLiterController.clear();
    setState(() {});
  }
   void clearAllFields(){
    autoCompleteTextController?.clear();
    _clearNumericFields();

    setState(() {

    });
   }
  Widget _buildRightPanel() {
    return Column(
      children: [
        // Navigation Controls
        // Total Section
        _buildTotalCard(),

        SizedBox(height: 20),
        _buildNivvalDene(),

        // Action Buttons
      ],
    );
  }
  TextEditingController? autoCompleteTextController;

  Widget _buildCompactAutocompleteField({
    required BuildContext mainContext,
    required IconData icon,
    required TextEditingController codeController,
    required TextEditingController nameController,
    required List<CustomerMaster> options,
    required void Function(CustomerMaster) onSelected,
  }) {
    return Container(
      height: 45,
      width: 300,
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
          autoCompleteTextController?.text =
          "${selection.code} ${selection.name}";
          onSelected(selection);
          FocusScope.of(context).requestFocus(cellFocusNode.first);

        },
        fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {

          controller.text = '${codeController.text} ${nameController.text}';
          autoCompleteTextController = controller; // 🔹 Capture controller reference

          return TextField(
            onEditingComplete: onEditingComplete,
            controller: autoCompleteTextController,
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
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
    );
  }


  Widget _buildNavigationControls() {
    return Container(
      padding: EdgeInsets.all(20),
      width: 400,
      child: Column(
        children: [
          Row(
            children: [
              _buildInfoField('एकुण लिटर', ekkunLiterController),
              SizedBox(width: 12),
              _buildInfoField('एकुण बिल', ekkunBilController),
              SizedBox(width: 12),
              _buildNavButton(Icons.arrow_back_ios,(){ findCustomer(false);}),
              SizedBox(width: 12),
              _buildNavButton(Icons.arrow_forward_ios, () {findCustomer(true);}),
            ],
          ),

        ],
      ),
    );
  }

  Widget _buildInfoField(String label, TextEditingController controller) {
    return Container(
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF475569),
            ),
          ),
          SizedBox(height: 6),
          TextFormField(
            readOnly: true,
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFF8FAFC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xFFCBD5E1)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xFFCBD5E1)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xFF3B82F6), width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(IconData icon, VoidCallback onPressed) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFFCBD5E1), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 18, color: Color(0xFF3B82F6)),
        padding: EdgeInsets.all(12),
      ),
    );
  }

  Widget _buildTotalCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEFF6FF), Color(0xFFDBEAFE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: Color(0xFF93C5FD).withOpacity(0.5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF3B82F6).withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.receipt, color: Color(0xFF1E40AF), size: 20),
              SizedBox(width: 8),
              Text(
                'एकुण',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E40AF),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTotalField(totalField1Controller,'आरंभी बाकी'),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildTotalField(totalField2Controller,'कपात रक्कम'),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildTotalField(totalField3Controller,'जमा/येणे बाकी'),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildNivvalDene() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEFF6FF), Color(0xFFDBEAFE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: Color(0xFF93C5FD).withOpacity(0.5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF3B82F6).withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.receipt, color: Color(0xFF1E40AF), size: 20),
              SizedBox(width: 8),
              Text(
                'निव्वळ देणे',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E40AF),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildTotalField(totalField4Controller,'')
        ],
      ),
    );
  }
  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(height: 20,),
        Row(
          children: [
            AnimatedSaveButton(
                focusNode: saveFocus,
                onPressed: _saveDeduction),
            const SizedBox(width: 16),
            _buildClearButton(),
          ],
        ),
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
        onPressed: _clearNumericFields,
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

  Widget _buildTotalField(TextEditingController controller,String title) {
    return Column(

      children: [
        Text(title,  style: TextStyle(
    fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Color(0xFF475569),
    ),),
        SizedBox(height: 10,),
        TextFormField(
          readOnly: true,
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xFF93C5FD)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xFF93C5FD)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xFF3B82F6), width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

// Add these to your state variables
  Map<String, Map<String, TextEditingController>> cellControllers = {};



  Widget _buildKryatTable() {
    return Column(
      children: [
        // Header
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            gradient: LinearGradient(
              colors: [Color(0xFF1E40AF), Color(0xFF3B82F6)],
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 20,
              headingRowHeight: 56,
              dataRowMinHeight: 0,
              dataRowMaxHeight: 0,
              headingRowColor: WidgetStateProperty.all(Colors.transparent),
              dividerThickness: 0,
              columns: [
                _buildHeaderColumn('कपातीचे नाव', 180),
                _buildHeaderColumn('आरंभी बाकी', 140),
                _buildHeaderColumn('कपात रक्कम', 140),
                _buildHeaderColumn('जमा/येणे बाकी', 140),
              ],
              rows: const [],
            ),
          ),
        ),

        // Table Body
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFE2E8F0), width: 1),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            child: Scrollbar(
              thumbVisibility: true,
              trackVisibility: true,
              child: SingleChildScrollView(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 20,
                    headingRowHeight: 0,
                    dataRowMinHeight: 50,
                    dataRowMaxHeight: 50,
                    dividerThickness: 1,
                    border: TableBorder(
                      horizontalInside: BorderSide(
                        color: Color(0xFFE2E8F0),
                        width: 1,
                      ),
                      verticalInside: BorderSide(
                        color: Color(0xFFE2E8F0),
                        width: 1,
                      ),
                    ),
                    columns: [
                      DataColumn(label: SizedBox(width: 180)),
                      DataColumn(label: SizedBox(width: 140)),
                      DataColumn(label: SizedBox(width: 140)),
                      DataColumn(label: SizedBox(width: 140)),
                    ],
                    rows: deductionList.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      final isEven = index % 2 == 0;
                      bool isReadOnly = (entry.value.vasuliType == 'स्थिर कपात') ? true:false;
                      double nivvalDene = double.tryParse(totalField4Controller.text) ?? 0;
                      print('nivval dene is $nivvalDene');
                      if(entry.value.vasuliType != 'स्थिर कपात' && nivvalDene <=0  && cellControllers[index.toString()]!['kapatRakkam']!.text == '')
                        {
                          isReadOnly = true;
                        }
                      print('isreadonly is $isReadOnly');
                      return DataRow(
                        color: WidgetStateProperty.resolveWith<Color?>(
                              (Set<WidgetState> states) {
                            if (states.contains(WidgetState.hovered)) {
                              return Color(0xFF3B82F6).withOpacity(0.08);
                            }
                            return isEven
                                ? Color(0xFFFEF3C7)
                                : Color(0xFFFDE68A);
                          },
                        ),
                        cells: [
                          _buildDataCell(item.name ?? '', 180, false),
                          _buildEditableCell(
                            cellControllers[index.toString()]!['arambhiBaki']!,
                            140,true
                          ),
                          _buildEditableCell(
                            cellControllers[index.toString()]!['kapatRakkam']!,
                            140,isReadOnly,focusNode:  cellFocusNode[index] ,nextFocus: (index+1 < deductionList.length)? cellFocusNode[index+1]:saveFocus,previousFocus:  (index > 0)? cellFocusNode[index-1]:null
                          ),
                          _buildEditableCell(
                            cellControllers[index.toString()]!['jamaYene']!,
                            140,true
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  DataColumn _buildHeaderColumn(String label, double width) {
    return DataColumn(
      label: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }

  DataCell _buildDataCell(String text, double width, bool editable) {
    return DataCell(
      Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF334155),
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  DataCell _buildEditableCell( TextEditingController controller, double width,bool isReadOnly,{FocusNode? focusNode, FocusNode? nextFocus,FocusNode? previousFocus}) {
    return DataCell(
      Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Focus(
          onKeyEvent: (node, event) {
           if (event is KeyDownEvent) {
           //   Detect Down Arrow ↓
             double nivvalDene = double.tryParse(totalField4Controller.text) ?? 0;
             // Detect Up Arrow ↑
             if (event.logicalKey == LogicalKeyboardKey.arrowUp && previousFocus != null) {
               FocusScope.of(context).requestFocus(previousFocus);
               return KeyEventResult.handled;
             }
             if (nivvalDene <= 0) return KeyEventResult.ignored;

             if (event.logicalKey == LogicalKeyboardKey.arrowDown && nextFocus != null) {
                FocusScope.of(context).requestFocus(nextFocus);
                return KeyEventResult.handled;
              }



              // Optional: Enter key behaves like Down arrow
              if (event.logicalKey == LogicalKeyboardKey.enter && nextFocus != null) {
                FocusScope.of(context).requestFocus(nextFocus);
                return KeyEventResult.handled;
              }
            }
             return KeyEventResult.ignored;
          },
          child: TextField(
            readOnly: isReadOnly,
            controller: controller,
            focusNode: focusNode,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            onSubmitted: (value) {
              double nivvalDene = double.tryParse(totalField4Controller.text) ?? 0;
              if (nivvalDene <= 0) return;
              if (nextFocus != null) {
                FocusScope.of(context).requestFocus(nextFocus);
              }
            },
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF334155),
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value) => setState(() {}),
          ),
        ),
      )
      ,
    );
  }
  DateTime adjustDayToNearest5(DateTime selected) {
    final int day = selected.day;
    int newDay;

    if (day >= 1 && day <= 10) {
      newDay = 5;
    } else if (day >= 11 && day <= 20) {
      newDay = 15;
    } else {
      newDay = 25;
    }

    print("adjustDayToNearest5: original=$day → adjusted=$newDay");

    return DateTime(selected.year, selected.month, newDay);
  }

  void _saveDeduction() {
    if(selectedCustomer == null || totalField2Controller.text == '' || selectedPasunDate == null ) return;
    DateTime date =adjustDayToNearest5(selectedPasunDate!);
      DeductionEntry deductionEntry = DeductionEntry(customerCode: selectedCustomer!.code, dedCode: '', dedAmount: double.parse(totalField2Controller.text), milkType: selectedMilk, adminId: adminId,date:date );
      deductionEntryService.addDeductionFromJson(deductionEntry);

      // Add save logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('कपात सेव्ह झाला!')),
      );


  }

}