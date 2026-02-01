import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:windows_sample/model/customer_model.dart';
import 'package:windows_sample/service/customer_service.dart';
import '../../model/branch_model.dart';
import '../../model/milk_collection_model.dart';
import '../../pdf_generation/aavak_report_generation.dart';
import '../../pdf_generation/pdf_api.dart';
import '../../riverpod/providers.dart';
import '../../service/branch_service.dart';
import '../../service/milk_collection_service.dart';

class AavakReportWindow extends ConsumerStatefulWidget {
  const AavakReportWindow({Key? key}) : super(key: key);

  @override
  ConsumerState<AavakReportWindow> createState() => _AavakReportWindowState();
}

class _AavakReportWindowState extends ConsumerState<AavakReportWindow> {
  bool isLoading = false;
  String selectedMilkType = 'गाय'; // Cow
  String? selectedBranch ; // All
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  List<BranchMaster> branchList = [];
  String milkType = 'एकत्र';
  String adminId = "1";
  String selectedPrintType =  "सर्व";
  final saveFocusNode = FocusNode();
  late CustomerService customerService;
  late List<CustomerMaster> customerList;
  @override
  void initState() {
    super.initState();
    _initializeData();
  }
  String _currentDate() {
    return DateFormat('dd-MM-yyyy').format(DateTime.now());
  }
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
    BranchMasterService branchService =  ref.read(branchMasterServiceProvider);
    branchList =await branchService.getAllBranches();
    customerService = ref.read(customerServiceProvider);
    customerList =await customerService.fetchAllCustomers(adminId);
    print('branch size is ${branchList.length}');
    setState(() {

    });
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFromDate ? fromDate : toDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2563EB),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
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
            'आवकदुध रिपोर्ट',
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
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left section - Milk Type and Branch Selection
          Column(
            children: [
              _buildMilkTypeSection(),
              const SizedBox(height: 16),
              _buildBranchSection(),
            ],
          ),
          // Right section - Date Selection and Action Buttons
          _buildRightSection(),
        ],
      ),
    );
  }
  void generateAavakReport() async{

    List<MilkCollectionModel> milkCollection= [];
    print(fromDate);
    if(selectedMilkType == 'म्हैस')
    {

      List<MilkCollectionModel>? buffaloList = await getAllForAdminWithSpecification(0,adminId);
      //  List<MilkCollectionModel> list = await MilkCollectionService.getAllForAdmin(widget.admin.id!);
      if(buffaloList == null)
      {
        return null;
      }
      milkCollection.addAll(buffaloList);
    }
    else if(selectedMilkType == 'गाय')
    {

      List<MilkCollectionModel>? cowList = await getAllForAdminWithSpecification(1,adminId);
      if(cowList == null)
      {
        return null;
      }
      milkCollection.addAll(cowList);
    }
    if(milkCollection.isEmpty)
    {
      print('//////////////////////////////////it is still aavak report milkcollection empty');
    }
    else {

      print(milkCollection.first.date);
      print('customr list lenght is ${customerList.length}');
      AavakReport pdfInvoiceApi =
      await AavakReport.create(milkCollection, "1",customerList);
      final pdfFile = await pdfInvoiceApi.generate();

      final file = await PdfApi.saveDocument(
          name: "भैरवनाथ डेअरि आवक ${DateTime.now().millisecondsSinceEpoch}",
          pdf: pdfFile);
      PdfApi.openFile(file);
    }
  }

  Future<List<MilkCollectionModel>?> getAllForAdminWithSpecification(int milkType,
      String adminId)async{
    MilkCollectionService milkCollectionService = ref.read(milkCollectionProvider);
    List<MilkCollectionModel>? list = await milkCollectionService.getCollectionByMilkTypeAndAdminIdAndDateBetween(milkType,adminId,fromDate,toDate);

    return list;
  }

  Widget _buildMilkTypeSection() {
    return Container(
      width: 300,
      margin: const EdgeInsets.fromLTRB(24, 24, 12, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Radio<String>(
                value: 'गाय',
                groupValue: selectedMilkType,
                onChanged: (value) {
                  setState(() {
                    selectedMilkType = value!;
                  });
                },
                activeColor: const Color(0xFF2563EB),
              ),
              const Text(
                'गाय',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Row(
            children: [
              Radio<String>(
                value: 'म्हैस',
                groupValue: selectedMilkType,
                onChanged: (value) {
                  setState(() {
                    selectedMilkType = value!;
                  });
                },
                activeColor: const Color(0xFF2563EB),
              ),
              const Text(
                'म्हैस',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Row(
            children: [
              Radio<String>(
                value: 'एकत्रित',
                groupValue: selectedMilkType,
                onChanged: (value) {
                  setState(() {
                    selectedMilkType = value!;
                  });
                },
                activeColor: const Color(0xFF2563EB),
              ),
              const Text(
                'एकत्रित',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBranchSection() {
    return Container(
      width: 300,
      margin: const EdgeInsets.fromLTRB(24, 0, 12, 24),
      padding: const EdgeInsets.all(20),
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Radio<String>(
                value: 'सर्व',
                groupValue: selectedPrintType,
                onChanged: (value) {
                  setState(() {
                    selectedPrintType = value!;
                  });
                },
                activeColor: const Color(0xFF2563EB),
              ),
              const Text(
                'सर्व',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Row(
            children: [
              Radio<String>(
                value: 'ठराविक शाखेनुसार',
                groupValue: selectedPrintType,
                onChanged: (value) {
                  selectedPrintType =value!;
                  setState(() {
                  });
                },
                activeColor: const Color(0xFF2563EB),
              ),
              const Text(
                'ठराविक शाखेनुसार',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          if(selectedPrintType == 'ठराविक शाखेनुसार')
            Container(
              width: 300,
              child:
              DropdownButtonFormField<String>(
                value: selectedBranch,
                onChanged: (value){
                  if(value != null)
                    selectedBranch = value;
                  setState(() {

                  });
                },
                dropdownColor: Colors.white,
                isExpanded: true,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF111827),
                ),
                decoration: InputDecoration(
                  filled: true,

                  fillColor: Colors.white,
                  hintText: "शाखा निवडा",
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
                items: branchList
                    .map((e) => DropdownMenuItem<String>(
                  value: e.name,
                  child: Text(
                    e.name.toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }

  Widget _buildRightSection() {
    return Container(
      width: 300,
      margin: const EdgeInsets.fromLTRB(12, 24, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDateField('प्रारंभ', fromDate, true),
          const SizedBox(height: 16),
          _buildDateField('पर्यंत', toDate, false),
          const SizedBox(height: 24),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildDateField(String label, DateTime date, bool isFromDate) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () => _selectDate(context, isFromDate),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('dd.MM.yyyy').format(date),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildActionButton('प्रिंट करा', Icons.print, Colors.blue,generateAavakReport)),
            const SizedBox(width: 12),
            Expanded(child: _buildStopButton()),
          ],
        ),

      ],
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color,VoidCallback action) {
    return ElevatedButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: color,
        elevation: 2,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildStopButton() {
    return ElevatedButton(
      onPressed: () {
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.red,
        elevation: 2,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'STOP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
