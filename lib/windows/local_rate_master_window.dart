import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:windows_sample/riverpod/providers.dart';
import 'package:windows_sample/service/rate_chart_service.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../model/rate_group.dart';
import '../model/rate_model.dart';
import '../service/rate_group_service.dart';
import '../service/rate_master_service.dart';
import '../widget/header_widget.dart';

class RateManagementScreen extends ConsumerStatefulWidget {
  const RateManagementScreen({Key? key}) : super(key: key);

  @override
  _RateManagementScreenState createState() => _RateManagementScreenState();
}

class _RateManagementScreenState extends ConsumerState<RateManagementScreen> {
  String? selectedDarPrakar;
  DateTime selectedDate = DateTime.now();
  bool showDarSetup = false;
  bool isCowMilk = true; // true for cow, false for buffalo
  bool butterDudhDar = false;
  bool isFilePicked = false;
  bool isExcelViewed = false;
  bool isEditing = false;
  List<String> oldDates = [];
  late List<RateModel> rateModelList;
  final TextEditingController fatController = TextEditingController();
  final TextEditingController snfController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  late RateService rateService;
  // Dar Setup Controllers - Cow
  final TextEditingController cowKamitKamiFatController =
      TextEditingController();
  final TextEditingController cowKamitKamiSnfController =
      TextEditingController();
  final TextEditingController cowKamitRakkamController =
      TextEditingController();
  final TextEditingController cowJastitJastFatController =
      TextEditingController();
  final TextEditingController cowJastitJastSnfController =
      TextEditingController();
  final TextEditingController cowJastitRakkamController =
      TextEditingController();

  // Dar Setup Controllers - Buffalo
  final TextEditingController buffaloKamitKamiFatController =
      TextEditingController();
  final TextEditingController buffaloKamitKamiSnfController =
      TextEditingController();
  final TextEditingController buffaloKamitRakkamController =
      TextEditingController();
  final TextEditingController buffaloJastitJastFatController =
      TextEditingController();
  final TextEditingController buffaloJastitJastSnfController =
      TextEditingController();
  final TextEditingController buffaloJastitRakkamController =
      TextEditingController();
  late List<List<dynamic>> _sheetData;
  final saveNode = FocusNode();
  final fatNode = FocusNode();
  final snfNode = FocusNode();
  final rateNode = FocusNode();
  final cowKamitKamiFatNode = FocusNode();
  final cowKamitKamiSnfNode = FocusNode();
  final cowKamitRakkamNode = FocusNode();
  final cowJastitJastFatNode = FocusNode();
  final cowJastitJastSnfNode = FocusNode();
  final cowJastitRakkamNode = FocusNode();
  final buffaloKamitKamiFatNode = FocusNode();
  final buffaloKamitKamiSnfNode = FocusNode();
  final buffaloKamitRakkamNode = FocusNode();
  final buffaloJastitJastFatNode = FocusNode();
  final buffaloJastitJastSnfNode = FocusNode();
  final buffaloJastitRakkamNode = FocusNode();
  late RateChartService rateChartService;
  late RateGroupService rateGroupService;
  late RateModel? currentRate ;
  bool isManualDarSetup = false;
  List<RateGroup> rates = [];
  String? fileName;
  bool isLoading = true;
  String? filePath;
  List<List<String>> excel = [];
  int? row;
  int? col;
  late String excelJson;
  bool isNewRate = false;
  String? selectedOldDate;
  TextEditingController newRateController = TextEditingController();
  FocusNode newRateFocusNode = FocusNode();
  String _currentDate() {
    return DateFormat('dd/MM/yyyy').format(selectedDate);
  } 
  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format( date );
  }
  DateTime _formatDateToIso(String date) {
    DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(date);
    return parsedDate; // Returns: 2022-09-18T00:00:00.000
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print("PostFrameCallback running...");
      try {
        rateChartService = ref.read(cowRateChartProvider);
        rateService = ref.read(rateMasterProvider);
        rateGroupService = ref.read(rateGroupProvider);
        rates = await rateGroupService.listGroups();
        rateModelList = await rateService.listRates();
      } catch (e, st) {
        print("Error in loadData: $e");
        print(st);
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }    });
    fatController.addListener(findRate);
    snfController.addListener(findRate);
    setState(() {
    });
  }
  String _encodeExcel(List<List<String>> matrix) => jsonEncode(matrix);
  void _selectRate(){
    if(selectedDarPrakar == null || selectedOldDate ==null ) return;
    int currentMilkType = selectedOldDate!.endsWith('c')?0:1;
    isCowMilk = currentMilkType==0?true:false;

    print('current milk type $currentMilkType');
    currentRate = rateModelList.where((rate) {
      final bool nameMatch = rate.name == selectedDarPrakar;
      final DateTime formattedSelectedDate = _formatDateToIso(selectedOldDate!.substring(0, selectedOldDate!.length - 2));
      final bool dateMatch = rate.date == formattedSelectedDate;
      final bool milkTypeMatch = rate.milkType == currentMilkType;
      final bool allConditionsMatch = nameMatch && dateMatch && milkTypeMatch;

      // Log individual conditions
      print('=== RATE FILTERING LOG ===');
      print('Rate: ${rate.name} | Date: ${rate.date.toIso8601String()} | MilkType: ${rate.milkType}');
      print('Selected DarPrakar: $selectedDarPrakar, Name Match: $nameMatch');
      print('Selected Old Date: $selectedOldDate');
      print('Formatted Selected Date: $formattedSelectedDate');
      print('Rate Date: ${rate.date.toIso8601String()}, Date Match: $dateMatch');
      print('Current Milk Type: $currentMilkType, MilkType Match: $milkTypeMatch');
      print('All Conditions Match: $allConditionsMatch');
      print('---');

      return allConditionsMatch;
    }).firstOrNull;    if(currentRate == null){
      print('current rate is null');
      isFilePicked = false;
      setState(() {
      });
      return;
    }
    isFilePicked = true;

    if(isCowMilk)
    {
      cowKamitKamiFatController.text =currentRate!.minFat.toString();
      cowKamitKamiSnfController.text = currentRate!.minsnf.toString();
      cowKamitRakkamController.text = currentRate!.minRate.toString();
      cowJastitJastFatController.text =currentRate!.maxFat.toString();
      cowJastitJastSnfController.text = currentRate!.maxsnf.toString();
      cowJastitRakkamController.text = currentRate!.maxRate.toString();
    }
    else{
      buffaloKamitKamiFatController.text =currentRate!.minFat.toString();
      buffaloKamitKamiSnfController.text =currentRate!.minsnf.toString();
      buffaloKamitRakkamController.text =currentRate!.minRate.toString();
      buffaloJastitJastFatController.text = currentRate!.maxFat.toString();
      buffaloJastitJastSnfController.text = currentRate!.maxsnf.toString();
      buffaloJastitRakkamController.text = currentRate!.maxRate.toString();
    }
    excel = currentRate!.excel;
    excelJson = currentRate!.excelJson;
    print('excel json is set');
    col = currentRate!.col;
    row = currentRate!.row;
    setState(() {
    });
  }
  void findRate() {

    print('find rate called');
    if (!isNewRate &&  !isFilePicked) {
      showToast(
        "Upload Rate chart first and then test",
        backgroundColor: Colors.redAccent,
        position: ToastPosition.top,
        textStyle: const TextStyle(fontSize: 16, color: Colors.white),
        duration: const Duration(seconds: 2),
      );
      return;
    }
    if (fatController.text != "" && snfController.text != "") {
      double fat = double.parse(fatController.text);
      double snf = double.parse(snfController.text);
      double rate;
      if(isCowMilk) {
        rate = rateChartService.findRateForCow(currentRate!,excel, fat, snf);
      } else {
        rate = rateChartService.findRateForBuffalo(currentRate!,excel , fat, snf);
      }
      rate += double.tryParse(newRateController.text)??0;
      rateController.text = rate.toString();

      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body:(isLoading)? Center(child: CircularProgressIndicator(),):
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
          ),
        ),
        child: Column(
          children: [
            if (!isExcelViewed) const CustomHeader(title: 'स्थानिक दर भरणे'),
            if(isManualDarSetup) manualRateSetup(context),
            // Main Content
            if(!isManualDarSetup)
            Expanded(
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 🔹 Left Content
                        Expanded(child: _buildLeftContent()),

                        const SizedBox(width: 20),

                        // Right Content
                        Expanded(child: _buildDarSetupModal()),
                      ],
                    ),
                  ),
                  if (isFilePicked && isExcelViewed) _buildExcelWidget(),
                ],
              ),
            ),

            // Dar Setup Modal
          ],
        ),
      ),
    );
  }
 void uploadExcelFile()async{
   Map<String,dynamic>? excelData = await rateChartService.pickExcelFile(isCowMilk);
   if(excelData == null)
   {
     return;
   }
   fileName = excelData['fileName'];
   row = excelData["row"];
   col=excelData["col"];
   filePath= excelData["filePath"];
   fileName=excelData["fileName"] ;
   excel = excelData["excelData"];
   excelJson = _encodeExcel(excel);
   isFilePicked = excelData['isFilePicked'];
   print('isfilepicked is ${isFilePicked}');
   if(isCowMilk)
   {
     cowKamitKamiFatController.text = excelData['minimumFat'].toString();
     cowKamitKamiSnfController.text = excelData['minimumSNF'].toString();
     cowKamitRakkamController.text = excelData['minimumRate'].toString();
     cowJastitJastFatController.text = excelData['maximumFat'].toString();
     cowJastitJastSnfController.text = excelData['maximumSNF'].toString();
     cowJastitRakkamController.text = excelData['maximumRate'].toString();

   }
   else{
     buffaloKamitKamiFatController.text = excelData['minimumFat'].toString();
     buffaloKamitKamiSnfController.text = excelData['minimumSNF'].toString();
     buffaloKamitRakkamController.text = excelData['minimumRate'].toString();
     buffaloJastitJastFatController.text = excelData['maximumFat'].toString();
     buffaloJastitJastSnfController.text = excelData['maximumSNF'].toString();
     buffaloJastitRakkamController.text = excelData['maximumRate'].toString();
   }
   print('file name is $fileName');
   RateModel rateModel =  RateModel( isCurrent: false, increment: 0,  name: fileName!, date: selectedDate, milkType: isCowMilk?0:1, excelJson: excelJson, minFat: excelData['minimumFat'], minsnf: excelData['minimumSNF'], minRate: excelData['minimumRate'], maxFat: excelData['maximumFat'], maxsnf:  excelData['maximumSNF'], maxRate:  excelData['maximumRate'], row: row!, col: col!);
    currentRate = rateModel;
   setState(() {
     filePath = fileName;
   });
 }
  Widget _buildLeftContent() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dar Prakar + Switch in one row
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFEBF4FF), Color(0xFFDBEAFE)],
              ),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF93C5FD), width: 1),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left side (label + dropdown)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SelectableText(
                          'दर प्रकार',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF1E3A8A),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 180, // ✅ constrain width
                          child: DropdownButtonFormField<String>(

                            initialValue: selectedDarPrakar,
                            decoration: InputDecoration(
                              hintText: "दर संघ निवडा",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            items:
                                rates.map((rate) {
                                  return DropdownMenuItem(
                                    value: rate.name,
                                    child: SelectableText(rate.name, style: TextStyle(fontSize: 15),),
                                  );
                                }).toList(),
                            onChanged:(isEditing)?null: (value) {
                              print('value is $value');
                              selectedOldDate = null;
                              oldDates = rateModelList
                                  .where((rate) => rate.name == value) // Filter for matching rates
                                  .map((rate) => '${_formatDate(rate.date)}-${rate.milkType == 0?'c':'b'}')           // Extract the date from filtered rates
                                  .toList();
                              setState(() {
                                selectedDarPrakar = value!;
                              });
                              _selectRate();
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 20,),
                    if (isNewRate)
                    Expanded(
             child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SelectableText(
            'तारीख निवडा',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1E3A8A),
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () async {
              final DateTime? picked =
              await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );
              if (picked != null &&
                  picked != selectedDate) {
                setState(() {
                  selectedDate = picked;
                });
              }
            },
            child: Container(
              width: 150,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    color: Color(0xFF1E3A8A),
                  ),
                  const SizedBox(width: 8),
                  SelectableText(
                    _currentDate(),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
               )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SelectableText(
                            'जुन्या तारखा',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1E3A8A),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: 180, // ✅ constrain width
                            child: DropdownButtonFormField<String>(
                              value: selectedOldDate,
                              decoration: InputDecoration(
                                hintText: "जुन्या तारखा",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              items:
                                  oldDates.map((rate) {
                                    return DropdownMenuItem(
                                      value: rate,
                                      child: SelectableText(rate),
                                    );
                                  }).toList(),
                              onChanged: (value) {
                                print('value date is $value');

                                setState(() {
                                  selectedOldDate = value!;
                                });
                                _selectRate();
                              },
                            ),
                          ),
                        ],
                      ),
                    SizedBox(width: 10,),

                    // Right side (Switch)
                    if(isNewRate)
                    Column(
                      children: [
                        const SelectableText(
                          'प्राण्याचा प्रकार',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF1E3A8A),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            SelectableText(
                              'गाय',
                              style: TextStyle(
                                color:
                                    isCowMilk
                                        ? Color(0xFF2563EB)
                                        : Color(0xFF6B7280),
                                fontWeight:
                                    isCowMilk
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                              ),
                            ),
                            Switch(
                              value: !isCowMilk,
                              onChanged: (value) {
                                fatController.text = '';
                                snfController.text = '';
                                rateController.text = '';
                                isFilePicked = false;
                                setState(() {
                                  isCowMilk = !value;
                                });
                              },
                              inactiveTrackColor: Colors.blue[100],
                              inactiveThumbColor: Colors.blue,
                              activeColor: Color(0xFF8B5CF6),
                            ),
                            SelectableText(
                              'म्हैस',
                              style: TextStyle(
                                color:
                                    !isCowMilk
                                        ? Color(0xFF8B5CF6)
                                        : Color(0xFF6B7280),
                                fontWeight:
                                    !isCowMilk
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                if(isEditing)
                  Row(
                    children: [
                      SizedBox(
                        width: 180,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SelectableText(
                              'तारीख निवडा',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1E3A8A),
                              ),
                            ),
                            const SizedBox(height: 8),
                            InkWell(
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate,
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2030),
                                );
                                if (picked != null && picked != selectedDate) {
                                  setState(() {
                                    selectedDate = picked;
                                  });
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_today,
                                      color: Color(0xFF1E3A8A),
                                    ),
                                    const SizedBox(width: 8),
                                    SelectableText(
                                      _currentDate(),
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 110),
                   SizedBox(
                            width: 180,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(
                                  "नवीन दर",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF1E3A8A),
                                  ),
                                ),
                                const SizedBox(height: 10),

                                TextField(
                                  keyboardType: const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ), // allows int & double
                                  textInputAction: TextInputAction.next,

                                  focusNode: newRateFocusNode,
                                  controller: newRateController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^-?\d*\.?\d{0,2}$'),
                                    ),


                                  ],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(color: Colors.grey.shade300),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF2563EB),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                    ],
                  ),
                SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        'FAT',
                        fatController,
                        fatNode,
                        snfNode,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _buildTextField(
                        'SNF',
                        snfController,
                        snfNode,
                        rateNode,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _buildTextField(
                        'Rate',
                        rateController,
                        rateNode,
                        rateNode,
                        true,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if(isNewRate)
                    _buildUploadButton(), _buildOpenExcelButton(),
                    if(isFilePicked && !isNewRate && !isEditing && currentRate!.isCurrent)
                    Container(
                      child: Row(
                        children: [Icon(Icons.check_circle,color: Colors.green,size: 30),
                          Text("Currently Using",style: TextStyle(color: Colors.green,fontSize: 20,fontWeight: FontWeight.bold),)],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    (isNewRate || isEditing)?
                      Expanded(
                        child: _buildActionButton(
                          'Stop',
                          Icons.stop,
                          Colors.red,
                              () {
                            setState(() {
                            isNewRate = false;
                            selectedDarPrakar = null;
                            selectedOldDate= null;
                            oldDates = [];
                            isEditing = false;
                            fatController.clear();
                            snfController.clear();
                            rateController.clear();
                            isFilePicked = false;
                            newRateController.clear();
                          });},
                        ),
                      ):
                    Expanded(
                      child: _buildActionButton('New', Icons.add, Colors.green, () {
                        print('new rate clicked');
                        isFilePicked = false;

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("How would you like to create new rate chart?"),
                              content: const Text("Choose one of the following options:"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // close dialog
                                    // TODO: handle Excel upload flow here
                                    setState(() {
                                      isNewRate = true;
                                    });
                                    print("Upload Excel selected");
                                  },
                                  child: const Text("Upload Excel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // close dialog
                                    setState(() {
                                      isNewRate = true;
                                      isManualDarSetup = true;
                                    });
                                    print("Manual selected");
                                  },
                                  child: const Text("Manual"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      ),
                    ),
                    const SizedBox(width: 10),
                    if(isNewRate || isEditing)
                    Expanded(
                      child: _buildActionButton(
                        'Save',
                        Icons.save,
                        Colors.blue,
                           _saveRateInfo,
                      ),
                    ),
                    const SizedBox(width: 10),
                    if(!isNewRate && !isEditing)
                      Expanded(
                        child: _buildActionButton(
                          'Edit',
                          Icons.edit,
                          (isFilePicked)? Colors.orange:Colors.grey,
                              () {
                            if(isFilePicked) {
                              isEditing = true;
                              newRateController.text = currentRate!.increment.toStringAsFixed(2);
                            }
                            else{
                              showCustomizedToast("rate is not selected", Colors.redAccent);
                            }
                            setState(() {

                            });
                          },
                        ),
                      ),
                    const SizedBox(width: 10),
                    if(isFilePicked && !isNewRate && !isEditing)
                    Expanded(
                        child: _buildActionButton(
                          'Delete',
                          Icons.delete_forever,
                         Colors.redAccent,
                                () {
                              deleteCustomerChart(
                                  context: context,
                                  customerName: currentRate!.name,
                                  onDelete: () async {
                                    rateService.removeRate(currentRate!.id);
                                    rateModelList.remove(currentRate);
                                    oldDates.remove( '${_formatDate(currentRate!.date)}-${currentRate!.milkType == 0?'c':'b'}' );
                                    selectedDarPrakar = null;
                                    selectedOldDate = null;
                                    clearAllControllers();
                                    isFilePicked = false;
                                    setState(() {

                                    });
                                    },
                                );
                             },

                        ),
                      ),

                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  void clearAllControllers() {
    // Cow Controllers
    cowKamitKamiFatController.clear();
    cowKamitKamiSnfController.clear();
    cowKamitRakkamController.clear();
    cowJastitJastFatController.clear();
    cowJastitJastSnfController.clear();
    cowJastitRakkamController.clear();

    // Buffalo Controllers
    buffaloKamitKamiFatController.clear();
    buffaloKamitKamiSnfController.clear();
    buffaloKamitRakkamController.clear();
    buffaloJastitJastFatController.clear();
    buffaloJastitJastSnfController.clear();
    buffaloJastitRakkamController.clear();
  }
  Widget _buildDarSetupModal() {
    return Container(
      width: MediaQuery.of(context).size.width * 1.2,
      height: MediaQuery.of(context).size.height * 1.2,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: Column(
              children: [
                // Left Side - Cow
                if(isCowMilk)
                Expanded(
                  child: _buildWhiteContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SelectableText(
                          'गाय',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E3A8A),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                'कमीत कमी FAT',
                                cowKamitKamiFatController,
                                cowKamitKamiFatNode,
                                cowKamitKamiSnfNode,
                                !isEditing
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: _buildTextField(
                                'कमीत कमी SNF',
                                cowKamitKamiSnfController,
                                cowKamitKamiSnfNode,
                                cowKamitRakkamNode,
                                  !isEditing
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: _buildTextField(
                                'रक्कम',
                                cowKamitRakkamController,
                                cowKamitRakkamNode,
                                cowJastitJastFatNode,
                                  !isEditing
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                'जास्तीत जास्त FAT',
                                cowJastitJastFatController,
                                cowJastitJastFatNode,
                                cowJastitJastSnfNode,
                                  !isEditing
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: _buildTextField(
                                'जास्तीत जास्त SNF',
                                cowJastitJastSnfController,
                                cowJastitJastSnfNode,
                                cowJastitRakkamNode,
                                  !isEditing
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: _buildTextField(
                                'रक्कम',
                                cowJastitRakkamController,
                                cowJastitRakkamNode,
                                buffaloKamitKamiFatNode,
                                  !isEditing
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),

                // Right Side - Buffalo
                if(!isCowMilk)
                Expanded(
                  child: _buildWhiteContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SelectableText(
                          'म्हैस',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E3A8A),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                'कमीत कमी FAT',
                                buffaloKamitKamiFatController,
                                buffaloKamitKamiFatNode,
                                buffaloKamitKamiSnfNode,
                                  !isEditing
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: _buildTextField(
                                'कमीत कमी SNF',
                                buffaloKamitKamiSnfController,
                                buffaloKamitKamiSnfNode,
                                buffaloKamitRakkamNode,
                                  !isEditing
                              ),

                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: _buildTextField(
                                'रक्कम',
                                buffaloKamitRakkamController,
                                buffaloKamitRakkamNode,
                                buffaloJastitJastFatNode,
                                  !isEditing
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                'जास्तीत जास्त FAT',
                                buffaloJastitJastFatController,
                                buffaloJastitJastFatNode,
                                buffaloJastitJastSnfNode,
                                  !isEditing
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: _buildTextField(
                                'जास्तीत जास्त SNF',
                                buffaloJastitJastSnfController,
                                buffaloJastitJastSnfNode,
                                buffaloJastitRakkamNode,
                                  !isEditing
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: _buildTextField(
                                'रक्कम',
                                buffaloJastitRakkamController,
                                buffaloJastitRakkamNode,
                                saveNode,
                                  !isEditing
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildWhiteContainer({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEBF4FF), Color(0xFFDBEAFE)],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFF93C5FD), width: 1),
      ),
      child: child,
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    FocusNode focusNode, [
    FocusNode? nextFocusNode,
    bool readOnly = false,
  ]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1E3A8A),
          ),
        ),
        const SizedBox(height: 4),

        Container(
          width: 100,
          height: 40,
          child: TextField(

            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ), // allows int & double
            readOnly: readOnly,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) {
              FocusScope.of(context).requestFocus(nextFocusNode);
            },
            focusNode: focusNode,
            controller: controller,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$')),
              // ✅ Explanation:
              // ^         : start of input
              // \d*       : any number of digits
              // \.?       : optional decimal point
              // \d{0,2}   : up to 2 decimal places (adjust as needed)
              // $         : end of input
            ],
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF2563EB)),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }


  Future<void> deleteCustomerChart({
    required BuildContext context,
    required String customerName,
    required Future<void> Function() onDelete,
  }) async {
   print('Initiating delete process for customer: $customerName');

    // Step 1: Show confirmation dialog
    final bool? confirm = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          title: const Text(
            'Confirm Deletion',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Are you sure you want to delete the chart for "$customerName"?\nThis action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                print('User canceled deletion for $customerName');
                Navigator.of(ctx).pop(false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              onPressed: () {
                print('User confirmed deletion for $customerName');
                Navigator.of(ctx).pop(true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    // Step 2: Perform deletion if confirmed
    if (confirm == true) {
      try {
        print('Deleting chart for customer: $customerName...');
        await onDelete();
        print('Successfully deleted chart for $customerName');

        // Optional success feedback
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Deleted chart for $customerName successfully.'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e, stack) {
        print('Error deleting chart: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete chart for $customerName.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      print('Deletion aborted by user for $customerName');
    }
  }
  Widget _buildActionButton(
    String text,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  )
  {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white, size: 18),
      label: SelectableText(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildUploadButton() {
    return InkWell(
      onTap: uploadExcelFile,
      splashColor: Colors.white.withOpacity(0.1),
      highlightColor: Colors.white.withOpacity(0.05),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
        child: Row(
          children: [
            Icon(Icons.upload_file, size: 18, color: Colors.white),
            SizedBox(width: 8),
            AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 200),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              child: SelectableText('Upload Rate Chart'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOpenExcelButton() {
    return InkWell(
      onTap: () async {
       if(!isNewRate)
         {
           if(selectedDarPrakar == '')
           {
             showToast(
               "Select Dar Prakar",
               backgroundColor: Colors.redAccent,
               position: ToastPosition.top,
               textStyle: const TextStyle(fontSize: 16, color: Colors.white),
               duration: const Duration(seconds: 2),
             );
             return;
           }
           if(selectedOldDate == '')
           {
             showToast(
               "Select Old Date",
               backgroundColor: Colors.redAccent,
               position: ToastPosition.top,
               textStyle: const TextStyle(fontSize: 16, color: Colors.white),
               duration: const Duration(seconds: 2),
             );
             return;
           }
         }
        if(selectedDarPrakar == '')
        {
          showToast(
            "Select Dar Prakar",
            backgroundColor: Colors.redAccent,
            position: ToastPosition.top,
            textStyle: const TextStyle(fontSize: 16, color: Colors.white),
            duration: const Duration(seconds: 2),
          );
          return;
        }
        if (!isFilePicked ) {
          print('file not picked');
          showToast(
            "Upload Rate chart first",
            backgroundColor: Colors.redAccent,
            position: ToastPosition.top,
            textStyle: const TextStyle(fontSize: 16, color: Colors.white),
            duration: const Duration(seconds: 2),
          );
          return;
        }
        setState(() {
          isExcelViewed = true;
          setState(() {});
        });
      },
      splashColor: Colors.white.withOpacity(0.1),
      highlightColor: Colors.white.withOpacity(0.05),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors:
                (isFilePicked)
                    ? [Colors.lightGreen, Colors.green]
                    : [Colors.grey, Colors.grey],
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
        child: Row(
          children: [
            Icon(Icons.save_rounded, size: 18, color: Colors.white),
            SizedBox(width: 8),
            AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 200),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              child: SelectableText('Open Rate Chart'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExcelWidget() {

    _loadExcelFromJson(excelJson);
    if (_sheetData.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(18),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.table_chart, color: Colors.white, size: 28),
                const SizedBox(width: 12),
               SelectableText(
                  "रेट चार्ट",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap:
                      () => setState(() {
                        isExcelViewed = false;
                      }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.close, color: Colors.white, size: 16),
                        const SizedBox(width: 8),
                        SelectableText(
                          'बंद करा',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SfDataGrid(
              source: ExcelDataSource(_sheetData),
              columns: List.generate(
                _sheetData.first.length,
                (i) => GridColumn(
                  columnName: "C$i",
                  label: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: SelectableText(
                      "Col ${i + 1}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              columnWidthMode: ColumnWidthMode.auto, // Auto-fit like Excel
              gridLinesVisibility: GridLinesVisibility.both,
              headerGridLinesVisibility: GridLinesVisibility.both,
              allowSorting: true,
              allowColumnsResizing: true,
            ),
          ),
        ],
      ),
    );
  }



  void _loadExcelFromJson(String excelJson) {
    print('row and col are ${row} and ${col}');
    print('iseditingg value is ${isEditing}');
    double increment = (isEditing)? double.tryParse( newRateController.text)??0 + currentRate!.increment:currentRate!.increment;
    print('increment became $increment');
    if( increment == 0){
      print('inside iff');
      try {
        // ✅ Decode JSON into List<List<dynamic>>
        final data = jsonDecode(excelJson) as List<dynamic>;

        _sheetData = data
            .map((row) => (row as List<dynamic>)
            .map((cell) => cell.toString()) // keep everything as string
            .toList())
            .toList();

        setState(() {});
        print("✅ Excel data loaded from JSON successfully");
      } catch (e, st) {
        print("⚠️ Error decoding excelJson: $e");
        print(st);
      }
    }
    else{
      print('in else logic');
      try {
        // ✅ Decode JSON into List<List<dynamic>>
        final data = jsonDecode(excelJson) as List<dynamic>;

        _sheetData = data.asMap().entries.map((rowEntry) {
          final rIndex = rowEntry.key;
          final currentRow = rowEntry.value as List<dynamic>;

          return currentRow.asMap().entries.map((colEntry) {
            final cIndex = colEntry.key;
            final cell = colEntry.value;

            // ✅ Skip modification for the specified row/col
            if (rIndex == row!-1 || cIndex == col) {
              print("ℹ️ Skipping modification for row=$rIndex, col=$cIndex");
              return cell.toString();
            }

            // ✅ Try parsing as double
            final cellStr = cell.toString();
            final parsed = double.tryParse(cellStr);

            if (parsed != null) {
              final newValue = parsed + increment;
              print(
                  "ℹ️ Updated cell [$rIndex,$cIndex]: $parsed → $newValue (increment=$increment)");
              return newValue.toStringAsFixed(2);
            }

            // Keep non-numeric values as string
            return cellStr;
          }).toList();
        }).toList();

        setState(() {});
        print("✅ Excel data loaded & updated from JSON successfully");
      } catch (e, st) {
        print("⚠️ Error decoding excelJson: $e");
        print(st);
      }
    }
  }
  void showCustomizedToast(String message, Color backgroundColor) {
    showToast(
      message,
      backgroundColor: backgroundColor,
      position: ToastPosition.top,
      textStyle: const TextStyle(fontSize: 16, color: Colors.white),
      duration: const Duration(seconds: 3),
    );
  }
  void _saveRateInfo()async {
    if(selectedDarPrakar != null && selectedDarPrakar == '')
    {
      showCustomizedToast("Select dar prakar", Colors.red);
      return;
    }
    if(!isFilePicked ){
      showCustomizedToast("Select rate chart first", Colors.red);
      return;
    }
    double increment = 0;

    late RateModel rateModel;
    if(isEditing){
      increment = double.tryParse(newRateController.text)??0;
      isCowMilk =  currentRate!.milkType == 0?  true: false;
    }

      if(isCowMilk) {
        print('gay is selected');
        rateModel =  RateModel.fromExcel(isCurrent:false,name: selectedDarPrakar!, date: selectedDate , milkType:0, excel: excel, minFat: double.parse(cowKamitKamiFatController.text), minsnf: double.parse(cowKamitKamiSnfController.text), minRate: double.parse(cowKamitRakkamController.text) + increment, maxFat: double.parse(cowJastitJastFatController.text), maxsnf: double.parse(cowJastitJastSnfController.text), maxRate: double.parse(cowJastitRakkamController.text) + increment, row: row!, col: col!,increment :increment +currentRate!.increment);
      }
      else{
        rateModel =  RateModel.fromExcel(isCurrent:false,   name: selectedDarPrakar!, date: selectedDate , milkType:1, excel: excel, minFat: double.parse(buffaloKamitKamiFatController.text), minsnf: double.parse(buffaloKamitKamiSnfController.text), minRate: double.parse(buffaloKamitRakkamController.text) + increment, maxFat: double.parse(buffaloJastitJastFatController.text), maxsnf: double.parse(buffaloJastitJastSnfController.text), maxRate: double.parse(buffaloJastitRakkamController.text) + increment, row: row!, col: col!,increment :increment + currentRate!.increment);
      }
      print('saving rate model');
      await rateService.addRate(rateModel);

    print('value of increment is $increment');


    isNewRate  = false;
    isFilePicked = false;
    print('ratemodel list lenght is ${rateModelList.length}');
    rateModelList = await rateService.listRates();
    print('ratemodel list lenght is ${rateModelList.length}');

    selectedDarPrakar = null;
    selectedOldDate= null;
    oldDates = [];
    currentRate = null;
    fatController.clear();
    snfController.clear();
    rateController.clear();
    isEditing = false;
    showCustomizedToast("Rate saved Successfully", Colors.green);
    newRateController.clear();
    setState(() {
    });
  }
  Widget manualRateSetup(BuildContext context) {
    final rowLabels = [
      '२.०','२.१','२.२','२.३','२.४','२.५','२.६','२.७','२.८','२.९',
      '३.०','३.१','३.२','३.३','३.४','३.५','३.६','३.७','३.८','३.९',
    ];

    final columnLabels = [
      '७.०','७.१','७.२','७.३','७.४','७.५','७.६','७.७','७.८','७.९',
      '८.०','८.१','८.२','८.३','८.४','८.५','८.६','८.७','८.८','८.९',
      '९.०','९.१','९.२','९.३','९.४','९.५','९.६','९.७','९.८','९.९',
      '१०.०','१०.१','१०.२','१०.३','१०.४','१०.५','१०.६','१०.७','१०.८','१०.९',
      '११.०','११.१','११.२','११.३','११.४','११.५','११.६','११.७','११.८','११.९',
      '१२.०','१२.१','१२.२','१२.३','१२.४','१२.५','१२.६','१२.७','१२.८','१२.९',
      '१३.०','१३.१','१३.२','१३.३','१३.४','१३.५','१३.६','१३.७','१३.८','१३.९',
      '१४.०','१४.१','१४.२','१४.३','१४.४','१४.५','१४.६','१४.७','१४.८','१४.९',
      '१५.०'
    ];

    // init grid
    final sheetData = [
      ["FAT\\SNF", ...columnLabels],
      for (var r in rowLabels) [r, ...List.filled(columnLabels.length, '')]
    ];

    final verticalController = ScrollController();
    final horizontalController = ScrollController();

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          color: Colors.white,
          child: Column(
            children: [
              // Header bar
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.green,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.table_chart, color: Colors.white, size: 28),
                    const SizedBox(width: 12),
                    const Text(
                      "रेट चार्ट",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: (){setState((){
                        isManualDarSetup = false;
                      });},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.close, color: Colors.white, size: 16),
                            SizedBox(width: 8),
                            Text(
                              'बंद करा',
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Grid
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Scrollbar(
                  controller: verticalController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: verticalController,
                    scrollDirection: Axis.vertical,
                    child: Scrollbar(
                      controller: horizontalController,
                      thumbVisibility: true,
                      notificationPredicate: (notif) => notif.depth == 1,
                      child: SingleChildScrollView(
                        controller: horizontalController,
                        scrollDirection: Axis.horizontal,
                        child: Table(
                          border: TableBorder.all(color: Colors.grey[400]!, width: 1),
                          defaultColumnWidth: const FixedColumnWidth(80),
                          children: [
                            // header row
                            TableRow(
                              decoration: BoxDecoration(color: Colors.blue[700]),
                              children: [
                                _headerCell("FAT\\SNF"),
                                ...columnLabels.map((c) => _headerCell(c)),
                              ],
                            ),
                            // data rows
                            for (int r = 0; r < rowLabels.length; r++)
                              TableRow(
                                decoration: BoxDecoration(
                                  color: r.isEven ? Colors.grey[50] : Colors.white,
                                ),
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    alignment: Alignment.center,
                                    color: Colors.grey[200],
                                    child: Text(
                                      rowLabels[r],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  for (int c = 0; c < columnLabels.length; c++)
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 13),
                                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                                        ],
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(8),
                                          isDense: true,
                                        ),
                                        onChanged: (val) {
                                          setState(() {
                                            sheetData[r + 1][c + 1] = val;
                                          });
                                        },
                                      ),
                                    )
                                ],
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )

            ],
          ),
        );
      },
    );
  }
  Widget _headerCell(String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 13,
        ),
      ),
    );
  }
}





class ExcelDataSource extends DataGridSource {
  final List<List<dynamic>> data;
  late List<DataGridRow> _rows;

  ExcelDataSource(this.data) {
    _rows =
        data.map((row) {
          return DataGridRow(
            cells:
                row
                    .asMap()
                    .entries
                    .map(
                      (e) => DataGridCell<dynamic>(
                        columnName: "C${e.key}",
                        value: e.value,
                      ),
                    )
                    .toList(),
          );
        }).toList();
  }

  @override
  List<DataGridRow> get rows => _rows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells:
          row.getCells().map((cell) {
            return Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.centerLeft,
              child: SelectableText(cell.value.toString()),
            );
          }).toList(),
    );
  }
}


class _EditableCell extends StatefulWidget {
  final double? value;
  final ValueChanged<double?> onChanged;
  final int rowIndex;
  final int colIndex;
  final List<String> rowLabels;
  final List<String> columnLabels;
  final Map<String, Map<String, double?>> dataGrid;
  final StateSetter setState;

  const _EditableCell({
    required this.value,
    required this.onChanged,
    required this.rowIndex,
    required this.colIndex,
    required this.rowLabels,
    required this.columnLabels,
    required this.dataGrid,
    required this.setState,
  });

  @override
  State<_EditableCell> createState() => _EditableCellState();
}

class _EditableCellState extends State<_EditableCell> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.value != null ? widget.value!.toStringAsFixed(1) : '',
    );
    _focusNode = FocusNode();

    // Clear selection when focus is gained
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller.selection = TextSelection(
          baseOffset: 0,
          extentOffset: _controller.text.length,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(_EditableCell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && !_focusNode.hasFocus) {
      _controller.text = widget.value != null ? widget.value!.toStringAsFixed(1) : '';
    }
  }

  void _moveFocus(int rowDelta, int colDelta) {
    final newRowIndex = widget.rowIndex + rowDelta;
    final newColIndex = widget.colIndex + colDelta;

    // Check bounds
    if (newRowIndex >= 0 && newRowIndex < widget.rowLabels.length &&
        newColIndex >= 0 && newColIndex < widget.columnLabels.length) {
      // Unfocus current cell
      _focusNode.unfocus();

      // Request focus on next frame to allow the widget tree to update
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // The actual focus management would require a more complex implementation
        // with FocusNodes stored in a 2D array at the parent level
        // For now, this provides the arrow key detection
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (event) {
        if (event is KeyDownEvent && _focusNode.hasFocus) {
          if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
            _moveFocus(-1, 0);
          } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
            _moveFocus(1, 0);
          } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            _moveFocus(0, -1);
          } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            _moveFocus(0, 1);
          } else if (event.logicalKey == LogicalKeyboardKey.enter) {
            _moveFocus(1, 0); // Move down on Enter
          }
        }
      },
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 14),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
        ],
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          isDense: true,
        ),
        onChanged: (value) {
          if (value.isEmpty) {
            widget.onChanged(null);
          } else {
            final parsed = double.tryParse(value);
            if (parsed != null) {
              widget.onChanged(parsed);
            }
          }
        },
      ),
    );
  }
}