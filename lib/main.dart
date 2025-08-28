import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';

import 'package:windows_sample/aavak_report_window.dart';
import 'package:windows_sample/milk_collection_window.dart';
import 'package:windows_sample/other_window.dart';
import 'package:windows_sample/providers/buffalo_ratechart_provider.dart';
import 'package:windows_sample/providers/cow_rate_chart_provider.dart';
// import 'package:windows_sample/screens/local_master_screeen.dart'; // ✅ check spelling if needed
import 'package:windows_sample/screens/local_master_screen.dart';
import 'package:windows_sample/screens/milk_collection_screen.dart';
import 'package:windows_sample/screens/rate_master_screen.dart';
import 'package:windows_sample/theme/app_theme.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CowRateChartProvider()),
        ChangeNotifierProvider(create: (_) => BuffaloRatechartProvider()), // 👈 Add this
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'File Explorer',
      home: FileExplorerPage(),
    );
  }
}

class FileExplorerPage extends StatefulWidget {
  const FileExplorerPage({super.key});

  @override
    FileExplorerPageState createState() => FileExplorerPageState();
}

class FileExplorerPageState extends State<FileExplorerPage>
    with TickerProviderStateMixin {
  Directory? currentDirectory;

  // Right panel widget
  Widget? selectedWidget;
  String? selectedFilePath;

  String fileContent = '';
  bool isLoading = false;

  Map<String, bool> expansionStates = {};

  int selectedTabIndex = 0;
  late AnimationController _tabAnimationController;

  final Map<String, dynamic> billingMenu = {
    'बिलिंग सिस्टीम': {
      'माहिती भरणे': {
        'दुध संकलन': MilkCollectionScreen(),
        'स्थानिक माहिती संच': LocalMasterScreen(),
        'रेट मास्टर':RateMasterScreen(),
      },
      'रिपोर्ट्स': {
        'आवक रेपोर्ट': AavakReportWindow(),
      },
      'इतर': {
        'इतर': OtherWindow(),
      },
    },
  };

  final Map<String, dynamic> accountingMenu = {

      'रिपोर्ट्स': {
        'आवक रेपोर्ट': AavakReportWindow(),
        'इतर': {
          'इतर': OtherWindow(),
        },
      },
  };

  final Map<String, dynamic> otherMenu = {
    'इतर': {
      },
  };

  final List<Map<String, dynamic>> services = [
    {
      "title": "दुध संकलन",
      "icon": 'assets/milk-can.png',
      "isImage": true,
      "color": Colors.lightBlueAccent,
    },
    {
      "title": "स्थानिक दुध विक्री नोंद",
      "icon": 'assets/milk_sale.png',
      "isImage": true,
      "color": Colors.greenAccent,
    },
    {
      "title": "कपाती भरणे",
      "icon": 'assets/rupee.png',
      "isImage": true,
      "color": Colors.orangeAccent,
    },
    {
      "title": "रिपोर्ट्स",
      "icon": 'assets/reports.png',
      "isImage": true,
      "color": Colors.deepPurpleAccent,
    },
    {
      "title": "पशुखाद्य",
      "icon": 'assets/cattlefeed.png',
      "isImage": true,
      "color": Colors.deepPurpleAccent,
    },
    {
      "title": "रोजकीर्दमधील नोंद",
      "icon": 'assets/cashbook.png',
      "isImage": true,
      "color": Colors.deepPurpleAccent,
    },
    {
      "title": "खातेवह्या",
      "icon": 'assets/Ledger.png',
      "isImage": true,
      "color": Colors.deepPurpleAccent,
    },
    {
      "title": "पत्रके पाहणे",
      "icon": 'assets/account_reports.png',
      "isImage": true,
      "color": Colors.deepPurpleAccent,
    },
    {
      "title": "उत्पाद्काची माहिती भरणे",
      "icon": 'assets/group.png',
      "isImage": true,
      "color": Color(0xFFA47DAB),
    },
    {
      "title": "पासवर्ड बदलणे",
      "icon": 'assets/forgot password.png',
      "isImage": true,
      "color": Color(0xFFA47DAB),
    },
    {
      "title": "लॉग आऊट",
      "icon": 'assets/logout.png',
      "isImage": true,
      "color": Color(0xFFA47DAB),
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabAnimationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
  }

  @override
  void dispose() {
    _tabAnimationController.dispose();
    super.dispose();
  }

  Widget _buildTabIcon(int index, String icon, String label) {
    final isSelected = selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTabIndex = index;
          });
          _tabAnimationController.forward(from: 0);
        },
        child: Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: isSelected
              ? BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          )
              : null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                height: 28,
                icon,
                color: isSelected ? Colors.blue : Colors.white,
              ),
              SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: isSelected ? Colors.blue : Colors.white,
                  fontWeight:
                  isSelected ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDirectoryStructure(
      Map<String, dynamic> menu, {
        bool isRoot = false,
        String parentPath = '',
      }) {
    final items = menu.entries.map((entry) {
      final key = entry.key;
      final value = entry.value;
      final currentPath =
      parentPath.isEmpty ? key : '$parentPath/$key';

      if (value is Map<String, dynamic>) {
        return Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            key: Key(currentPath),
            tilePadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
            childrenPadding: EdgeInsets.only(left: 16.0),
            visualDensity: VisualDensity.compact,
            minTileHeight: 32.0,
            trailing: const SizedBox.shrink(),
            leading: AnimatedRotation(
              duration: Duration(milliseconds: 200),
              turns: (expansionStates[currentPath] ?? false) ? 0.25 : 0.0,
              child: Icon(
                Icons.keyboard_arrow_right,
                size: 16,
                color: AppTheme.primaryBlack,
              ),
            ),
            onExpansionChanged: (expanded) {
              setState(() {
                expansionStates[currentPath] = expanded;
              });
            },
            title: Text(
              key,
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w400),
              overflow: TextOverflow.ellipsis,
            ),
            children: [
              _buildDirectoryStructure(value,
                  isRoot: false, parentPath: currentPath),
            ],
          ),
        );
      } else if (value is Widget) {
        return ListTile(
          dense: true,
          visualDensity: VisualDensity.compact,
          minTileHeight: 28.0,
          contentPadding:
          EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
          leading: const Icon(Icons.insert_drive_file,
              color: Colors.black45, size: 14),
          title: Text(
            key,
            style: const TextStyle(fontSize: 13, color: Colors.black),
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            setState(() {
              selectedFilePath = currentPath;
              selectedWidget = value;
            });
          },
        );
      }
      return const SizedBox();
    }).toList();

    return Column(mainAxisSize: MainAxisSize.min, children: items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          backgroundColor: AppTheme.primaryBlue,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.ac_unit, color: Colors.white),
          ),
          flexibleSpace: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top section
              Container(
                height: 56,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SizedBox(width: 56),
                    Text(
                      'Binary Solutions',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              // Bottom tabs
              SizedBox(
                height: 44,
                child: Row(
                  children: [
                    for (int i = 0; i < services.length; i++)
                      _buildTabIcon(
                          i, services[i]['icon'], services[i]['title']),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 280,
            height: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.backgroundSecondary,
              border: Border(right: BorderSide(color: Colors.black)),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDirectoryStructure(billingMenu,
                      isRoot: true, parentPath: 'section1'),
                  SizedBox(height: 8),
                  _buildDirectoryStructure(accountingMenu,
                      isRoot: true, parentPath: 'section2'),
                  SizedBox(height: 8),
                  _buildDirectoryStructure(otherMenu,
                      isRoot: true, parentPath: 'section3'),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Right panel
          Expanded(
            child: Container(
              color: AppTheme.backgroundSecondary,
              child: (selectedWidget != null)
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundSecondary,
                      border: Border(
                          bottom: BorderSide(color: Colors.black)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.insert_drive_file,
                            size: 16, color: AppTheme.primaryBlack),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            selectedFilePath ?? '',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: selectedWidget!,
                    ),
                  ),
                ],
              )
                  : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.description,
                        size: 64, color: Colors.blueAccent),
                    SizedBox(height: 16),
                    Text(
                      'Select a file to view its contents',
                      style: TextStyle(
                          color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
