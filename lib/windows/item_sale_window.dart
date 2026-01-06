import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:windows_sample/repository/item_sale_repository.dart';
import '../model/item_sale_model.dart';
import '../isar_repository/item_sale_isar_repository.dart';
import '../service/item_sale_service.dart';
import 'home_window.dart';
import 'package:isar/isar.dart';

class ItemSaleWindow extends StatefulWidget {
  const ItemSaleWindow({Key? key}) : super(key: key);

  @override
  State<ItemSaleWindow> createState() => _ItemSaleWindowState();
}

class _ItemSaleWindowState extends State<ItemSaleWindow> {
  // Controllers
  final TextEditingController voucherNoController = TextEditingController();
  final TextEditingController voucherNumController = TextEditingController();
  final TextEditingController customerController = TextEditingController();
  final TextEditingController seqNoController = TextEditingController();
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController vatController = TextEditingController();
  final TextEditingController bhadeController = TextEditingController();
  final TextEditingController totalAmountController = TextEditingController();
  final TextEditingController billAmountController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  String? paymentType = "उधार";
  bool receiptPrint = false;
  DateTime selectedDate = DateTime.now();

  late ItemSaleService _saleService;
  List<ItemSale> saleRows = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final isar = Isar.getInstance()!;
    final repo = ItemSaleIsarRepository(isar);

    _saleService = ItemSaleService(repo as ItemSaleRepository);
    _loadSales();
  }

  Future<void> _loadSales() async {
    setState(() => isLoading = true);
    try {
      final data = await _saleService.fetchSales();
      setState(() {
        saleRows = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  InputDecoration _roundedDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
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
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.point_of_sale, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text(
                          "माल विक्री",
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

                // Main content area
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Panel 1 : ग्राहक माहिती
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFEBF4FF), Color(0xFFDBEAFE)],
                            ),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0xFF93C5FD), width: 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.receipt_long, color: Color(0xFF2563EB), size: 16),
                                  SizedBox(width: 6),
                                  Text(
                                    'नोंद माहिती',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1E3A8A),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),

                              Column(
                                children: [
                                  // Row 1
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: voucherNoController,
                                          decoration: InputDecoration(
                                            labelText: "नोंद क्र.",
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                              borderSide: const BorderSide(color: Color(0xFF2563EB)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),

                                      Expanded(
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: RadioListTile<String>(
                                                dense: true,
                                                contentPadding: EdgeInsets.zero,
                                                title: const Text("उधार", style: TextStyle(fontSize: 13)),
                                                value: "उधार",
                                                groupValue: paymentType,
                                                onChanged: (val) => setState(() => paymentType = val),
                                              ),
                                            ),
                                            Flexible(
                                              child: RadioListTile<String>(
                                                dense: true,
                                                contentPadding: EdgeInsets.zero,
                                                title: const Text("रोख", style: TextStyle(fontSize: 13)),
                                                value: "रोख",
                                                groupValue: paymentType,
                                                onChanged: (val) => setState(() => paymentType = val),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),

                                      Expanded(
                                        child: InkWell(
                                          onTap: () async {
                                            final picked = await showDatePicker(
                                              context: context,
                                              initialDate: selectedDate,
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(2100),
                                            );
                                            if (picked != null) {
                                              setState(() => selectedDate = picked);
                                            }
                                          },
                                          child: InputDecorator(
                                            decoration: InputDecoration(
                                              labelText: "दिनांक",
                                              filled: true,
                                              fillColor: Colors.white,
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(6),
                                                borderSide: const BorderSide(color: Color(0xFF2563EB)),
                                              ),
                                            ),
                                            child: Text(
                                              DateFormat("dd/MM/yyyy").format(selectedDate),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 50),

                                      Expanded(
                                        child: TextField(
                                          controller: voucherNumController,
                                          decoration: InputDecoration(
                                            labelText: "व्हौचर नं.",
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                              borderSide: const BorderSide(color: Color(0xFF2563EB)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),

                                  // Row 2
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: TextField(
                                          controller: customerController,
                                          decoration: InputDecoration(
                                            labelText: "ग्राहक",
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                              borderSide: const BorderSide(color: Color(0xFF2563EB)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Checkbox(
                                        value: receiptPrint,
                                        onChanged: (val) => setState(() => receiptPrint = val ?? false),
                                      ),
                                      const Text("पावती प्रिंट"),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Panel 2 : माल माहिती
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFEBF4FF), Color(0xFFDBEAFE)],
                            ),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0xFF93C5FD), width: 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.inventory_2, color: Color(0xFF2563EB), size: 16),
                                  SizedBox(width: 6),
                                  Text(
                                    'माल माहिती',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1E3A8A),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              Column(
                                children: [
                                  // Row 1
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: seqNoController,
                                          decoration: InputDecoration(
                                            labelText: "अनु. नं.",
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                              borderSide: const BorderSide(color: Color(0xFF2563EB)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),

                                      Expanded(
                                        flex: 2,
                                        child: TextField(
                                          controller: itemNameController,
                                          decoration: InputDecoration(
                                            labelText: "माल",
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                              borderSide: const BorderSide(color: Color(0xFF2563EB)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: TextField(
                                          controller: qtyController,
                                          decoration: InputDecoration(
                                            labelText: "नग",
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                              borderSide: const BorderSide(color: Color(0xFF2563EB)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: TextField(
                                          controller: rateController,
                                          decoration: InputDecoration(
                                            labelText: "दर",
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                              borderSide: const BorderSide(color: Color(0xFF2563EB)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: TextField(
                                          controller: amountController,
                                          decoration: InputDecoration(
                                            labelText: "रक्कम",
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                              borderSide: const BorderSide(color: Color(0xFF2563EB)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),

                                  // Row 2
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: vatController,
                                          decoration: InputDecoration(
                                            labelText: "वॅट %",
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                              borderSide: const BorderSide(color: Color(0xFF2563EB)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: TextField(
                                          controller: bhadeController,
                                          decoration: InputDecoration(
                                            labelText: "भाडे",
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                              borderSide: const BorderSide(color: Color(0xFF2563EB)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: TextField(
                                          controller: totalAmountController,
                                          decoration: InputDecoration(
                                            labelText: "एकूण रक्कम",
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                              borderSide: const BorderSide(color: Color(0xFF2563EB)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: TextField(
                                          controller: billAmountController,
                                          decoration: InputDecoration(
                                            labelText: "बिल रक्कम",
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                              borderSide: const BorderSide(color: Color(0xFF2563EB)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        flex: 2,
                                        child: TextField(
                                          controller: detailsController,
                                          decoration: InputDecoration(
                                            labelText: "तपशील",
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                              borderSide: const BorderSide(color: Color(0xFF2563EB)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Buttons Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // New Button
                            ElevatedButton.icon(
                              icon: const Icon(Icons.note_add),
                              label: const Text("नवीन"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade50,
                                foregroundColor: Colors.blue.shade700,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                try {
                                  // Clear all form fields
                                  voucherNoController.clear();
                                  voucherNumController.clear();
                                  customerController.clear();
                                  seqNoController.clear();
                                  itemNameController.clear();
                                  qtyController.clear();
                                  rateController.clear();
                                  amountController.clear();
                                  vatController.clear();
                                  bhadeController.clear();
                                  totalAmountController.clear();
                                  billAmountController.clear();
                                  detailsController.clear();

                                  // Reset payment type, receipt print and date
                                  setState(() {
                                    paymentType = "उधार";
                                    receiptPrint = false;
                                    selectedDate = DateTime.now();
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("नवीन नोंद सुरु झाली")),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Error: ${e.toString()}")),
                                  );
                                }
                              },
                            ),

                            // Save Button
                            ElevatedButton.icon(
                              icon: const Icon(Icons.check_circle, color: Colors.white),
                              label: const Text("जतन करा"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green.shade600,
                                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () async {
                                try {
                                  // Create sale model
                                  final sale = ItemSale()
                                    ..voucherNo = voucherNoController.text
                                    ..voucherNum = voucherNumController.text
                                    ..customer = customerController.text
                                    ..seqNo = seqNoController.text
                                    ..itemName = itemNameController.text
                                    ..qty = qtyController.text
                                    ..rate = rateController.text
                                    ..amount = amountController.text
                                    ..vat = vatController.text
                                    ..bhade = bhadeController.text
                                    ..totalAmount = totalAmountController.text
                                    ..billAmount = billAmountController.text
                                    ..details = detailsController.text
                                    ..paymentType = paymentType
                                    //..receiptPrint = receiptPrint
                                    ..date = selectedDate;

                                  // Save to database
                                  await _saleService.addSale(sale);

                                  // Refresh the list
                                  _loadSales();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("माहिती जतन झाली")),
                                  );

                                  // Clear form for new entry
                                  voucherNoController.clear();
                                  voucherNumController.clear();
                                  customerController.clear();
                                  seqNoController.clear();
                                  itemNameController.clear();
                                  qtyController.clear();
                                  rateController.clear();
                                  amountController.clear();
                                  vatController.clear();
                                  bhadeController.clear();
                                  totalAmountController.clear();
                                  billAmountController.clear();
                                  detailsController.clear();

                                  // Reset to default values
                                  setState(() {
                                    paymentType = "उधार";
                                    receiptPrint = false;
                                    selectedDate = DateTime.now();
                                  });

                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Error: ${e.toString()}")),
                                  );
                                }
                              },
                            ),

                            // Delete Button
                            ElevatedButton.icon(
                              icon: const Icon(Icons.delete, color: Colors.white),
                              label: const Text("हटवा"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade600,
                                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: saleRows.isEmpty
                                  ? null
                                  : () async {
                                try {
                                  // Delete the last sale
                                  if (saleRows.isNotEmpty) {
                                    final lastSale = saleRows.last;
                                    await _saleService.deleteSaleById(lastSale.id!);
                                    _loadSales();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("नोंद हटवली गेली")),
                                    );
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Error: ${e.toString()}")),
                                  );
                                }
                              },
                            ),

                            // Edit Button
                            ElevatedButton.icon(
                              icon: const Icon(Icons.edit),
                              label: const Text("संपादन"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange.shade600,
                                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                if (saleRows.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("संपादन करण्यासाठी आधी आयटम निवडा")),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("संपादन सुरु झाले — बदल करा आणि जतन करा")),
                                  );
                                }
                              },
                            ),

                            // Close Button
                            ElevatedButton.icon(
                              icon: const Icon(Icons.stop_circle, color: Colors.red),
                              label: const Text("बंद"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.red,
                                side: const BorderSide(color: Colors.red),
                                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => HomeScreen()),
                                );
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Table area
                        Container(
                          height: 200,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: saleRows.isEmpty
                              ? const Center(child: Text("अद्याप कोई नोंद नाही"))
                              : ListView.builder(
                            itemCount: saleRows.length,
                            itemBuilder: (context, index) {
                              final row = saleRows[index];
                              return ListTile(
                                title: Text("Item: ${row.itemName} | Qty: ${row.qty}"),
                                subtitle: Text("Rate: ${row.rate} | Amount: ${row.amount}"),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    await _saleService.deleteSaleById(row.id!);
                                    _loadSales();
                                  },
                                ),
                              );
                            },
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
    );
  }
}