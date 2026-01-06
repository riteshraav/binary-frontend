import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ElseFeedWindow extends StatefulWidget {
  const ElseFeedWindow({super.key});

  @override
  State<ElseFeedWindow> createState() => _ElseFeedWindowState();
}

class _ElseFeedWindowState extends State<ElseFeedWindow> {
  // Dates
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  // Controllers
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  final TextEditingController groupController = TextEditingController();
  final TextEditingController debtController = TextEditingController();

  // States
  bool isFeedTransferChecked = false;
  bool isBlueEntryChecked = false;
  bool isAppliedChecked = false;

  // Dropdown values
  String? selectedGroup;
  String? selectedDebt;

  final List<String> groupOptions = [
    '३/०/० जमा',
    '४/०/० जमा',
    '५/०/० जमा',
    '६/०/० जमा'
  ];

  final List<String> debtOptions = [
    '३/०/० जमा',
    '४/०/० जमा',
    '५/०/० जमा',
    '६/०/० जमा'
  ];

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
                Icons.pets_rounded,
                color: Colors.white,
                size: 26,
              ),
            ),
            const SizedBox(width: 16),
            const Text(
              "पशुखाद्य पोस्टींग",
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

  Widget _buildCompactDateField(String label, DateTime date, bool isFrom) {
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
        const SizedBox(height: 6),
        InkWell(
          onTap: () => _pickDate(context, isFrom),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: const Color(0xFF1E6BC9),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  DateFormat("dd/MM/yyyy").format(date),
                  style: const TextStyle(
                    fontSize: 14,
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

  Widget _buildCompactDropdown(String label, String? value, List<String> items, Function(String?) onChanged, {String? hintText}) {
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
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: const SizedBox.shrink(),
            icon: const Icon(Icons.arrow_drop_down_rounded, color: Color(0xFF1E6BC9), size: 20),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            hint: hintText != null ? Text(
              hintText,
              style: const TextStyle(
                color: Color(0xFF666666),
                fontSize: 13,
              ),
            ) : null,
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

  Widget _buildCompactInputField(String label, TextEditingController controller,
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
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: InputBorder.none,
              hintStyle: const TextStyle(
                color: Color(0xFF666666),
                fontSize: 13,
              ),
            ),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckboxOption(String label, bool value, Function(bool?) onChanged) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFCCCCCC)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF1E3C72),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E3C72),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.check, color: Colors.white, size: 18),
          label: const Text("पुष्टी", style: TextStyle(fontSize: 14)),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E3C72),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("पुष्टी केले गेले")),
            );
          },
        ),
        const SizedBox(width: 16),
        ElevatedButton.icon(
          icon: const Icon(Icons.stop_circle, color: Colors.white, size: 18),
          label: const Text("STOP", style: TextStyle(fontSize: 14)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade700,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _buildFeedTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1E3C72).withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'खाते',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Color(0xFF1E3C72),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'तारीख',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Color(0xFF1E3C72),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'तपशील',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Color(0xFF1E3C72),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'रक्कम',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Color(0xFF1E3C72),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Table Rows
          _buildTableRow(
            account: 'बचत खाते',
            date: '०९/१०/२०२४',
            description: 'मासिक बचत',
            amount: '५,००० ₹',
          ),
          _buildTableRow(
            account: 'चालू खाते',
            date: '०९/१०/२०२४',
            description: 'दैनंदिन खर्च',
            amount: '२,५०० ₹',
          ),
          _buildTableRow(
            account: 'फिक्स्ड खाते',
            date: '०९/१०/२०२४',
            description: 'मुदत ठेव',
            amount: '१०,००० ₹',
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow({
    required String account,
    required String date,
    required String description,
    required String amount,
    bool isLast = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: isLast ? null : Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                account,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                date,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                amount,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9F0FB),
      body: Center(
        child: Container(
          width: 600,
          height: 620, // Increased height to accommodate new fields
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
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),

              // Main Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date Fields
                      Row(
                        children: [
                          Expanded(
                            child: _buildCompactDateField("पासून", fromDate, true),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildCompactDateField("पर्यंत", toDate, false),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Group Dropdown (หมู่ที่)
                      _buildCompactDropdown(
                        'गट निवडा',
                        selectedGroup,
                        groupOptions,
                            (value) {
                          setState(() {
                            selectedGroup = value;
                          });
                        },
                        hintText: '३/०/० जमा निवडा',
                      ),
                      const SizedBox(height: 12),

                      // Blue Entry Checkbox (ฟ้าเข้า)
                      _buildCheckboxOption(
                        'निळी नोंदणी केली',
                        isBlueEntryChecked,
                            (value) {
                          setState(() {
                            isBlueEntryChecked = value ?? false;
                          });
                        },
                      ),
                      const SizedBox(height: 12),

                      // Debt Dropdown (หนี้)
                      _buildCompactDropdown(
                        'कर्ज निवडा',
                        selectedDebt,
                        debtOptions,
                            (value) {
                          setState(() {
                            selectedDebt = value;
                          });
                        },
                        hintText: '३/०/० जमा निवडा',
                      ),
                      const SizedBox(height: 12),

                      // Applied Checkbox (ประยุกต์)
                      _buildCheckboxOption(
                        'लागू केले',
                        isAppliedChecked,
                            (value) {
                          setState(() {
                            isAppliedChecked = value ?? false;
                          });
                        },
                      ),
                      const SizedBox(height: 12),

                      // Feed Transfer Checkbox
                      _buildCheckboxOption(
                        "खाद्य ट्रान्सफर",
                        isFeedTransferChecked,
                            (value) {
                          setState(() => isFeedTransferChecked = value ?? false);
                        },
                      ),
                      const SizedBox(height: 16),

                      // Details Input
                      _buildCompactInputField(
                        "पोस्टिंग नावीन्य",
                        detailsController,
                        hintText: "उदा: पशुखाद्य खरेदी तपशील",
                      ),
                      const SizedBox(height: 12),

                      // Comment/Attachment
                      _buildCompactInputField(
                        "टिप्पणी किंवा अटीचेमेंट",
                        commentController,
                        hintText: "इथे टिप्पणी किंवा अटीचेमेंट तपशील प्रविष्ट करा...",
                        maxLines: 2,
                      ),
                      const SizedBox(height: 16),

                      // Table
                      const Text(
                        "आधीच्या पोस्टिंग",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xFF1E3C72),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: _buildFeedTable(),
                      ),
                      const SizedBox(height: 16),

                      // Action Buttons
                      _actionButtons(),
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