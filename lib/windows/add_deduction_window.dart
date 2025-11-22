import 'package:flutter/material.dart';
import 'package:windows_sample/model/deduction.dart';
import 'package:windows_sample/riverpod/providers.dart';
import 'package:windows_sample/service/deduction_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class AddDeductionWindow extends ConsumerStatefulWidget {
  const AddDeductionWindow({Key? key}) : super(key: key);

  @override
  ConsumerState<AddDeductionWindow> createState() => _AddDeductionWindowState();
}

class _AddDeductionWindowState extends ConsumerState<AddDeductionWindow> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  String? selectedType = 'कपात';
  String? selectedShape;
  bool isGalLiter = false;
  bool isRounded = false;
  bool isMilkat = false;
  bool isKapatLock = false;
  bool isLoading = true;
 late DeductionServiceImpl deductionService;
  List<Deduction> deductionList = [];
  List<Map<String, dynamic>> customerList = [
    {'no': '११', 'name': 'पु.गजानन', 'type': 'कृपान', 'shape': '', 'rate': '०', 'rounded': '०', 'millikan': '०', 'priority': '११'},
    {'no': '१२', 'name': 'अड्डाल्मे', 'type': 'कृपान', 'shape': '', 'rate': '०', 'rounded': '०', 'millikan': '०', 'priority': '१२'},
    {'no': '१३', 'name': 'किडीट दुध पिको', 'type': 'कृपान', 'shape': 'कृपान', 'rate': '०', 'rounded': '०', 'millikan': '०', 'priority': '१७'},
    {'no': '१४', 'name': 'शेगदण्ड टेव', 'type': 'कृपान', 'shape': 'कृपान', 'rate': '०', 'rounded': '०', 'millikan': '०', 'priority': '१४'},
    {'no': '१५', 'name': 'इत्तर येणे', 'type': 'कृपान', 'shape': '', 'rate': '०', 'rounded': '०', 'millikan': '०', 'priority': '१३'},
  ];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
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
  Future<void> _loadData()async{
    deductionService = ref.read(deductionProvider);
    deductionList =await deductionService.fetchAllDeductions();
  }
  @override
  void dispose() {
    nameController.dispose();
    rateController.dispose();
    priorityController.dispose();
    super.dispose();
  }

  void _saveDeduction() {
    if (_formKey.currentState!.validate()) {
      print('selevtedd  type is $selectedType');
      if(selectedType != 'स्थिर कपात')
        {
          print('selected aakarni is $selectedShape');
          selectedShape = 'none';
        }
      else{
        if(selectedShape == null)
          {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('आकाराणी प्रकार निवडा')),
            );
            return;
          }
      }
      print('selected aakarni is $selectedShape');
      final deduction = Deduction(        adminId: '1', name: nameController.text, code: codeController.text, vasuliType: selectedType!, aakarani: selectedShape!, rate: double.parse(rateController.text), priority: int.parse(priorityController.text), rounding: isRounded, milkat: isMilkat, kapatLock: true);
      deductionService.createDeduction(deduction);
      deductionList.add(deduction);
      setState(() {

      });
      _clearFields();
      // Add save logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('कपात सेव्ह झाला!')),
      );
    }
  }
  void _clearFields() {
    codeController.clear();
    nameController.clear();
    rateController.clear();
    priorityController.clear();
    setState(() {
      selectedType = 'कपात';
      selectedShape = null;
      isGalLiter = false;
      isRounded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Header
              Container(
                width: double.infinity,
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
                child: Text(
                  'कपातीचे नाव भरणे',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              // Main content
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
                      // Form Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Row(
                          children: [
                            // Type Selection Row
                            _buildTypeSelection(),
                            SizedBox(height: 10),
                            // // Name Field Row
                            Expanded(child: _buildNameField()),
                            SizedBox(height: 5),
                          ],
                        ),
                        Row(
                          children: [
                            // // Shape Selection Row
                            _buildShapeSelection(),
                            SizedBox(height: 5),
                            //
                            // // Rate and Checkboxes Row
                            Expanded(child: _buildRateAndOptions()),
                            SizedBox(height: 28),
                          ],
                        ),
                          // // Action Buttons
                          _buildActionButtons(),
                          SizedBox(height: 20,)
                        ],
                      ),

                      // Table Section
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

  Widget _buildTypeSelection() {
    return Container(
      width: 400,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(38),
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
          ],
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'वसुली प्रकार',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF374151),
            ),
          ),
          Row(
            children: [
              _buildRadio('कपात', 'कपात'),
              SizedBox(width: 16),
              _buildRadio('स्थिर कपात', 'स्थिर कपात'),
              SizedBox(width: 16),
              _buildRadio('मिळकत', 'मिळकत'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRadio(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          groupValue: selectedType,
          onChanged: (val) => setState(() => selectedType = val),
          activeColor: Color(0xFF2563EB),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 13, color: Color(0xFF374151)),
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return Container(

        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(14),
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
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'कपातीचे नाव',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
              ),
            ),
           SizedBox(height: 10,),
           Row(
             children: [
               Container(
                 width: 100 ,
                 height: 70,
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
                   controller: codeController,
                   validator: (value) {
                     if (value == null || value.isEmpty) {
                       return 'कोड लिहा';
                     }
                     return null;
                   },
                   decoration: InputDecoration(
                     filled: true,
                     fillColor: Colors.white,
                     hintText: 'कोड',
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
               ),
               SizedBox(width: 10,),
               Expanded(
                 child: Container(
                   height: 70,
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
                     controller: nameController,
                     validator: (value) {
                       if (value == null || value.isEmpty) {
                         return 'कृपया नाव प्रविष्ट करा';
                       }
                       return null;
                     },
                     decoration: InputDecoration(
                       filled: true,
                       fillColor: Colors.white,
                       hintText: 'कपातीचे नाव प्रविष्ट करा',
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
                 ),
               )
             ],
           ),
          ],
        ),
    );
  }

  Widget _buildShapeSelection() {
    return Container(
      width: 400,
        margin: EdgeInsets.all(5),
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
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'कपात आकाराणी',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
              ),
            ),
            SizedBox(height: 16),

            Row(
              children: [
                _buildShapeRadio('प्रति लिटर', 'प्रति लिटर'),
                SizedBox(width: 16),
                _buildShapeRadio('टक्केवारी', 'टक्केवारी'),
                SizedBox(width: 16),
                _buildShapeRadio('प्रति मेंबर', 'प्रति मेंबर'),
              ],
            ),
          ],
        )
    ) ;
  }

  Widget _buildShapeRadio(String label, String value) {
    bool isAvailable = selectedType == 'स्थिर कपात';

    return Opacity(
      opacity: isAvailable ? 1.0 : 0.5, // visually show it's disabled
      child: IgnorePointer(               // prevent user interaction when disabled
        ignoring: !isAvailable,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<String>(
              value: value,
              groupValue: selectedShape,
              onChanged: (val) {
                setState(() => selectedShape = val);
              },
              activeColor: const Color(0xFF2563EB),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF374151),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildRateAndOptions() {
    return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(20),
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
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rate Field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'कपातीचा दर',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF374151),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: 150,
                  height: 48,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'कपातीचा दर लिहा';
                      }
                      return null;
                    },
                    controller: rateController,
                    keyboardType: TextInputType.number,
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
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'कपात प्रधान्यता',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF374151),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: 150,
                  height: 48,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'कपात प्रधान्यता लिहा';
                      }
                      return null;
                    },
                    controller: priorityController,
                    keyboardType: TextInputType.number,
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
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            SizedBox(width: 20),

            // Checkboxes
            Column(
              children: [
                SizedBox(height: 25,),
                Row(
                  children: [
                    _buildSelectableButton('राउंडींग', isRounded, (val) => setState(() => isRounded = val)),
                  ],
                ),
              ],
            ),
            SizedBox(width: 20),


          ],
        )
    );
  }

  Widget _buildSelectableButton(String label, bool isSelected, Function(bool) onChanged) {
    return InkWell(
      onTap: () => onChanged(!isSelected),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2563EB).withOpacity(0.12) : Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF2563EB) : const Color(0xFFD1D5DB),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            if (isSelected)
              const BoxShadow(
                color: Color(0x332563EB),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF2563EB) : Colors.transparent,
                border: Border.all(
                  color: isSelected ? const Color(0xFF2563EB) : const Color(0xFF9CA3AF),
                  width: 1.8,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight:isSelected ?  FontWeight.w700: FontWeight.w500,
                color: isSelected ?  Colors.white : const Color(0xFF374151),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Save Button (Monitor Icon)
        _buildButton(Icons.save, _saveDeduction, Colors.blue,'Save'),
        SizedBox(width: 16),

        // Refresh Button
        _buildButton(Icons.refresh, _clearFields, Colors.grey,'refresh'),
        SizedBox(width: 16),

        // Edit Button (Pencil)
        _buildButton(Icons.edit, () {}, Colors.orange,'Edit'),
        SizedBox(width: 16),

        // Stop Button
        _buildButton(Icons.stop_circle, () {}, Colors.red,'Stop'),
      ],
    );
  }

  Widget _buildButton(
      IconData icon,
      VoidCallback onPressed,
      Color color,
      String title,
      ) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isPressed = false;
        bool isHovered = false;

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: GestureDetector(
            onTapDown: (_) => setState(() => isPressed = true),
            onTapUp: (_) {
              setState(() => isPressed = false);
              onPressed();
            },
            onTapCancel: () => setState(() => isPressed = false),
            child: AnimatedScale(
              scale: isPressed ? 0.92 : (isHovered ? 1.05 : 1.0),
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.withOpacity(isHovered ? 1.0 : 0.9),
                      color.withOpacity(isHovered ? 0.85 : 0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(isPressed ? 0.5 : (isHovered ? 0.45 : 0.3)),
                      blurRadius: isPressed ? 15 : (isHovered ? 14 : 8),
                      offset: Offset(0, isPressed ? 2 : (isHovered ? 5 : 3)),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedRotation(
                        turns: isPressed ? 0.05 : 0,
                        duration: const Duration(milliseconds: 150),
                        child: Icon(icon, size: 16, color: Colors.white),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: isHovered ? 13.5 : 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
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
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 12,
                  headingRowHeight: 50,
                  dataRowMinHeight: 0,
                  dataRowMaxHeight: 0,
                  headingRowColor: WidgetStateProperty.all(Colors.transparent),
                  columns: [
                    _buildHeaderColumn('नोंद  नं', 80),
                    _buildHeaderColumn('कपातीचे  नाव', 150),
                    _buildHeaderColumn('वसुली प्रकार', 120),
                    _buildHeaderColumn('आकाराणी', 100),
                    _buildHeaderColumn('क. दर', 80),
                    _buildHeaderColumn('प्राधाम्यता', 100),
                  ],
                  rows: [],
                ),
              ),
            ),

            // Scrollable Data
            Expanded(
              child: Container(
                color: Colors.white,
                child: Scrollbar(
                  thumbVisibility: true,
                  trackVisibility: true,
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 12,
                        headingRowHeight: 0,
                        dataRowMinHeight: 45,
                        dataRowMaxHeight: 45,
                        border: TableBorder(
                          horizontalInside: BorderSide(color: Colors.grey.shade300, width: 0.5),
                          verticalInside: BorderSide(color: Colors.grey.shade300, width: 0.5),
                        ),
                        columns: [
                          DataColumn(label: SizedBox(width: 80)),
                          DataColumn(label: SizedBox(width: 150)),
                          DataColumn(label: SizedBox(width: 120)),
                          DataColumn(label: SizedBox(width: 100)),
                          DataColumn(label: SizedBox(width: 80)),
                          DataColumn(label: SizedBox(width: 100)),
                        ],
                        rows: deductionList.reversed.map((deduction) {
                          final index = deductionList.reversed.toList().indexOf(deduction);
                          final isEven = index % 2 == 0;

                          return DataRow(
                            color: WidgetStateProperty.resolveWith<Color?>(
                                  (Set<WidgetState> states) {
                                if (states.contains(WidgetState.hovered)) {
                                  return Color(0xFF3B82F6).withOpacity(0.1);
                                }
                                return isEven ? Color(0xFFFFF8DC) : Color(0xFFFFE4B5);
                              },
                            ),
                            cells: [
                              _buildDataCell(deduction.code, 80),
                              _buildDataCell(deduction.name, 150),
                              _buildDataCell(deduction.vasuliType, 120),
                              _buildDataCell(deduction.aakarani, 100),
                              _buildDataCell(deduction.rate.toStringAsFixed(2), 80),
                              _buildDataCell(deduction.priority.toString(), 100),
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
        ),
      ),
    );
  }

  DataColumn _buildHeaderColumn(String label, double width) {
    return DataColumn(
      label: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  DataCell _buildDataCell(String text, double width) {
    return DataCell(
      Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151),
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}