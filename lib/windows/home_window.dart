import 'dart:io';
import 'package:windows_sample/windows/milk_collection_window.dart';
import 'package:windows_sample/windows/other_window.dart';
import 'package:windows_sample/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:windows_sample/windows/aavak_report_window.dart';
import 'package:windows_sample/windows/bank_master_window.dart';
import 'package:windows_sample/windows/branch_master_window.dart';
import 'package:windows_sample/windows/customer_master_window.dart';
import 'package:windows_sample/windows/rate_setup_window.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Directory? currentDirectory;
  Map<String, bool> expansionStates = {};
  int selectedTabIndex = 0;
  late AnimationController _tabAnimationController;
  late AnimationController _sidebarAnimationController;
  late Animation<Offset> _slideAnimation;
  late Animation _tabAnimation;
  Map<String,Map<String,Map<String,StatefulWidget>>> billingMenu ={
    'बिलिंग सिस्टीम':
    {'माहिती भरणे':
    {'दुध संकलन':MilkCollectionWindow(),
      'शाखा नावे भरणे':BranchMasterWindow() ,
      'बँक माहिती भरणे':BankMasterWindow(),
      'उत्पादकाची माहिती भरणे':CustomerMasterWindow()},

      'रिपोर्ट्स':
      {'आवकदुध रिपोर्ट':AavakReportWindow()},
      'इतर':{'दर सेटप':RateSetupWindow()}
    },
  };

  Map<String,Map<String,Map<String,StatefulWidget>>> accountingMenu ={
    'अक्कौटिंग सिस्टीम':
    {'माहिती भरणे':
    {'दुध संकलन':MilkCollectionWindow()},

      'रिपोर्ट्स':
      {'आवक रेपोर्ट':AavakReportWindow()},

    },
  };

  Map<String,Map<String,Map<String,StatefulWidget>>> otherMenu ={
    'इतर':
    {'माहिती भरणे':
    {'दुध संकलन':MilkCollectionWindow()},

      'रिपोर्ट्स':
      {'आवक रेपोर्ट':AavakReportWindow()},
      'इतर':{'इतर':OtherWindow()}
    },
  };

  final List<Map<String, dynamic>> services = [
    {
      "title": "दुध संकलन",
      "icon": 'assets/milk-can.png',
      "isImage": true,
      "color": Color(0xFF3B82F6),
      "gradient": [Color(0xFF3B82F6), Color(0xFF1E40AF)]
    },
    {
      "title": "स्थानिक दुध विक्री नोंद",
      "icon": 'assets/milk-box.png',
      "isImage": true,
      "color": Color(0xFF10B981),
      "gradient": [Color(0xFF10B981), Color(0xFF059669)]
    },
    {
      "title": "कपाती भरणे",
      "icon": 'assets/rupee.png',
      "isImage": true,
      "color": Color(0xFFF59E0B),
      "gradient": [Color(0xFFF59E0B), Color(0xFFD97706)]
    },
    {
      "title": "रिपोर्ट्स",
      "icon": 'assets/report.png',
      "isImage": true,
      "color": Color(0xFF8B5CF6),
      "gradient": [Color(0xFF8B5CF6), Color(0xFF7C3AED)]
    },
    {
      "title": "उत्पाद्काची माहिती भरणे",
      "icon": 'assets/group.png',
      "isImage": true,
      "color": Color(0xFFEC4899),
      "gradient": [Color(0xFFEC4899), Color(0xFFDB2777)]
    },
  ];

  String? selectedFilePath;
  String fileContent = '';
  bool isLoading = false;
  StatefulWidget? selectedWidget;

  @override
  void initState() {
    super.initState();
    _tabAnimationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _sidebarAnimationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _tabAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _tabAnimationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _sidebarAnimationController,
      curve: Curves.easeOutCubic,
    ));

    _sidebarAnimationController.forward();
  }

  @override
  void dispose() {
    _tabAnimationController.dispose();
    _sidebarAnimationController.dispose();
    super.dispose();
  }

  Widget _buildTabIcon(int index, String icon, String label) {
    final isSelected = selectedTabIndex == index;
    final service = services[index];

    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: InkWell(
          onTap: () {
            setState(() {
              selectedTabIndex = index;
            });
            _tabAnimationController.forward(from: 0);
          },
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          child: Container(
            height: 60,
            margin: EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              gradient: isSelected
                  ? LinearGradient(
                colors: [
                  Colors.white,
                  Color(0xFFF8FAFC),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
                  : null,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              boxShadow: isSelected
                  ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: Offset(0, -2),
                ),
              ]
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                      colors: service['gradient'],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                        : null,
                    color: isSelected ? null : Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: isSelected
                        ? [
                      BoxShadow(
                        color: service['color'].withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ]
                        : null,
                  ),
                  child: Image.asset(
                    icon,
                    height: 24,
                    width: 24,
                    color: isSelected ? Colors.white : Colors.white.withOpacity(0.8),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: isSelected ? Color(0xFF1F2937) : Colors.white.withOpacity(0.9),
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDirectoryStructure(Map<String, dynamic> menu, {bool isRoot = false, String parentPath = ''}) {
    final items = menu.entries.map((entry) {
      final key = entry.key;
      final value = entry.value;
      final currentPath = parentPath.isEmpty ? key : '$parentPath/$key';

      if (value is Map<String, dynamic>) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(vertical: 1),
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              splashColor: Color(0xFF3B82F6).withOpacity(0.1),
              highlightColor: Color(0xFF3B82F6).withOpacity(0.05),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: (expansionStates[currentPath] ?? false)
                      ? Color(0xFF3B82F6).withOpacity(0.2)
                      : Colors.transparent,
                ),
              ),
              child: ExpansionTile(
                key: Key(currentPath),
                tilePadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                childrenPadding: EdgeInsets.only(left: 20.0, bottom: 8.0),
                visualDensity: VisualDensity.compact,
                dense: true,
                minTileHeight: 40.0,
                trailing: const SizedBox.shrink(),
                leading: AnimatedRotation(
                  duration: Duration(milliseconds: 300),
                  turns: (expansionStates[currentPath] ?? false) ? 0.25 : 0.0,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: (expansionStates[currentPath] ?? false)
                          ? Color(0xFF3B82F6).withOpacity(0.1)
                          : Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      size: 16,
                      color: (expansionStates[currentPath] ?? false)
                          ? Color(0xFF3B82F6)
                          : Color(0xFF6B7280),
                    ),
                  ),
                ),
                onExpansionChanged: (expanded) {
                  setState(() {
                    expansionStates[currentPath] = expanded;
                  });
                },
                title: Text(
                  key,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2937),
                    letterSpacing: 0.2,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: _buildDirectoryStructure(value, isRoot: false, parentPath: currentPath),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      else if (value is StatefulWidget) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: selectedFilePath == key
                ? Color(0xFF3B82F6).withOpacity(0.1)
                : Colors.transparent,
          ),
          child: ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            minTileHeight: 36.0,
            contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
            leading: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF10B981), Color(0xFF059669)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF10B981).withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Icon(
                Icons.description_outlined,
                color: Colors.white,
                size: 14,
              ),
            ),
            title: Text(
              key,
              style: TextStyle(
                fontSize: 13,
                fontWeight: selectedFilePath == key ? FontWeight.w600 : FontWeight.w500,
                color: selectedFilePath == key ? Color(0xFF3B82F6) : Color(0xFF374151),
                letterSpacing: 0.1,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              setState(() {
                selectedFilePath = key;
                selectedWidget = value;
                fileContent = 'Content for $key';
              });
            },
          ),
        );
      }
      return const SizedBox();
    }).toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: items,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(128),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1E40AF), Color(0xFF3B82F6), Color(0xFF60A5FA)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF1E40AF).withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 20,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.dashboard_rounded, color: Colors.white, size: 24),
              ),
            ),
            flexibleSpace: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top section with title - reduced height
                Container(
                  height: 70, // Reduced from 80
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SizedBox(width: 72),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Binary Solutions',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            'डेअरी मॅनेजमेंट सिस्टीम',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Bottom section with enhanced tabs - reduced height
                Container(
                  height: 58, // Reduced from 50
                  child: Row(
                    children: [
                      for(int i = 0; i < services.length; i++)
                        _buildTabIcon(i, services[i]['icon'], services[i]['title']),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8FAFC), Color(0xFFE5E7EB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          children: [
            // Enhanced Left sidebar
            SlideTransition(
              position: _slideAnimation,
              child: Container(
                width: 320,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(right: BorderSide(color: Color(0xFFE5E7EB), width: 1)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: Offset(2, 0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Sidebar header
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFF8FAFC), Colors.white],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF3B82F6), Color(0xFF1E40AF)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(Icons.menu_book_rounded, color: Colors.white, size: 20),
                          ),
                          SizedBox(width: 12),
                          Text(
                            'मेनू',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Scrollable menu content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDirectoryStructure(billingMenu, isRoot: true, parentPath: 'section1'),
                            SizedBox(height: 12),
                            _buildDirectoryStructure(accountingMenu, isRoot: true, parentPath: 'section2'),
                            SizedBox(height: 12),
                            _buildDirectoryStructure(otherMenu, isRoot: true, parentPath: 'section3'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Enhanced Right side content
            Expanded(
              child: selectedWidget != null
                  ? Container(
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: selectedWidget!,
                ),
              )
                  : Container(
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF3B82F6).withOpacity(0.1), Color(0xFF1E40AF).withOpacity(0.05)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          Icons.touch_app_rounded,
                          size: 80,
                          color: Color(0xFF3B82F6),
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        'मेनू मधून पर्याय निवडा',
                        style: TextStyle(
                          color: Color(0xFF1F2937),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'कृपया डाव्या बाजूच्या मेनू मधून तुमचा पर्याय निवडा',
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 14,
                          letterSpacing: 0.2,
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
    );
  }
}