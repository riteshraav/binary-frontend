import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:windows_sample/model/rate_group.dart';
import 'package:windows_sample/model/rate_model.dart';
import '../model/branch_model.dart';
import '../riverpod/providers.dart';
import '../widget/animated_button_widget.dart';
import 'package:intl/intl.dart';
class BranchMasterWindow extends ConsumerStatefulWidget {
  @override
  _BranchMasterWindowState createState() => _BranchMasterWindowState();
}


class _BranchMasterWindowState extends ConsumerState<BranchMasterWindow> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  late final branchMasterService ;
  bool isVillageSelected = true;
  bool isPrintChecked = false;
  String selectedShift = 'सकाळ';
  FocusNode _focusNode = FocusNode();

 late List<BranchMaster> branchModelList ;

  List<RateGroup> rateGroupList = [RateGroup(name:'दर क्र १'),RateGroup(name:'दर क्र २'),RateGroup(name:'दर क्र ३')];
  bool isLoading = true;
  FocusNode _marathiFocusNode = FocusNode();

  String? selectedRate;
  String _currentDate(){
    return DateFormat('dd-MM-yyyy').format(DateTime.now());
  }
  @override
  void initState() {
    super.initState();
    _marathiFocusNode.addListener(_handleFocusChange);

    print("InitState running...");

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print("PostFrameCallback running...");
      try {
        await loadData();
      } catch (e, st) {
        print("Error in loadData: $e");
        print(st);
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    });
  }
  void _handleFocusChange() {
    if (_marathiFocusNode.hasFocus) {
      // Configure for Marathi input
      SystemChannels.textInput.invokeMethod('TextInput.setClient', [
        1,
        {'inputType': {'name': 'text'}, 'readOnly': false}
      ]);
    }
  }

  Future<void> loadData()
  async{
    branchMasterService =  ref.watch(branchMasterServiceProvider);
    branchModelList =await branchMasterService.getAllBranches();
     print('branchmodellist is ${branchModelList.length}');
    codeController.text = (branchModelList.length + 1).toString();

  }

  void _clearFields() {
    codeController.text = (branchModelList.length + 1).toString();
    nameController.clear();
    selectedRate = null;
  }

  final _formKey = GlobalKey<FormState>();

  final saveFocus = FocusNode();
  void _saveBranch() {
    if (_formKey.currentState!.validate() &&  // Add form validation
        selectedRate != null) {
      BranchMaster branch = BranchMaster(
          name: nameController.text,
          rate: selectedRate!
      );
      branchMasterService.addBranch(branch);
      setState(() {
        branchModelList.add(branch);
        _clearFields();
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (isLoading)? Center(child: CircularProgressIndicator(),):
      Container(
        decoration: BoxDecoration(   gradient: LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
        ),),
        child: Form( // Wrap with Form widget
          key: _formKey,
          child: Column(
            children: [
              // Fixed Header - doesn't expand
              Container(
                margin: EdgeInsets.all(18),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.local_drink, color: Colors.white, size: 28),
                    SizedBox(width: 12),
                    SelectableText(
                      'शाखा नावे भरणे',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.schedule, color: Colors.white, size: 16),
                          SizedBox(width: 8),
                          SelectableText(
                            'दिनांक: ${_currentDate()}',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Main content area - takes remaining space
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(18, 0, 18, 18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Form Section - Fixed height
                      Container(
                        margin: EdgeInsets.all(24),
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFF8FAFC), Color(0xFFEBF4FF), Color(0xFFDBEAFE)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Color(0xFF93C5FD).withOpacity(0.5), width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF1E3A8A).withOpacity(0.08),
                              spreadRadius: 0,
                              blurRadius: 20,
                              offset: Offset(0, 8),
                            ),
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min, // Important: don't expand unnecessarily
                          children: [
                            // Form Title
                            Text(
                              'शाखा तपशील',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E40AF),
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 20),

                            // Form Fields Row
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Branch Code Field
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.qr_code_rounded, size: 16, color: Color(0xFF6B7280)),
                                          SizedBox(width: 6),
                                          Text(
                                            'शाखेचा कोड',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF374151),
                                              letterSpacing: 0.2,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        height: 48,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFF1E3A8A).withOpacity(0.04),
                                              spreadRadius: 0,
                                              blurRadius: 8,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          readOnly: true,

                                          controller: codeController,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'कृपया कोड प्रविष्ट करा';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Color(0xFFF9FAFB),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: BorderSide(color: Color(0xFFD1D5DB), width: 1.5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: BorderSide(color: Color(0xFF2563EB), width: 2.5),
                                            ),
                                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                            suffixIcon: Container(
                                              margin: EdgeInsets.only(right: 8),
                                              child: Icon(Icons.lock_outline, color: Color(0xFF9CA3AF), size: 18),
                                            ),
                                          ),
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF6B7280),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(width: 24),

                                // Branch Name Field
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.business_rounded, size: 16, color: Color(0xFF6B7280)),
                                          SizedBox(width: 6),
                                          Text(
                                            'शाखेचे नाव',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF374151),
                                              letterSpacing: 0.2,
                                            ),
                                          ),
                                          Text(
                                            ' *',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFFDC2626),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        height: 48,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFF1E3A8A).withOpacity(0.04),
                                              spreadRadius: 0,
                                              blurRadius: 8,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),

                                        child:    RawKeyboardListener(
                                          focusNode: _focusNode,
                                          onKey: (event) {
                                            if (event is RawKeyDownEvent &&
                                                event.logicalKey == LogicalKeyboardKey.space) {
                                              // 👇 Custom spacebar behavior
                                              final text = nameController.text;
                                              final selection = nameController.selection;

                                              // Insert a space manually instead of letting IME glitch
                                              final newText = text.replaceRange(
                                                selection.start,
                                                selection.end,
                                                " ",
                                              );

                                              nameController.value = TextEditingValue(
                                                text: newText,
                                                selection: TextSelection.collapsed(offset: selection.start + 1),
                                              );
                                            }
                                          },
                                          child: TextFormField(

                                            controller: nameController,
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'कृपया शाखेचे नाव प्रविष्ट करा';
                                              }
                                              if (value.length < 3) {
                                                return 'शाखेचे नाव किमान ३ अक्षरे असावे';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              hintText: 'शाखेचे नाव प्रविष्ट करा',
                                              hintStyle: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(12),
                                                borderSide: BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(12),
                                                borderSide: BorderSide(color: Color(0xFFD1D5DB), width: 1.5),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(12),
                                                borderSide: BorderSide(color: Color(0xFF2563EB), width: 2.5),
                                              ),
                                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                            ),
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF111827),
                                            ),
                                          ),
                                        )
                                        ,
                                      ),


            ],
                                  ),
                                ),

                                SizedBox(width: 24),

                                // Rate Dropdown Field
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.percent_rounded, size: 16, color: Color(0xFF6B7280)),
                                          SizedBox(width: 6),
                                          Text(
                                            'दर',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF374151),
                                              letterSpacing: 0.2,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        height: 48,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFF1E3A8A).withOpacity(0.04),
                                              spreadRadius: 0,
                                              blurRadius: 8,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: DropdownButtonFormField<String>(
                                          value: selectedRate,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'कृपया दर निवडा';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: BorderSide(color: Color(0xFFD1D5DB), width: 1.5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: BorderSide(color: Color(0xFF2563EB), width: 2.5),
                                            ),
                                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                          ),
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF111827),
                                          ),
                                          dropdownColor: Colors.white,
                                          icon: Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF6B7280)),
                                          items: rateGroupList.map((rate) {
                                            return DropdownMenuItem(
                                              value: rate.name,
                                              child: Text(
                                                rate.name,
                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              selectedRate = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 28),

                            // Action Buttons Row
                            Row(
                              children: [
                                AnimatedSaveButton(focusNode: saveFocus, onPressed: _saveBranch),
                                SizedBox(width: 16),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Color(0xFFF3F4F6), Color(0xFFE5E7EB)],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Color(0xFFD1D5DB), width: 1.5),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: _clearFields,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Row(
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
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Table Section - Takes remaining space
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(24, 0, 24, 24),
                          child: _buildTable(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
            // Fixed Header
            Container(
              decoration: BoxDecoration(
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
                  border: TableBorder(
                    horizontalInside: BorderSide(color: Colors.grey.shade300, width: 0.5),
                    verticalInside: BorderSide(color: Colors.grey.shade300, width: 0.5),
                  ),
                  headingRowColor: WidgetStateProperty.all(Colors.transparent),
                  columns: [
                    DataColumn(
                      label: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        width: 120,
                        child: Text(
                          "Code",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        width: 300,
                        child: Text(
                          "Name",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        width: 120,
                        child: Text(
                          "Rate",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                  rows: [],
                ),
              ),
            ),

            // Scrollable Data Rows - Takes remaining space
            Expanded(
              child: Container(
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
                          columns: [
                            DataColumn(label: SizedBox(width: 120)),
                            DataColumn(label: SizedBox(width: 300)),
                            DataColumn(label: SizedBox(width: 120)),
                          ],
                          rows: List.generate(
                            branchModelList.length,
                                (index) {
                              final entry = branchModelList[index];
                              final isEven = index % 2 == 0;

                              return DataRow(
                                color: WidgetStateProperty.resolveWith<Color?>(
                                      (Set<WidgetState> states) {
                                    if (states.contains(WidgetState.hovered)) {
                                      return Color(0xFF3B82F6).withOpacity(0.1);
                                    }
                                    return isEven ? Colors.white : Color(0xFFF8FAFC);
                                  },
                                ),
                                cells: [
                                  DataCell(
                                    Container(
                                      width: 120,
                                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                                      child: Text(
                                        (index + 1).toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF374151),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      width: 300,
                                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                                      child: Text(
                                        entry.name,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF374151),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      width: 120,
                                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                                      child: Text(
                                        entry.rate,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF374151),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}