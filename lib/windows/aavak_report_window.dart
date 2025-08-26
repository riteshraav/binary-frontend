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

class AavakReportWindow extends ConsumerStatefulWidget {
  @override
  _AavakReportWindowState createState() => _AavakReportWindowState();
}

class _AavakReportWindowState extends ConsumerState<AavakReportWindow> {
  List<BranchMaster> branchList = [];
  bool isLoading = true;
  String milkType = 'मिश्र';
  String branchSelection = "सर्व";
  final saveFocusNode = FocusNode();
  BranchMaster? selectedBranch;
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
      final branchService = ref.read(branchMasterServiceProvider);
      branchList =await branchService.getAllBranches();
      setState(() {

      });
  }

  void _clearFields() {

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
          _buildMilkTypeSelection(),
          SizedBox(height: 16),
          _buildBranchSection(),
        ],
      ),
    );
  }

  Widget _buildMilkTypeSelection() {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(24),
      width: 400,
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
          _buildMilkTypeSwitch()
        ],
      ),
    );
  }
  Widget _buildBranchSection() {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(24),
      width: 400,
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
          _buildBranchSwitch()
        ],
      ),
    );
  }


  Widget _buildActionButtons() {
    return Row(
      children: [
        AnimatedSaveButton(
           onPressed: (){}, focusNode: saveFocusNode,

    )]);
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



  Widget _buildMilkTypeSwitch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'दुधाचे प्रकार',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 3),
        Container(
          height: 32,
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
              _buildSwitchButton('मिश्र', 'mixed', milkType == 'mixed', (value) {
                setState(() => milkType = 'mixed');
              }),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildBranchSwitch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'शाखा निवडा',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 3),
        Container(
          height: 32,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFD1D5DB)),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              _buildSwitchButton('सर्व', 'सर्व', branchSelection == 'सर्व', (value) {
                setState(() => branchSelection = 'सर्व');
              }),
              _buildBranchDropDown( branchSelection == 'ठरविक शाखेनुसार')


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
              fontSize:20,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : const Color(0xFF374151),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildBranchDropDown( bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTapDown: (details) {
          _showContextMenu(context, details.globalPosition);
        },
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF2563EB) : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
              selectedBranch == null? 'ठरविक शाखेनुसार':selectedBranch!.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize:20,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : const Color(0xFF374151),
            ),
          ),
        ),
      ),
    );
  }
  void _showContextMenu(
      BuildContext context, Offset position)
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
       ...branchList.map((branch)=> PopupMenuItem(
         onTap: (){
           selectedBranch = branch;
           branchSelection ="ठरविक शाखेनुसार";

           setState(() {

           });
         },
         child: Text(branch.name),
       ))
      ],
    );
  }


  @override
  void dispose() {

    super.dispose();
  }
}