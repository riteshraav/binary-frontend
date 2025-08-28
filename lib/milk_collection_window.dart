import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MilkCollectionWindow extends StatefulWidget {
  const MilkCollectionWindow({super.key});

  @override
  State<MilkCollectionWindow> createState() => _MilkCollectionWindowState();
}

class _MilkCollectionWindowState extends State<MilkCollectionWindow> {
  String selectedAnimal = "गाय";

  final TextEditingController _farmerNameController = TextEditingController();
  final TextEditingController _fatController = TextEditingController();
  final TextEditingController _snfController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // qty बदलला की calculation कर
    _qtyController.addListener(calculateRateAndAmount);
    _fatController.addListener(calculateRateAndAmount);
    _snfController.addListener(calculateRateAndAmount);
  }

  Future<void> calculateRateAndAmount() async {
    double fat = double.tryParse(_fatController.text) ?? 0;
    double snf = double.tryParse(_snfController.text) ?? 0;
    double qty = double.tryParse(_qtyController.text) ?? 0;

    final prefs = await SharedPreferences.getInstance();
    String? rateData = prefs.getString("rate_data_$selectedAnimal");

    print("➡️ Animal: $selectedAnimal | Fat=$fat | SNF=$snf | Qty=$qty");
    print("➡️ Loaded RateData: $rateData");

    double rate = 0;
    if (rateData != null) {
      Map<String, dynamic> data = jsonDecode(rateData);

      double fatMin = (data['fatMin'] ?? 0).toDouble();
      double fatMax = (data['fatMax'] ?? 0).toDouble();
      double snfMin = (data['snfMin'] ?? 0).toDouble();
      double snfMax = (data['snfMax'] ?? 0).toDouble();
      double rateMin = (data['rateMin'] ?? 0).toDouble();
      double rateMax = (data['rateMax'] ?? 0).toDouble();

      print("➡️ Range: Fat($fatMin-$fatMax) SNF($snfMin-$snfMax) Rate($rateMin-$rateMax)");

      if (fat >= fatMin && fat <= fatMax && snf >= snfMin && snf <= snfMax) {
        double fatRatio = (fatMax != fatMin) ? (fat - fatMin) / (fatMax - fatMin) : 0;
        double snfRatio = (snfMax != snfMin) ? (snf - snfMin) / (snfMax - snfMin) : 0;
        double avgRatio = (fatRatio + snfRatio) / 2;

        rate = rateMin + (rateMax - rateMin) * avgRatio;
        print("✅ Calculated Rate: $rate");
      } else {
        print("❌ Fat/SNF range बाहेर");
      }
    }

    double amount = qty * rate;

    setState(() {
      _rateController.text = rate.toStringAsFixed(2);
      _amountController.text = amount.toStringAsFixed(2);
    });
  }

  Widget buildTextField(String label, TextEditingController controller,
      {bool readOnly = false}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: TextField(
          controller: controller,
          readOnly: readOnly,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("दूध संकलन"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // प्राणी निवड
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: selectedAnimal,
                  items: ["गाय", "म्हैस"]
                      .map((a) => DropdownMenuItem(value: a, child: Text(a)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        selectedAnimal = val;
                        calculateRateAndAmount();
                      });
                    }
                  },
                ),
              ),
            ),

            buildTextField("शेतकरी नाव", _farmerNameController),
            buildTextField("फॅट", _fatController),
            buildTextField("SNF", _snfController),
            buildTextField("लिटर", _qtyController),
            buildTextField("दर", _rateController, readOnly: true),
            buildTextField("एकूण रक्कम", _amountController, readOnly: true),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                if (_amountController.text.isEmpty ||
                    double.tryParse(_amountController.text) == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("❌ कृपया योग्य माहिती भरा")),
                  );
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("✅ दूध नोंद झाली")),
                );
              },
              child: const Text("जतन करा"),
            ),
          ],
        ),
      ),
    );
  }
}
