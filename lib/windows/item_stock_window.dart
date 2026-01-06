import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'home_window.dart';

class ItemStockWindow extends StatefulWidget {
  const ItemStockWindow({super.key});

  @override
  State<ItemStockWindow> createState() => _ItemStockWindowState();
}

class _ItemStockWindowState extends State<ItemStockWindow> {
  String selectedReport = "खरेदी रजिस्टर";
  String selectedItem = "महालक्ष्मी पशुखाद्य ";
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  Future<void> _pickFromDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: fromDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => fromDate = picked);
  }

  Future<void> _pickToDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: toDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => toDate = picked);
  }

  Widget _radio(String label) {
    return RadioListTile<String>(
      value: label,
      groupValue: selectedReport,
      title: Text(label, style: const TextStyle(fontSize: 14)),
      dense: true,
      contentPadding: EdgeInsets.zero,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      onChanged: (val) {
        if (val != null) setState(() => selectedReport = val);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
          ),
        ),
        child: Center(
          child: Container(
            width: 1050,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                // Blue Header
                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(10),
                  shadowColor: Colors.black45,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.inventory, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text(
                          "स्टॉक",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Scrollable body
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Radios + Dropdown
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFF9FAFB), Color(0xFFF3F4F6)],
                            ),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0xFFD1D5DB), width: 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.article, color: Color(0xFF374151), size: 16),
                                  SizedBox(width: 6),
                                  Text(
                                    'अहवाल पर्याय',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF111827),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Left column
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _radio("खरेदी रजिस्टर"),
                                        _radio("खरेदी रजिस्टर - वॅट सह"),
                                        const SizedBox(height: 20),
                                        _radio("स्टॉक स्टेटमेंट"),
                                        _radio("स्टॉक स्टेटमेंट प्रमाणे माल प्रमाणे"),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(width: 16),

                                  // Right column
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _radio("विक्री रजिस्टर"),
                                        _radio("विक्री रजिस्टर - वॅट सह"),
                                        _radio("सभासद प्रमाणे विक्री रजिस्टर"),
                                        _radio("विक्री सरासरी "),
                                        const SizedBox(height: 10),

                                        if (selectedReport == "स्टॉक स्टेटमेंट प्रमाणे माल प्रमाणे")
                                          DropdownButtonFormField<String>(
                                            value: selectedItem,
                                            decoration: const InputDecoration(
                                              labelText: "माल निवडा",
                                              border: OutlineInputBorder(),
                                              isDense: true,
                                            ),
                                            items: [
                                              "महालक्ष्मी पशुखाद्य ",
                                              "चिंतामणी पशुखाद्य",
                                              "गोळी-भूसा "
                                            ].map((item) {
                                              return DropdownMenuItem(
                                                value: item,
                                                child: Text(item),
                                              );
                                            }).toList(),
                                            onChanged: (val) {
                                              if (val != null) {
                                                setState(() => selectedItem = val);
                                              }
                                            },
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Date range
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFECFDF5), Color(0xFFD1FAE5)],
                            ),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0xFF6EE7B7), width: 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.date_range, color: Color(0xFF047857), size: 16),
                                  SizedBox(width: 6),
                                  Text(
                                    'दिनांक श्रेणी',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF065F46),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: _pickFromDate,
                                      child: InputDecorator(
                                        decoration: const InputDecoration(
                                          labelText: "पासून",
                                          border: OutlineInputBorder(),
                                          isDense: true,
                                        ),
                                        child: Text(DateFormat("dd/MM/yyyy").format(fromDate)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: InkWell(
                                      onTap: _pickToDate,
                                      child: InputDecorator(
                                        decoration: const InputDecoration(
                                          labelText: "पर्यंत",
                                          border: OutlineInputBorder(),
                                          isDense: true,
                                        ),
                                        child: Text(DateFormat("dd/MM/yyyy").format(toDate)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),


                        // Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // 🔵 Print Button with Gradient
                            InkWell(
                              onTap: () {
                                // TODO: Print logic
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF2563EB), Color(0xFF1E3A8A)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blueAccent.withOpacity(0.5),
                                      blurRadius: 12,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(Icons.print, color: Colors.white, size: 22),
                                    SizedBox(width: 8),
                                    Text(
                                      "प्रिंट",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(width: 35),

                            // 🔴 Close Button with Gradient
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => HomeScreen()),
                                );
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFFEF4444), Color(0xFFB91C1C)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.redAccent.withOpacity(0.5),
                                      blurRadius: 12,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(Icons.stop_circle, color: Colors.white, size: 22),
                                    SizedBox(width: 8),
                                    Text(
                                      "बंद",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
