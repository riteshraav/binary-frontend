import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'home_window.dart';

class ElsePostingWindow extends StatefulWidget {
  const ElsePostingWindow({super.key});

  @override
  State<ElsePostingWindow> createState() => _ElsePostingWindowState();
}

class _ElsePostingWindowState extends State<ElsePostingWindow>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Dates
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  // Dudh Kharedi specific
  bool isKapatTransferChecked = false;
  final TextEditingController detailsController = TextEditingController();

  // Kapat tab specific - comment/attachment
  final TextEditingController commentController = TextEditingController();

  // kapat fields
  String? selectedYear;
  String? selectedKapat;

  // other small states
  bool isTransferChecked = false;

  // helper: kapat options
  final List<String> _kapatOptions = [
    "कर्ज कपात",
    "साहित्य कपात",
    "इतर कपात",
  ];

  // helper: year options
  final List<String> _yearOptions = [
    "2023-24",
    "2024-25",
    "2025-26",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Set default values
    selectedYear = "2025-26";
    selectedKapat = _kapatOptions.first;
  }

  Future<void> _pickDate(BuildContext context, bool isFrom) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isFrom ? fromDate : toDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E3C72).withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.post_add_rounded,
                color: Colors.white,
                size: 26,
              ),
            ),
            const SizedBox(width: 16),
            const Text(
              "पोस्टिंग करणें",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateField(String label, DateTime date, bool isFrom) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              )),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: InkWell(
            onTap: () => _pickDate(context, isFrom),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blueAccent.shade100, width: 1),
              ),
              child: Text(
                DateFormat("dd/MM/yyyy").format(date),
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPremiumDateField(String label, DateTime date, bool isFrom) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFF1E3C72),
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _pickDate(context, isFrom),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0A000000), // Equivalent to black.withOpacity(0.04)
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: const Color(0xFF1E6BC9), // Using solid color instead of .shade
                  size: 18,
                ),
                const SizedBox(width: 12),
                Text(
                  DateFormat("dd/MM/yyyy").format(date),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPremiumDropdown(String label, String? value, List<String> items, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: Color(0xFF1E3C72),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: const SizedBox.shrink(),
            icon: const Icon(Icons.arrow_drop_down_rounded, color: Color(0xFF1E6BC9)),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            items: items
                .map((item) => DropdownMenuItem(
              value: item,
              child: Text(item),
            ))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildPremiumInputField(String label, TextEditingController controller,
      {String hintText = "", int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFF1E3C72),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000), // Equivalent to black.withOpacity(0.05)
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: InputBorder.none,
              hintStyle: const TextStyle(
                color: Color(0xFF666666),
                fontSize: 14,
              ),
            ),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _actionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.check, color: Colors.white),
          label: const Text("पुष्टी"),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E3C72),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("पुष्टी केले गेले")),
            );
          },
        ),
        const SizedBox(width: 20),
        ElevatedButton.icon(
          icon: const Icon(Icons.stop_circle, color: Colors.white),
          label: const Text("STOP"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade700,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
      ],
    );
  }

  /// The main form used in tabs other than "दूध खरेदी" and "कपात".
  Widget _genericForm({bool showDetails = false}) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _dateField("पासून", fromDate, true),
          const SizedBox(height: 12),
          _dateField("पर्यंत", toDate, false),
          const SizedBox(height: 16),
          if (showDetails) ...[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blueAccent.shade100),
              ),
              child: TextField(
                controller: detailsController,
                maxLines: 1,
                decoration: const InputDecoration(
                  hintText: "उदा: ०१/०४/२०२५",
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 14),
          ],
          Row(
            children: [
              Checkbox(
                value: isTransferChecked,
                onChanged: (v) => setState(() => isTransferChecked = v ?? false),
                activeColor: Colors.blue,
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              ),
              const Text("खात ट्रान्सफर",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 18),
          _actionButtons(),
        ],
      ),
    );
  }

  Widget _buildPremiumTab(String text, IconData icon) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 14,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// The specialized Kapat form - same as Dudh Kharedi but with comment/attachment
  Widget _kapatForm() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPremiumDateField("पासून", fromDate, true),
          const SizedBox(height: 16),
          _buildPremiumDateField("पर्यंत", toDate, false),
          const SizedBox(height: 20),

          // कपात ट्रान्सफर checkbox - Premium style
          // In _kapatForm() method, replace the checkbox container with:
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFCCCCCC)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0A000000), // black.withOpacity(0.04)
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF1E6BC9)),
                  ),
                  child: Theme(
                    data: ThemeData(
                      unselectedWidgetColor: Colors.transparent,
                    ),
                    child: Checkbox(
                      value: isKapatTransferChecked,
                      onChanged: (v) => setState(() => isKapatTransferChecked = v ?? false),
                      activeColor: const Color(0xFF1E3C72),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  "कपात ट्रान्सफर",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E3C72),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Show Year & Kapat if checked
          if (isKapatTransferChecked) ...[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      // वर्ष (year) dropdown
                      Expanded(
                        child: _buildPremiumDropdown(
                          "वर्ष निवडा",
                          selectedYear,
                          _yearOptions,
                              (v) {
                            if (v != null) setState(() => selectedYear = v);
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      // कपात (Kapat) dropdown
                      Expanded(
                        child: _buildPremiumDropdown(
                          "कपात निवडा",
                          selectedKapat,
                          _kapatOptions,
                              (v) {
                            if (v != null) setState(() => selectedKapat = v);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Posting details input
          _buildPremiumInputField(
            "पोस्टिंग नावीन्य",
            detailsController,
            hintText: "उदा: ०१/०४/२०२५ किंवा इतर तपशील",
          ),
          const SizedBox(height: 16),

          // Additional Comment/Attachment field (only in Kapat tab)
          _buildPremiumInputField(
            "टिप्पणी किंवा अटीचेमेंट",
            commentController,
            hintText: "इथे टिप्पणी किंवा अटीचेमेंट तपशील प्रविष्ट करा...",
            maxLines: 2,
          ),
          const SizedBox(height: 24),

          _actionButtons(),
        ],
      ),
    );
  }

  /// The specialized Dudhh Kharedi form
  Widget _dudhKharediForm() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _dateField("पासून", fromDate, true),
          const SizedBox(height: 12),
          _dateField("पर्यंत", toDate, false),
          const SizedBox(height: 14),

          // कपात ट्रान्सफर checkbox
          Row(
            children: [
              Checkbox(
                value: isKapatTransferChecked,
                onChanged: (v) =>
                    setState(() => isKapatTransferChecked = v ?? false),
              ),
              const SizedBox(width: 6),
              const Text("कपात ट्रान्सफर",
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 10),

          // Show Year & Kapat if checked
          if (isKapatTransferChecked) ...[
            Row(
              children: [
                // वर्ष (year) dropdown
                SizedBox(
                  width: 140,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('वर्ष निवडा', style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blueAccent.shade100),
                        ),
                        child: DropdownButton<String>(
                          value: selectedYear,
                          isExpanded: true,
                          underline: const SizedBox.shrink(),
                          items: _yearOptions
                              .map((year) => DropdownMenuItem(
                            value: year,
                            child: Text(year),
                          ))
                              .toList(),
                          onChanged: (v) {
                            if (v != null) setState(() => selectedYear = v);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                // कपात (Kapat) dropdown
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('कपात निवडा', style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blueAccent.shade100),
                        ),
                        child: DropdownButton<String>(
                          value: selectedKapat,
                          isExpanded: true,
                          underline: const SizedBox.shrink(),
                          items: _kapatOptions
                              .map((k) => DropdownMenuItem(
                            value: k,
                            child: Text(k),
                          ))
                              .toList(),
                          onChanged: (v) {
                            if (v != null) setState(() => selectedKapat = v);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],

          // Posting details input


          _actionButtons(),
        ],
      ),
    );
  }


  @override
  void dispose() {
    _tabController.dispose();
    detailsController.dispose();
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double baseWidth = 720;
    final double baseHeight = 520;

    return Scaffold(
      backgroundColor: const Color(0xFFE9F0FB),
      body: Center(
        child: Container(
          width: baseWidth,
          height: baseHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(2, 3),
              )
            ],
          ),
          child: Column(
            children: [
              _buildHeader(),
              // Tab bar area with subtle background
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.06),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 12,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Gradient border bottom
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 2,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TabBar(
                          controller: _tabController,
                          labelColor: const Color(0xFF1E3C72), // Dark blue text for selected
                          unselectedLabelColor: Colors.grey.shade600,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xFF1E3C72).withOpacity(0.1), // Light blue background
                            border: Border.all(
                              color: const Color(0xFF1E3C72),
                              width: 1.5,
                            ),
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorPadding: const EdgeInsets.all(2),
                          labelStyle: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                          unselectedLabelStyle: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.3,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          tabs: [
                            _buildPremiumTab("दूध खरेदी", Icons.inventory_2_outlined),
                            _buildPremiumTab("कपात", Icons.assignment_outlined),
                            _buildPremiumTab("किरकोळ", Icons.store_mall_directory_outlined),
                            _buildPremiumTab("दूध विक्री", Icons.local_shipping_outlined),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Body: use Expanded with TabBarView
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.04),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // 1) दूध खरेदी
                      SingleChildScrollView(
                        child: _dudhKharediForm(),
                      ),

                      // 2) कपात - same as Dudh Kharedi but with comment/attachment
                      SingleChildScrollView(
                        child: _kapatForm(),
                      ),

                      // 3) किरकोळ दूध विक्री — generic
                      SingleChildScrollView(
                        child: _genericForm(),
                      ),

                      // 4) दूध विक्री — generic
                      SingleChildScrollView(
                        child: _genericForm(),
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
}

