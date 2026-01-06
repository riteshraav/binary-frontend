import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ElseDivideBalanceWindow extends StatefulWidget {
  const ElseDivideBalanceWindow({super.key});

  @override
  State<ElseDivideBalanceWindow> createState() => _ElseDivideBalanceWindowState();
}

class _ElseDivideBalanceWindowState extends State<ElseDivideBalanceWindow> {
  // Dates
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  DateTime? selectedRadioDate;

  // Dropdown values
  String? _selectedStandardPercentage;
  String? _selectedRincsba;
  String? _selectedDateOption = 'current_date';
  String? _selectedGift;
  String? _selectedFat;
  String? _selectedClean;

  // Controllers
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  // Checkbox states
  bool isSendChecked = false;
  bool isPremiumChecked = false;
  bool isBodyChecked = false;

  final List<String> _percentageOptions = [
    '८.५%',
    '१०%',
    '१२%',
    '१५%',
    '२०%'
  ];

  final List<String> _rincsbaOptions = [
    'Rincsba sul crawl',
    'Rincsba sul walk',
    'Rincsba sul run',
    'Rincsba sul swim'
  ];

  final List<String> _giftOptions = [
    'GIFT A',
    'GIFT B',
    'GIFT C',
    'GIFT D'
  ];

  final List<String> _fatOptions = [
    'FAT A',
    'FAT B',
    'FAT C',
    'FAT D'
  ];

  final List<String> _cleanOptions = [
    'CLEAN A',
    'CLEAN B',
    'CLEAN C',
    'CLEAN D'
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

  Future<void> _pickRadioDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedRadioDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedRadioDate = picked;
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
                Icons.account_balance_wallet_rounded,
                color: Colors.white,
                size: 26,
              ),
            ),
            const SizedBox(width: 16),
            const Text(
              "शिल्लक वर्ग करणे",
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

  Widget _buildCheckboxWithDropdown(String dropdownLabel, String? dropdownValue, List<String> dropdownItems,
      Function(String?) onDropdownChanged, String checkboxLabel, bool checkboxValue, Function(bool?) onCheckboxChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dropdown
        _buildCompactDropdown(
          dropdownLabel,
          dropdownValue,
          dropdownItems,
          onDropdownChanged,
          hintText: '$dropdownLabel निवडा',
        ),
        const SizedBox(height: 8),

        // Checkbox
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFCCCCCC)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Checkbox(
                value: checkboxValue,
                onChanged: onCheckboxChanged,
                activeColor: const Color(0xFF1E3C72),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
              const SizedBox(width: 8),
              Text(
                checkboxLabel,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E3C72),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'तारीख निवडा',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFF1E3C72),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildRadioOption(
                value: 'current_date',
                label: 'चालू तारीख',
                isSelected: _selectedDateOption == 'current_date',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildRadioOption(
                value: 'radio_date',
                label: 'तारीख निवडा',
                isSelected: _selectedDateOption == 'radio_date',
              ),
            ),
          ],
        ),
        if (_selectedDateOption == 'radio_date') ...[
          const SizedBox(height: 8),
          InkWell(
            onTap: () => _pickRadioDate(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    color: const Color(0xFF1E6BC9),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    selectedRadioDate != null
                        ? DateFormat("dd/MM/yyyy").format(selectedRadioDate!)
                        : "तारीख निवडा",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: selectedRadioDate != null ? Colors.black87 : const Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildRadioOption({
    required String value,
    required String label,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDateOption = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E3C72).withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF1E3C72) : Colors.grey.shade300!,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF1E3C72) : Colors.grey,
                  width: 2,
                ),
                color: isSelected ? const Color(0xFF1E3C72) : Colors.transparent,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: isSelected ? const Color(0xFF1E3C72) : Colors.grey.shade700,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSetrItem(String title, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E3C72).withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF1E3C72).withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E3C72),
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
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
          onPressed: _submitForm,
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

  void _submitForm() {
    if (_selectedStandardPercentage == null || _selectedRincsba == null) {
      _showMessage('कृपया सर्व आवश्यक फील्ड भरा');
      return;
    }

    _showMessage('शिल्लक वर्गीकरण यशस्वीरित्या पूर्ण केले गेले');
  }

  void _resetForm() {
    setState(() {
      _selectedStandardPercentage = null;
      _selectedRincsba = null;
      _selectedDateOption = 'current_date';
      _selectedGift = null;
      _selectedFat = null;
      _selectedClean = null;
      selectedRadioDate = null;
      isSendChecked = false;
      isPremiumChecked = false;
      isBodyChecked = false;
      detailsController.clear();
      commentController.clear();
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF1E3C72),
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
          height: 680, // Increased height to accommodate new fields
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
                      // Date Range Fields
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

                      // Standard Percentage Dropdown
                      _buildCompactDropdown(
                        'मानक टक्केवारी निवडा',
                        _selectedStandardPercentage,
                        _percentageOptions,
                            (value) {
                          setState(() {
                            _selectedStandardPercentage = value;
                          });
                        },
                        hintText: '८.५% टक्केवारी निवडा',
                      ),
                      const SizedBox(height: 12),

                      // Rincsba Dropdown
                      _buildCompactDropdown(
                        'Rincsba प्रकार निवडा',
                        _selectedRincsba,
                        _rincsbaOptions,
                            (value) {
                          setState(() {
                            _selectedRincsba = value;
                          });
                        },
                        hintText: 'Rincsba sul crawl निवडा',
                      ),
                      const SizedBox(height: 12),

                      // GIFT Dropdown with SEND Checkbox
                      _buildCheckboxWithDropdown(
                        'GIFT निवडा',
                        _selectedGift,
                        _giftOptions,
                            (value) {
                          setState(() {
                            _selectedGift = value;
                          });
                        },
                        'SEND',
                        isSendChecked,
                            (value) {
                          setState(() {
                            isSendChecked = value ?? false;
                          });
                        },
                      ),
                      const SizedBox(height: 12),

                      // FAT Dropdown with PREMIUM Checkbox
                      _buildCheckboxWithDropdown(
                        'FAT निवडा',
                        _selectedFat,
                        _fatOptions,
                            (value) {
                          setState(() {
                            _selectedFat = value;
                          });
                        },
                        'PREMIUM',
                        isPremiumChecked,
                            (value) {
                          setState(() {
                            isPremiumChecked = value ?? false;
                          });
                        },
                      ),
                      const SizedBox(height: 12),

                      // CLEAN Dropdown with BODY Checkbox
                      _buildCheckboxWithDropdown(
                        'CLEAN निवडा',
                        _selectedClean,
                        _cleanOptions,
                            (value) {
                          setState(() {
                            _selectedClean = value;
                          });
                        },
                        'BODY',
                        isBodyChecked,
                            (value) {
                          setState(() {
                            isBodyChecked = value ?? false;
                          });
                        },
                      ),
                      const SizedBox(height: 12),

                      // Date Selection Radio
                      _buildDateSelection(),
                      const SizedBox(height: 16),

                      // Details Input
                      _buildCompactInputField(
                        "वर्गीकरण तपशील",
                        detailsController,
                        hintText: "उदा: मासिक शिल्लक वर्गीकरण",
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

                      // SETR Items Section
                      if (_selectedRincsba != null) ...[
                        const Text(
                          'SETR तपशील',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Color(0xFF1E3C72),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildSetrItem('SETR1', '10:00 AM'),
                        _buildSetrItem('SETR2', '11:30 AM'),
                        _buildSetrItem('SETR3', '02:15 PM'),
                        const SizedBox(height: 16),
                      ],

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