import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:windows_sample/aavak_report_window.dart';
import 'package:windows_sample/milk_collection_window.dart';
import 'package:windows_sample/other_window.dart';
import 'package:windows_sample/theme/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'File Explorer',
      ////
      //// Commented out theme to use AppTheme instead
      //// AppTheme provides consistent color scheme across the app
      ////
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   brightness: Brightness.dark,
      //   scaffoldBackgroundColor: Color(0xFF2B2B2B),
      // ),
      home: FileExplorerPage(),
    );
  }

  ////
  //// Helper method to build individual tab icons
  //// Creates consistent styling and tap handling for each tab
  ////
}

class FileExplorerPage extends StatefulWidget {
  @override
  _FileExplorerPageState createState() => _FileExplorerPageState();
}

class _FileExplorerPageState extends State<FileExplorerPage> with TickerProviderStateMixin {
  Directory? currentDirectory;
  ////
  //// Added expansion state tracking for each menu item
  //// This helps manage which folders are expanded and update arrow directions accordingly
  ////
  Map<String, bool> expansionStates = {};

  ////
  //// Added AppBar tab functionality similar to WhatsApp
  //// Tracks selected tab index and manages animated indicator
  ////
  int selectedTabIndex = 0;
  late AnimationController _tabAnimationController;
  late Animation<double> _tabAnimation;
  Map<String,Map<String,Map<String,StatefulWidget>>> billingMenu ={
    'बिलिंग सिस्टीम':
    {'माहिती भरणे':
    {'दुध संकलन':MilkCollectionWindow()},

      'रिपोर्ट्स':
      {'आवक रेपोर्ट':AavakReportWindow()},
      'इतर':{'इतर':OtherWindow()}
    },

  };
  Map<String,Map<String,Map<String,StatefulWidget>>> accountingMenu ={
    'अक्कौटिंग सिस्टीम':
    {'माहिती भरणे':
    {'दुध संकलन':MilkCollectionWindow()},

      'रिपोर्ट्स':
      {'आवक रेपोर्ट':AavakReportWindow()},
      'इतर':{'इतर':OtherWindow()}
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
      //"route": MilkCollectionPage(),
      "color": Colors.lightBlueAccent
    },
    {
      "title": "स्थानिक दुध विक्री नोंद",
      "icon": 'assets/milk-box.png',
      "isImage": true,
   //   "route": LocalMilkSalePage(),
      "color": Colors.greenAccent
    },
    {
      "title": "कपाती भरणे",
      "icon": 'assets/rupee.png',
      "isImage": true,
    //  "route": DeductionMasterScreen(),
      "color": Colors.orangeAccent
    },
    {
      "title": "रिपोर्ट्स",
      "icon": 'assets/report.png',
      "isImage": true,
     // "route": ReportGenerationPage(),
      "color": Colors.deepPurpleAccent
    },
    {
      "title": "उत्पाद्काची माहिती भरणे",
      "icon": 'assets/group.png',
      "isImage": true,
   //   "route": CustomerPage(),
      "color": Color(0xFFA47DAB)
    },
  //   {
  //     "title": "दर भरणे",
  //     "icon": 'assets/rate.png',
  //     "isImage": true,
  //   //  "route": UpdateRatechart(),
  //     "color": Color(0xFFCF6DFC)
  //   },
  //   {
  //     "title": "पशु खाद्य विक्री",
  //     "icon": 'assets/cattlefeed.png',
  //     "isImage": true,
  //   //  "route": CattleFeedOptions(),
  //     "color": Color(0xFF4272FF)
  //   },
  //   {
  //     "title": "Advance",
  //     "icon": 'assets/advance.png',
  //     "isImage": true,
  // //    "route": CustomerAdvanceHistory(),
  //     "color": Colors.redAccent
  //   },
  //   {
  //     "title": "Advance Organization",
  //     "icon": 'assets/advance organization.png',
  //     "isImage": true,
  //    // "route": OrganizationScreen(),
  //     "color": Color(0xFFFFA896)
  //   },
  //   {
  //     "title": "Customer Loan",
  //     "icon": 'assets/customer loan.png',
  //     "isImage": true,
  //
  //    // "route": CustomerLoanHistory(),
  //     "color": Color(0xFF5C5C99)
  //   },
  ];

  List<String> mainMenuList =  ['Billing','Accounting','Other'];
  List<String> subMenuList = ['Mahiti Bharane','Reports','Other'];
  String? selectedFilePath;
  String fileContent = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    ////
    //// Initialize animation controller for tab indicator
    //// Creates smooth transition animation when switching between tabs
    ////
    _tabAnimationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _tabAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _tabAnimationController, curve: Curves.easeInOut),
    );
  }

  ////
  //// Added dispose method to clean up animation controller
  //// Prevents memory leaks when widget is destroyed
  ////
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
          ////
          //// Tab selection logic with animation trigger
          //// Updates selected index and starts indicator animation
          ////
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
            color: Colors.blue[50], // transparent blue
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight:Radius.circular(8) ), // rounded corners
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
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ],
          ),
        )
        ,
      ),
    );
  }


  Widget _buildDirectoryStructure(Map<String, dynamic> menu, {bool isRoot = false, String parentPath = ''}) {
    final items = menu.entries.map((entry) {
      final key = entry.key;
      final value = entry.value;
      ////
      //// Create unique path for each item to track expansion state
      //// This allows proper state management for nested folders
      ////
      final currentPath = parentPath.isEmpty ? key : '$parentPath/$key';

      if (value is Map<String, dynamic>) {
        // Directory - Compact ExpansionTile
        return Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
          ),
          ////
          //// Modified ExpansionTile to use tracked expansion states
          //// Arrow direction now properly updates based on actual expansion state
          ////
          child: ExpansionTile(
            key: Key(currentPath),
            tilePadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
            childrenPadding: EdgeInsets.only(left: 16.0),
            visualDensity: VisualDensity.compact,
            dense: true,
            minTileHeight: 32.0, // Compact height
            trailing: const SizedBox.shrink(), // remove default arrow
            ////
            //// Updated leading widget to use AppTheme colors
            //// Arrow smoothly rotates from right (collapsed) to down (expanded)
            ////
            leading: AnimatedRotation(
              duration: Duration(milliseconds: 200),
              turns: (expansionStates[currentPath] ?? false) ? 0.25 : 0.0, // 0.25 = 90 degrees
              child: Icon(
                Icons.keyboard_arrow_right,
                size: 16,
                color: AppTheme.primaryBlack,
              ),
            ),
            ////
            //// Enhanced onExpansionChanged to properly track state
            //// Updates expansion state map for accurate arrow direction
            ////
            onExpansionChanged: (expanded) {
              setState(() {
                expansionStates[currentPath] = expanded;
              });
            },
            title: Text(
              key,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            children: [
              _buildDirectoryStructure(value, isRoot: false, parentPath: currentPath),
            ],
          ),
        );
      }
      else if (value is StatefulWidget) {
        // File - Compact ListTile
        return ListTile(
          dense: true,
          visualDensity: VisualDensity.compact,
          minTileHeight: 28.0, // Very compact for files
          contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
          ////
          //// Updated file icon color to match AppTheme
          //// Uses AppTheme.primaryBlack for consistency
          ////
          leading: const Icon(
              Icons.insert_drive_file,
              color: Colors.black45,
              size: 14
          ),
          title: Text(
            key,
            ////
            //// Updated text color to use AppTheme
            //// Maintains readability with theme colors
            ////
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            ////
            //// Enhanced file selection with state management
            //// Updates right panel content when file is selected
            ////
            setState(() {
              selectedFilePath = key;
              fileContent = 'Content for $key'; // Replace with actual content loading
            });
            print('Opening $key');
          },
        );
      }
      return const SizedBox();
    }).toList();

    // Root level uses intrinsic height, child levels are just columns
    return isRoot
        ? Column(
      mainAxisSize: MainAxisSize.min,
      children: items,
    )
        : Column(
      mainAxisSize: MainAxisSize.min,
      children: items,
    );
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
              // Top section with title
              Container(
                height: 56,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SizedBox(width: 56), // space for leading icon
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
              // Bottom section with tabs
              Container(
                height: 44,
                child: Row(
                  children: [
                    for(int i=0;i<services.length;i++)
                      _buildTabIcon(i, services[i]['icon'], services[i]['title']),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
        body: Row(
          children: [
            // Left sidebar - File tree with flexible width
            Container(
              width: 280, // Slightly reduced width for compactness
              height: double.infinity,
              ////
              //// Updated container styling to use AppTheme colors
              //// Maintains consistency with overall app theme
              ////
              decoration: BoxDecoration(
                color: AppTheme.backgroundSecondary,
                border: Border(right: BorderSide(color: Colors.black)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ////
                    //// Removed section headers for cleaner look
                    //// Direct menu structure without additional labels
                    ////
                    _buildDirectoryStructure(billingMenu, isRoot: true, parentPath: 'section1'),

                    SizedBox(height: 8),

                    _buildDirectoryStructure(accountingMenu, isRoot: true, parentPath: 'section2'),

                    SizedBox(height: 8),

                    _buildDirectoryStructure(otherMenu, isRoot: true, parentPath: 'section3'),

                    SizedBox(height: 16), // Bottom padding
                  ],
                ),
              ),
            ),

            // Right side - File content viewer
            Expanded(
              child: Container(
                ////
                //// Updated right panel to use AppTheme background
                //// Consistent color scheme throughout the interface
                ////
                color: AppTheme.backgroundSecondary,
                child: selectedFilePath != null
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // File header
                    Container(
                      padding: EdgeInsets.all(12),
                      ////
                      //// Updated file header styling with AppTheme colors
                      //// Maintains visual consistency with theme
                      ////
                      decoration: BoxDecoration(
                        color: AppTheme.backgroundSecondary,
                        border: Border(bottom: BorderSide(color: Colors.black)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.insert_drive_file,
                            size: 16,
                            color: AppTheme.primaryBlack,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              selectedFilePath!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // File content
                    Expanded(
                      child: isLoading
                          ? Center(child: CircularProgressIndicator())
                          : SingleChildScrollView(
                        padding: EdgeInsets.all(16),
                        child: SelectableText(
                          fileContent,
                          ////
                          //// Updated text styling to use AppTheme colors
                          //// Ensures proper readability with theme
                          ////
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                    : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ////
                      //// Updated empty state styling with theme colors
                      //// Better visual integration with overall design
                      ////
                      Icon(
                        Icons.description,
                        size: 64,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Select a file to view its contents',
                        style: TextStyle(
                          color: Colors.black,
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
      );
    }
  }