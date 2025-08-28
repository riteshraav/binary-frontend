import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/buffalo_ratechart_provider.dart';
import '../providers/cow_rate_chart_provider.dart';
import 'excel_viewer_screen.dart';

class MilkCollectionScreen extends StatefulWidget {
  const MilkCollectionScreen({super.key});

  @override
  State<MilkCollectionScreen> createState() => _MilkCollectionScreenState();
}

class _MilkCollectionScreenState extends State<MilkCollectionScreen> {
  final TextEditingController _fatController = TextEditingController();
  final TextEditingController _snfController = TextEditingController();
  final TextEditingController _litresController = TextEditingController();
  final TextEditingController _rateController = TextEditingController(text: "0.00");
  final TextEditingController _amountController = TextEditingController(text: "0.00");

  String? _selectedType; // Cow / Buffalo

  @override
  void initState() {
    super.initState();
    _selectedType = "Cow"; // default
  }

  void _calculateRate() {
    if (_selectedType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("प्रथम प्रकार निवडा (गाय/म्हैस) ❌")),
      );
      return;
    }

    double fat = double.tryParse(_fatController.text) ?? 0;
    double snf = double.tryParse(_snfController.text) ?? 0;
    double litres = double.tryParse(_litresController.text) ?? 0;

    double rate = 0;

    if (_selectedType == "Cow") {
      final cowProvider = context.read<CowRateChartProvider>();
      rate = cowProvider.findRate(fat, snf);
    } else if (_selectedType == "Buffalo") {
      final buffaloProvider = context.read<BuffaloRatechartProvider>();
      rate = buffaloProvider.findRate(fat, snf);
    }

    double amount = rate * litres;

    setState(() {
      _rateController.text = rate.toStringAsFixed(2);
      _amountController.text = amount.toStringAsFixed(2);
    });
  }

  void _viewRateChart() {
    if (_selectedType == null) return;

    List<List<dynamic>> tableData = [];
    String title = "";

    if (_selectedType == "Cow") {
      final cowProvider = context.read<CowRateChartProvider>();
      tableData = cowProvider.tableData;
      title = "Cow Rate Chart";
    } else if (_selectedType == "Buffalo") {
      final buffaloProvider = context.read<BuffaloRatechartProvider>();
      tableData = buffaloProvider.tableData;
      title = "Buffalo Rate Chart";
    }

    if (tableData.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Rate Chart not available ❌")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ExcelViewerScreen(title: title, data: tableData),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType type = TextInputType.number, bool readOnly = false}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: TextField(
          controller: controller,
          keyboardType: type,
          readOnly: readOnly,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("दूध संकलन")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Dropdown for Type
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: DropdownButtonFormField<String>(
                value: _selectedType,
                hint: const Text("प्रकार निवडा"),
                items: ["Cow", "Buffalo"].map((e) {
                  return DropdownMenuItem(value: e, child: Text(e));
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedType = val;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  labelText: "प्रकार",
                ),
              ),
            ),

            // FAT & SNF
            Row(
              children: [
                _buildTextField("FAT", _fatController),
                _buildTextField("SNF", _snfController),
              ],
            ),

            // Litres
            Row(
              children: [
                _buildTextField("लिटर", _litresController),
              ],
            ),

            // Rate & Amount
            Row(
              children: [
                _buildTextField("रेट", _rateController, readOnly: true),
                _buildTextField("एकूण रक्कम", _amountController, readOnly: true),
              ],
            ),

            const SizedBox(height: 10),

            // Buttons: Calculate & View Rate Chart
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _calculateRate,
                    icon: const Icon(Icons.calculate),
                    label: const Text("कॅल्क्युलेट करा"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _viewRateChart,
                    icon: const Icon(Icons.table_view),
                    label: const Text("Rate Chart पहा"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
