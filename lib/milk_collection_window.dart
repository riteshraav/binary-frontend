import 'package:flutter/material.dart';



class MilkCollectionWindow extends StatefulWidget {
  @override
  _MilkCollectionWindowState createState() => _MilkCollectionWindowState();
}

class _MilkCollectionWindowState extends State<MilkCollectionWindow> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController literController = TextEditingController();
  final TextEditingController fatController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  bool isVillageSelected = true;
  bool isPrintChecked = false;
  String selectedShift = 'सकाळ';

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
                    Text(
                      'दुध संकलन व्यवस्थापन',
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
                          Text(
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
                    // Left Panel - Main Input Area
                    Expanded(
                      flex: 3,
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
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Color(0xFFEBF4FF), Color(0xFFDBEAFE)],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Color(0xFF93C5FD), width: 1),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.person, color: Color(0xFF2563EB), size: 20),
                                        SizedBox(width: 8),
                                        Text(
                                          'सदस्य माहिती',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF1E3A8A),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('उत्पादक कोड', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                                            SizedBox(height: 4),
                                            Container(
                                              width: 120,
                                              height: 40,
                                              child: TextField(
                                                controller: codeController,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
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
                                        SizedBox(width: 20),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('उत्पादकाचे नाव', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                                              SizedBox(height: 4),
                                              Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                                                  ),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: DropdownButtonHideUnderline(
                                                  child: DropdownButton<String>(
                                                    isExpanded: true,
                                                    value: null,
                                                    hint: Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 12),
                                                      child: Text('उत्पादक निवडा', style: TextStyle(color: Colors.white)),
                                                    ),
                                                    dropdownColor: Colors.white,
                                                    icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                                                    items: [],
                                                    onChanged: (value) {},
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Container(
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: Color(0xFFD1D5DB)),
                                          ),
                                          child: Row(
                                            children: [
                                              Radio<bool>(
                                                value: true,
                                                groupValue: isVillageSelected,
                                                onChanged: (value) {
                                                  setState(() {
                                                    isVillageSelected = value!;
                                                  });
                                                },
                                                activeColor: Color(0xFF2563EB),
                                              ),
                                              Text('गाव', style: TextStyle(color: Color(0xFF374151))),
                                              SizedBox(width: 16),
                                              Radio<bool>(
                                                value: false,
                                                groupValue: isVillageSelected,
                                                onChanged: (value) {
                                                  setState(() {
                                                    isVillageSelected = value!;
                                                  });
                                                },
                                                activeColor: Color(0xFF2563EB),
                                              ),
                                              Text('फ्लेट', style: TextStyle(color: Color(0xFF374151))),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 24),

                              // Input Fields Section
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Color(0xFFF0F9FF), Color(0xFFE0F2FE)],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Color(0xFF7DD3FC), width: 1),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.analytics, color: Color(0xFF0284C7), size: 20),
                                        SizedBox(width: 8),
                                        Text(
                                          'दूध मापन',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF0C4A6E),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    Row(
                                      children: [
                                        // Zero Button
                                        Column(
                                          children: [
                                            Container(
                                              width: 80,
                                              height: 45,
                                              child: ElevatedButton(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Color(0xFF059669),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  elevation: 2,
                                                ),
                                                child: Text('Zero', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                                              ),
                                            ),
                                            SizedBox(height: 12),
                                            _buildInputField('लिटर', literController, Icons.local_drink),
                                          ],
                                        ),

                                        SizedBox(width: 20),

                                        // Fat
                                        Column(
                                          children: [
                                            _buildInputField('फॅट (%)', fatController, Icons.opacity),
                                            SizedBox(height: 12),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(color: Color(0xFFD1D5DB)),
                                              ),
                                              child: Row(
                                                children: [
                                                  Checkbox(
                                                    value: isPrintChecked,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        isPrintChecked = value!;
                                                      });
                                                    },
                                                    activeColor: Color(0xFF2563EB),
                                                  ),
                                                  Text('Print', style: TextStyle(color: Color(0xFF374151))),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(width: 20),
                                        _buildInputField('दर (₹)', rateController, Icons.currency_rupee),
                                        SizedBox(width: 20),
                                        _buildInputField('रकम (₹)', amountController, Icons.account_balance_wallet),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 24),

                              // Action Buttons
                              Row(
                                children: [
                                  _buildActionButton('साठवणे', Icons.save, Color(0xFF059669)),
                                  SizedBox(width: 12),
                                  _buildActionButton('पुसूणे', Icons.delete, Color(0xFFDC2626)),
                                  SizedBox(width: 12),
                                  _buildActionButton('दुरुस्ती', Icons.edit, Color(0xFFD97706)),
                                  SizedBox(width: 12),
                                  _buildActionButton('बाहेर', Icons.exit_to_app, Color(0xFF6B7280)),
                                  Spacer(),
                                  Container(
                                    width: 140,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: DropdownButtonFormField<String>(
                                      value: selectedShift,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                                      ),
                                      dropdownColor: Colors.white,
                                      style: TextStyle(color: Colors.white),
                                      icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                                      items: ['सकाळ', 'सायंकाळ'].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value, style: TextStyle(color: Color(0xFF374151))),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedShift = value!;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  _buildActionButton('मागील', Icons.arrow_back, Color(0xFF8B5CF6)),
                                ],
                              ),

                              SizedBox(height: 24),

                              // Data Table
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Color(0xFFE5E7EB)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            _buildTableHeader('कोड'),
                                            _buildTableHeader('उत्पादकाचे नाव'),
                                            _buildTableHeader('गाव/फ्लेट'),
                                            _buildTableHeader('लिटर'),
                                            _buildTableHeader('फॅट'),
                                            _buildTableHeader('SNF'),
                                            _buildTableHeader('दर'),
                                            _buildTableHeader('रकम'),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFFFAFAFA),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(12),
                                              bottomRight: Radius.circular(12),
                                            ),
                                          ),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.table_chart, size: 48, color: Colors.grey[400]),
                                                SizedBox(height: 16),
                                                Text(
                                                  'कोणतीही डेटा उपलब्ध नाही',
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
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
                    ),

                    // Right Panel - Summary Dashboard
                    Container(
                      width: 280,
                      margin: EdgeInsets.only(top: 16, right: 16, bottom: 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF1E3A8A), Color(0xFF1E40AF)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Summary Header
                          Container(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Icon(Icons.dashboard, color: Colors.white, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  'दैनिक सारांश',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // गाव Summary Card
                          _buildSummaryCard(
                            'गाव',
                            Icons.location_city,
                            Color(0xFF10B981),
                            '० सदस्य',
                            '०.० लिटर',
                            '०.० फॅट',
                            '₹०.००',
                          ),

                          SizedBox(height: 16),

                          // फ्लेट Summary Card
                          _buildSummaryCard(
                            'फ्लेट',
                            Icons.apartment,
                            Color(0xFFF59E0B),
                            '० सदस्य',
                            '०.० लिटर',
                            '०.० फॅट',
                            '₹०.००',
                          ),

                          SizedBox(height: 16),

                          // एकूण Summary Card
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.analytics, color: Colors.white, size: 20),
                                    SizedBox(width: 8),
                                    Text(
                                      'एकूण',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('एकूण सदस्य: ०', style: TextStyle(color: Colors.white70, fontSize: 12)),
                                        Text('एकूण लिटर: ०.०', style: TextStyle(color: Colors.white70, fontSize: 12)),
                                        Text('सरासरी फॅट: ०.०', style: TextStyle(color: Colors.white70, fontSize: 12)),
                                        Text('एकूण रकम: ₹०.००', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          Spacer(),

                          // Footer
                          Container(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              'संस्था: स्मासन दूध संकलन केंद्र',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                             //   textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w500)),
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
    );
  }

  Widget _buildActionButton(String text, IconData icon, Color color) {
    return Container(
      height: 45,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon, size: 18),
        label: Text(text, style: TextStyle(fontWeight: FontWeight.w600)),
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

  Widget _buildTableHeader(String text) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, IconData icon, Color color, String members, String liters, String fat, String amount) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(members, style: TextStyle(color: Colors.white70, fontSize: 11)),
                  Text(liters, style: TextStyle(color: Colors.white70, fontSize: 11)),
                  Text(fat, style: TextStyle(color: Colors.white70, fontSize: 11)),
                  Text(amount, style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                ],
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.local_drink, color: Colors.white, size: 24),
              ),
            ],
          ),
        ],
      ),
    );
  }
}