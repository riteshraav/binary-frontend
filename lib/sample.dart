import 'package:flutter/material.dart';
import 'package:windows_sample/model/rate_model.dart';

import '../model/branch_model.dart';
import '../widget/animated_button_widget.dart';



class BranchMasterWindow extends StatefulWidget {
  @override
  _BranchMasterWindowState createState() => _BranchMasterWindowState();
}

class _BranchMasterWindowState extends State<BranchMasterWindow> {
  final TextEditingController codeController = TextEditingController();

  final TextEditingController nameController = TextEditingController();
  bool isVillageSelected = true;
  bool isPrintChecked = false;
  String selectedShift = 'सकाळ';
  List<BranchMaster> branchModelList = [

    BranchMaster( name: "मुख्य शाखा",rate: 'दर क्र १'),
    BranchMaster(name: "शाखा क्र २",rate: 'दर क्र २'),
    BranchMaster(name: "शाखा क्र ३",rate: 'दर क्र ३')];

  List<RateModel> rateModelList = [RateModel(name:'दर क्र १'),RateModel(name:'दर क्र २'),RateModel(name:'दर क्र ३')];
  String? selectedRate; // Add this field for dropdown
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    codeController.text = (branchModelList.length + 1 ).toString();
  }
  void _clearFields() {
    codeController.text = (branchModelList.length + 1 ).toString();
    nameController.clear();
    selectedRate = null;


  }

  void _saveBranch() {
    if (codeController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        selectedRate != null) {
      setState(() {
        branchModelList.add(BranchMaster(
            name: nameController.text,
            rate: selectedRate!
        ));

        _clearFields();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Colors.blue[50]
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              // Modern Header
              Container(
                width: double.infinity,
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
                            'दिनांक: १४.०८.२०२५',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(16),
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
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Top Section - Member Selection
                              Container(
                                margin: EdgeInsets.all(16),
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
                                  children: [
                                    // Form Title
                                    Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Text(
                                        'शाखा तपशील',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1E40AF),
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),

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
                                              Container(
                                                margin: EdgeInsets.only(bottom: 8),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.qr_code_rounded,
                                                      size: 16,
                                                      color: Color(0xFF6B7280),
                                                    ),
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
                                              ),
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
                                                child: TextField(
                                                  readOnly: true,
                                                  controller: codeController,
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
                                                      child: Icon(
                                                        Icons.lock_outline,
                                                        color: Color(0xFF9CA3AF),
                                                        size: 18,
                                                      ),
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
                                              Container(
                                                margin: EdgeInsets.only(bottom: 8),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.business_rounded,
                                                      size: 16,
                                                      color: Color(0xFF6B7280),
                                                    ),
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
                                              ),
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
                                                child: TextField(
                                                  controller: nameController,
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    hintText: 'शाखेचे नाव प्रविष्ट करा',
                                                    hintStyle: TextStyle(
                                                      color: Color(0xFF9CA3AF),
                                                      fontSize: 14,
                                                    ),
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
                                              Container(
                                                margin: EdgeInsets.only(bottom: 8),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.percent_rounded,
                                                      size: 16,
                                                      color: Color(0xFF6B7280),
                                                    ),
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
                                              ),
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
                                                  icon: Icon(
                                                    Icons.keyboard_arrow_down_rounded,
                                                    color: Color(0xFF6B7280),
                                                  ),
                                                  items: rateModelList.map((rate) {
                                                    return DropdownMenuItem(
                                                      value: rate.name,
                                                      child: Text(
                                                        rate.name,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500,
                                                        ),
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
                                        // Save Button
                                        AnimatedSaveButton(
                                          onPressed: _saveBranch,
                                        ),
                                        SizedBox(width: 16),

                                        // Clear Button
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
                                                Icon(
                                                  Icons.clear_rounded,
                                                  size: 18,
                                                  color: Color(0xFF6B7280),
                                                ),
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
                              SizedBox(height: 24),

                              // // Data Table
                              // Expanded(
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       borderRadius: BorderRadius.circular(12),
                              //       border: Border.all(color: Color(0xFFE5E7EB)),
                              //       boxShadow: [
                              //         BoxShadow(
                              //           color: Colors.black,
                              //           blurRadius: 4,
                              //           offset: Offset(0, 2),
                              //         ),
                              //       ],
                              //     ),
                              //     child: Column(
                              //       children: [
                              //         Container(
                              //           height: 50,
                              //           decoration: BoxDecoration(
                              //             gradient: LinearGradient(
                              //               colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
                              //             ),
                              //             borderRadius: BorderRadius.only(
                              //               topLeft: Radius.circular(12),
                              //               topRight: Radius.circular(12),
                              //             ),
                              //           ),
                              //           child: Row(
                              //             children: [
                              //               _buildTableHeader('कोड'),
                              //               _buildTableHeader('उत्पादकाचे नाव'),
                              //               _buildTableHeader('दर'),
                              //             ],
                              //           ),
                              //         ),
                              //         Expanded(
                              //           child: SingleChildScrollView(
                              //             child: Column(
                              //               children: [
                              //                 // Table content
                              //                 ...branchModelList.map((branch) => Container(
                              //                   decoration: BoxDecoration(
                              //                     border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
                              //                   ),
                              //                   child: Row(
                              //                     children: [
                              //                       Expanded(
                              //                         child: Padding(
                              //                           padding: EdgeInsets.all(8),
                              //                           child: Text((branchModelList.indexOf(branch) + 1).toString()),
                              //                         ),
                              //                       ),
                              //                       Expanded(
                              //                         child: Padding(
                              //                           padding: EdgeInsets.all(8),
                              //                           child: Text(branch.name),
                              //                         ),
                              //                       ),
                              //                       Expanded(
                              //                         child: Padding(
                              //                           padding: EdgeInsets.all(8),
                              //                           child: Text(branch.rate),
                              //                         ),
                              //                       ),
                              //                     ],
                              //                   ),
                              //                 )).toList(),
                              //               ],
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              _buildTable()
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, IconData icon) {
    return SelectionArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(label, style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w500)),
          SizedBox(height: 4),
          Container(
            width: 100,
            height: 45,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(icon, size: 18, color: Color(0xFF6B7280)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xFFD1D5DB)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xFF2563EB), width: 2),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, IconData icon, Color color) {
    return Container(
      height: 45,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon, size: 18),
        label: SelectableText(text, style: TextStyle(fontWeight: FontWeight.w600)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
        ),
      ),
    );
  }
  // Widget _buildTable(){
  //  return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: DataTable(
  //         columnSpacing: 8,
  //         headingRowHeight: 45,
  //         border: TableBorder.all(),
  //         headingRowColor: WidgetStateProperty.all(Color(0xFF24A1DE)),
  //         columns: [
  //           DataColumn(label: Text("Code",style: TextStyle(color: Colors.white),)),
  //           DataColumn(label: Text("Name",style: TextStyle(color: Colors.white),)),
  //           DataColumn(label: Text("Rate",style: TextStyle(color: Colors.white),)),
  //         ],
  //         rows: List.generate(
  //           branchModelList.length,
  //               (index) {
  //             final entry = branchModelList[index];
  //             return DataRow(
  //               color: WidgetStateProperty.resolveWith<Color?>(
  //                     (Set<WidgetState> states) {
  //                   return Colors.white; // white background
  //                 },
  //               ),
  //               cells: [
  //                 DataCell(Text(entry.code.toString())),
  //                 DataCell(Text(entry.name)),
  //                 DataCell(Text(entry.rate)),
  //
  //               ],
  //
  //             );
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  //
  // }
  Widget _buildTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.all(8.0),
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
          child: DataTable(
            columnSpacing: 16,
            headingRowHeight: 50,
            dataRowMinHeight: 48,
            dataRowMaxHeight: 48,
            border: TableBorder.all(
              color: Colors.grey.shade300,
              width: 0.5,
            ),
            headingRowColor: WidgetStateProperty.all(Colors.transparent),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            columns: [
              DataColumn(
                label: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "Code",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              DataColumn(
                label: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "Name",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              DataColumn(
                label: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "Rate",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
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
                      return isEven
                          ? Colors.white
                          : Color(0xFFF8FAFC); // Alternating row colors
                    },
                  ),
                  cells: [
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        child: Text(
                          entry.code.toString(),
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
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        child: Text(
                          entry.name,
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
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),

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
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

}