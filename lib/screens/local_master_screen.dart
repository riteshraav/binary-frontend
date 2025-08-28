import 'package:flutter/material.dart';

class LocalMasterScreen extends StatefulWidget {
  const LocalMasterScreen({Key? key}) : super(key: key);

  @override
  State<LocalMasterScreen> createState() => _LocalMasterScreenState();
}

class _LocalMasterScreenState extends State<LocalMasterScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _selectedVillageForFarmer;
  List<Map<String, dynamic>> _savedFarmers = [];    //Utpadak
  List<Map<String, String>> _savedRateCharts = [];    //Darpatrak
  List<Map<String, String>> _savedSnfFatRecords = [];   //SNF/FAT
  List<Map<String, String>> _savedCenters = [];   //Sankalan
  List<Map<String, String>>_savedLedgers=[];  //saveledger


  // Controllers
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _villageIdController = TextEditingController();
  final TextEditingController _clusterController = TextEditingController();
  final TextEditingController _talukaController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _contactNameController = TextEditingController();
  final TextEditingController _contactMobileController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _snfController = TextEditingController();
  final TextEditingController _fatController = TextEditingController();
  final TextEditingController _centerNameController = TextEditingController();
  final TextEditingController _ledgerController = TextEditingController();
  // --- उत्पादकासाठी Controllers ---
  final TextEditingController _farmerNameController = TextEditingController();
  final TextEditingController _farmerMobileController = TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  final TextEditingController _aadhaarController = TextEditingController();
  final TextEditingController _bankAccountController = TextEditingController();
  final TextEditingController _farmerVillageController = TextEditingController();
  final TextEditingController _farmerPermanentIdController = TextEditingController();
  final TextEditingController _farmerBranchController = TextEditingController();
  // --- darpatrak Controllers ---
  final TextEditingController _rateChartSnfController = TextEditingController();
  final TextEditingController _rateChartFatController = TextEditingController();
  final TextEditingController _rateChartRateController = TextEditingController();
  final TextEditingController _rateChartRemarkController = TextEditingController();
  // --- SNF/FAT Controllers ---
  final TextEditingController _snfFatSnfController = TextEditingController();
  final TextEditingController _snfFatFatController = TextEditingController();
  final TextEditingController _snfFatClrController = TextEditingController();
  final TextEditingController _snfFatRemarkController = TextEditingController();
  // --- Sankalan Branch Controllers ---
  final TextEditingController _collectionCenterIdController = TextEditingController();
  final TextEditingController _collectionCenterNameController = TextEditingController();
  final TextEditingController _collectionCenterAddressController = TextEditingController();
  final TextEditingController _collectionCenterInchargeController = TextEditingController();
  final TextEditingController _collectionCenterMobileController = TextEditingController();
  final TextEditingController _collectionCenterRemarkController = TextEditingController();
  // --- Sankalan Branch Controllers ---
  final TextEditingController _ledgerAccountNumberController = TextEditingController();
  final TextEditingController _ledgerBankNameController = TextEditingController();
  final TextEditingController _ledgerBranchController = TextEditingController();
  final TextEditingController _ledgerIfscController = TextEditingController();  // वेगळं नाव
  final TextEditingController _ledgerAccountTypeController = TextEditingController();
  final TextEditingController _ledgerRemarkController = TextEditingController();






  String? _selectedCenter; // dropdown value
  final List<Map<String, String>> _savedVillages = []; // saved data list

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _villageController.dispose();
    _villageIdController.dispose();
    _clusterController.dispose();
    _talukaController.dispose();
    _districtController.dispose();
    _contactNameController.dispose();
    _contactMobileController.dispose();
    super.dispose();
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local Master (स्थानिक मास्टर)"),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: "गाव / वाडी"),
            Tab(text: "उत्पादक"),
            Tab(text: "दरपत्रक"),
            Tab(text: "SNF/FAT"),
            Tab(text: "संकलन केंद्र"),
            Tab(text: "खातेवही"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // ------------------ गाव / वाडी माहिती ------------------
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildTextField("गाव / वाडीचे नाव", _villageController),
                        _buildTextField("गाव आयडी", _villageIdController),
                        _buildTextField("गट / क्लस्टर", _clusterController),
                        _buildTextField("तालुका", _talukaController),
                        _buildTextField("जिल्हा", _districtController),
                        _buildTextField("संपर्क व्यक्तीचे नाव", _contactNameController),
                        _buildTextField("संपर्क मोबाईल", _contactMobileController),

                        // Dropdown for संकलन केंद्र
                        DropdownButtonFormField<String>(
                          value: _selectedCenter,
                          decoration: const InputDecoration(
                            labelText: "संकलन केंद्र",
                            border: OutlineInputBorder(),
                          ),
                          items: ["केंद्र 1", "केंद्र 2", "केंद्र 3"]
                              .map((center) => DropdownMenuItem(
                            value: center,
                            child: Text(center),
                          ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCenter = value;
                            });
                          },
                        ),

                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _savedVillages.add({
                                "गाव": _villageController.text,
                                "गाव आयडी": _villageIdController.text,
                                "गट": _clusterController.text,
                                "तालुका": _talukaController.text,
                                "जिल्हा": _districtController.text,
                                "संपर्क": _contactNameController.text,
                                "मोबाईल": _contactMobileController.text,
                                "केंद्र": _selectedCenter ?? "",
                              });
                            });

                            // clear fields
                            _villageController.clear();
                            _villageIdController.clear();
                            _clusterController.clear();
                            _talukaController.clear();
                            _districtController.clear();
                            _contactNameController.clear();
                            _contactMobileController.clear();
                            setState(() {
                              _selectedCenter = null;
                            });
                          },
                          child: const Text("जतन करा"),
                        ),
                      ],
                    ),
                  ),
                ),

                // saved data table
                if (_savedVillages.isNotEmpty) ...[
                  const Divider(),
                  const Text(
                    "जतन केलेली गावे",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        border: TableBorder.all(),
                        columns: const [
                          DataColumn(label: Text("गाव")),
                          DataColumn(label: Text("गाव आयडी")),
                          DataColumn(label: Text("गट")),
                          DataColumn(label: Text("तालुका")),
                          DataColumn(label: Text("जिल्हा")),
                          DataColumn(label: Text("संपर्क")),
                          DataColumn(label: Text("मोबाईल")),
                          DataColumn(label: Text("केंद्र")),
                        ],
                        rows: _savedVillages.map((village) {
                          return DataRow(
                            cells: [
                              DataCell(Text(village["गाव"] ?? "")),
                              DataCell(Text(village["गाव आयडी"] ?? "")),
                              DataCell(Text(village["गट"] ?? "")),
                              DataCell(Text(village["तालुका"] ?? "")),
                              DataCell(Text(village["जिल्हा"] ?? "")),
                              DataCell(Text(village["संपर्क"] ?? "")),
                              DataCell(Text(village["मोबाईल"] ?? "")),
                              DataCell(Text(village["केंद्र"] ?? "")),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),


          // ------------------दरपत्रक ------------------

          // दरपत्रक
          // उत्पादक / शेतकरी माहिती

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "उत्पादक नोंदणी",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child:Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // गाव / वाडी (TextField - user can type)
                            _buildTextField("गाव / वाडी", _farmerVillageController),

                            const SizedBox(height: 12),
                            _buildTextField("उत्पादकाचे नाव", _farmerNameController),
                            _buildTextField("कायमस्वरूपी आयडी", _farmerPermanentIdController),
                            _buildTextField("शाखा", _farmerBranchController),

                            _buildTextField("मोबाईल क्रमांक", _farmerMobileController),
                            _buildTextField("आधार क्रमांक", _aadhaarController),
                            _buildTextField("बँक खाते क्रमांक", _bankAccountController),
                            _buildTextField("IFSC कोड", _ifscController),

                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () {
                                if (_farmerVillageController.text.isNotEmpty &&
                                    _farmerNameController.text.isNotEmpty) {
                                  setState(() {
                                    _savedFarmers.add({
                                      "गाव": _farmerVillageController.text,
                                      "नाव": _farmerNameController.text,
                                      "मोबाईल": _farmerMobileController.text,
                                      "आधार": _aadhaarController.text,
                                      "खाते": _bankAccountController.text,
                                      "IFSC": _ifscController.text,
                                    });
                                  });

                                  // Clear fields after save
                                  _farmerVillageController.clear();
                                  _farmerNameController.clear();
                                  _farmerMobileController.clear();
                                  _aadhaarController.clear();
                                  _bankAccountController.clear();
                                  _ifscController.clear();
                                }
                              },
                              child: const Text("जतन करा"),
                            ),
                          ],
                        ),
                      ),
                    )

                  ),

                  const SizedBox(height: 16),
                  const Text(
                    "नोंदवलेले उत्पादक",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),

                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      itemCount: _savedFarmers.length,
                      itemBuilder: (context, index) {
                        final farmer = _savedFarmers[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            title: Text(farmer["नाव"] ?? ""),
                            subtitle: Text("गाव: ${farmer["गाव"]}, मोबाईल: ${farmer["मोबाईल"]}"),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _savedFarmers.removeAt(index);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),



          // SNF & FAT
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField("SNF", _rateChartSnfController),
                  _buildTextField("FAT", _rateChartFatController),
                  _buildTextField("दर (Rate)", _rateChartRateController),
                  _buildTextField("टीप (Remark)", _rateChartRemarkController),

                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      if (_rateChartSnfController.text.isNotEmpty &&
                          _rateChartFatController.text.isNotEmpty &&
                          _rateChartRateController.text.isNotEmpty) {
                        setState(() {
                          _savedRateCharts.add({
                            "SNF": _rateChartSnfController.text,
                            "FAT": _rateChartFatController.text,
                            "Rate": _rateChartRateController.text,
                            "Remark": _rateChartRemarkController.text,
                          });
                        });

                        // clear fields
                        _rateChartSnfController.clear();
                        _rateChartFatController.clear();
                        _rateChartRateController.clear();
                        _rateChartRemarkController.clear();
                      }
                    },
                    child: const Text("जतन करा"),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField("SNF", _snfFatSnfController),
                  _buildTextField("FAT", _snfFatFatController),
                  _buildTextField("CLR", _snfFatClrController),
                  _buildTextField("टीप (Remark)", _snfFatRemarkController),

                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      if (_snfFatSnfController.text.isNotEmpty &&
                          _snfFatFatController.text.isNotEmpty) {
                        setState(() {
                          _savedSnfFatRecords.add({
                            "SNF": _snfFatSnfController.text,
                            "FAT": _snfFatFatController.text,
                            "CLR": _snfFatClrController.text,
                            "Remark": _snfFatRemarkController.text,
                          });
                        });

                        // clear fields
                        _snfFatSnfController.clear();
                        _snfFatFatController.clear();
                        _snfFatClrController.clear();
                        _snfFatRemarkController.clear();
                      }
                    },
                    child: const Text("जतन करा"),
                  ),
                ],
              ),
            ),
          ),


          // संकलन केंद्र
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField("केंद्र आयडी", _collectionCenterIdController),
                  _buildTextField("केंद्राचे नाव", _collectionCenterNameController),
                  _buildTextField("पत्ता", _collectionCenterAddressController),
                  _buildTextField("प्रमुख व्यक्तीचे नाव", _collectionCenterInchargeController),
                  _buildTextField("संपर्क मोबाईल", _collectionCenterMobileController),
                  _buildTextField("टीप (Remark)", _collectionCenterRemarkController),

                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      if (_collectionCenterNameController.text.isNotEmpty) {
                        setState(() {
                          _savedCenters.add({
                            "ID": _collectionCenterIdController.text,
                            "नाव": _collectionCenterNameController.text,
                            "पत्ता": _collectionCenterAddressController.text,
                            "प्रमुख": _collectionCenterInchargeController.text,
                            "मोबाईल": _collectionCenterMobileController.text,
                            "टीप": _collectionCenterRemarkController.text,
                          });
                        });

                        // clear fields
                        _collectionCenterIdController.clear();
                        _collectionCenterNameController.clear();
                        _collectionCenterAddressController.clear();
                        _collectionCenterInchargeController.clear();
                        _collectionCenterMobileController.clear();
                        _collectionCenterRemarkController.clear();
                      }
                    },
                    child: const Text("जतन करा"),
                  ),
                ],
              ),
            ),
          ),



          // खातेवही सेटिंग्ज
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField("खाते क्रमांक", _ledgerAccountNumberController),
                  _buildTextField("बँकेचे नाव", _ledgerBankNameController),
                  _buildTextField("शाखा", _ledgerBranchController),
                  _buildTextField("IFSC कोड", _ledgerIfscController),
                  _buildTextField("खाते प्रकार (Saving/Current)", _ledgerAccountTypeController),
                  _buildTextField("टीप (Remark)", _ledgerRemarkController),

                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      if (_ledgerAccountNumberController.text.isNotEmpty) {
                        setState(() {
                          _savedLedgers.add({
                            "खाते क्रमांक": _ledgerAccountNumberController.text,
                            "बँक": _ledgerBankNameController.text,
                            "शाखा": _ledgerBranchController.text,
                            "IFSC": _ledgerIfscController.text,
                            "प्रकार": _ledgerAccountTypeController.text,
                            "टीप": _ledgerRemarkController.text,
                          });
                        });

                        // Clear fields
                        _ledgerAccountNumberController.clear();
                        _ledgerBankNameController.clear();
                        _ledgerBranchController.clear();
                        _ledgerIfscController.clear();
                        _ledgerAccountTypeController.clear();
                        _ledgerRemarkController.clear();
                      }
                    },
                    child: const Text("जतन करा"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
