import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:windows_sample/model/supplier_model.dart';
import 'package:windows_sample/service/supplier_service.dart';
import 'package:windows_sample/isar_repository/supplier_isar_repository.dart';
import '../isar_repository/item_purchase_isar_repository.dart';
import '../model/item_purchase_model.dart';

import '../service/isar_service.dart';
import '../service/item_purchase_service.dart';
import 'home_window.dart';

class ItemPurchaseWindow extends StatefulWidget {
  const ItemPurchaseWindow({Key? key}) : super(key: key);

  @override
  State<ItemPurchaseWindow> createState() => _ItemPurchaseWindowState();
}

class _ItemPurchaseWindowState extends State<ItemPurchaseWindow> {
  // Controllers
  final TextEditingController voucherNoController = TextEditingController();
  final TextEditingController voucherNumController = TextEditingController();
  final TextEditingController seqNoController = TextEditingController();
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController vatController = TextEditingController();
  final TextEditingController commissionController = TextEditingController();
  final TextEditingController hamaliController = TextEditingController();
  final TextEditingController totalAmountController = TextEditingController();
  final TextEditingController billAmountController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController supplierCodeController = TextEditingController();
  final TextEditingController supplierNameController = TextEditingController();

  String? paymentType = "उधार";
  DateTime selectedDate = DateTime.now();

  // Services
  late ItemPurchaseService _purchaseService;
  late SupplierService _supplierService;


  List<ItemPurchase> purchaseRows = [];
  List<Supplier> suppliers = [];
  bool isLoading = false;

  // Editing state
  bool isEditing = false;
  int? editingPurchaseId;
  int? editingSupplierId;

  // Dropdown values
  Supplier? selectedSupplier;
  String? selectedSupplierCode;

  @override
  void dispose() {
    voucherNoController.dispose();
    voucherNumController.dispose();
    supplierCodeController.dispose();
    supplierNameController.dispose();
    seqNoController.dispose();
    itemNameController.dispose();
    qtyController.dispose();
    rateController.dispose();
    amountController.dispose();
    vatController.dispose();
    commissionController.dispose();
    hamaliController.dispose();
    totalAmountController.dispose();
    billAmountController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    try {
      // Always initialize Isar first
      await IsarService.initialize();

      final isar = IsarService.getInstance();
      final purchaseRepo = ItemPurchaseIsarRepository(isar);
      final supplierRepo = SupplierIsarRepository(isar);

      _purchaseService = ItemPurchaseService(purchaseRepo);
      _supplierService = SupplierService(supplierRepo);

      _loadPurchases();
      _loadSuppliers();
    } catch (e) {
      print("Error initializing services: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("सेवा सुरू करण्यात त्रुटी: $e")),
        );
      }
    }
  }

// Remove the _initializeIsarAndServices method entirely

  Future<void> _initializeIsarAndServices() async {
    try {
      await IsarService.initialize();
      final isar = IsarService.getInstance();
      final purchaseRepo = ItemPurchaseIsarRepository(isar);
      final supplierRepo = SupplierIsarRepository(isar);

      _purchaseService = ItemPurchaseService(purchaseRepo);
      _supplierService = SupplierService(supplierRepo);

      _loadPurchases();
      _loadSuppliers();
    } catch (e) {
      print("Error initializing Isar: $e");
    }
  }

  Future<void> _loadPurchases() async {
    if (mounted) {
      setState(() => isLoading = true);
    }

    try {
      final data = await _purchaseService.fetchPurchases();
      if (mounted) {
        setState(() {
          purchaseRows = data;
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error loading purchases: $e");
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> _loadSuppliers() async {
    try {
      final data = await _supplierService.getSuppliers();
      if (mounted) {
        setState(() {
          suppliers = data;
        });
      }
    } catch (e) {
      print("Error loading suppliers: $e");
    }
  }

  void _clearForm() {
    voucherNoController.clear();
    voucherNumController.clear();
    supplierCodeController.clear();
    supplierNameController.clear();
    seqNoController.clear();
    itemNameController.clear();
    qtyController.clear();
    rateController.clear();
    amountController.clear();
    vatController.clear();
    commissionController.clear();
    hamaliController.clear();
    totalAmountController.clear();
    billAmountController.clear();
    detailsController.clear();

    if (mounted) {
      setState(() {
        paymentType = "उधार";
        selectedDate = DateTime.now();
        isEditing = false;
        editingPurchaseId = null;
        editingSupplierId = null;
        selectedSupplier = null;
        selectedSupplierCode = null;
      });
    }
  }

  void _loadPurchaseForEditing(ItemPurchase purchase) async {
    try {
      voucherNoController.text = purchase.voucherNo;
      voucherNumController.text = purchase.voucherNum;
      seqNoController.text = purchase.seqNo;
      itemNameController.text = purchase.itemName;
      qtyController.text = purchase.qty;
      rateController.text = purchase.rate;
      amountController.text = purchase.amount;
      vatController.text = purchase.vat;
      commissionController.text = purchase.commission;
      hamaliController.text = purchase.hamali;
      totalAmountController.text = purchase.totalAmount;
      billAmountController.text = purchase.billAmount;
      detailsController.text = purchase.details;

      if (mounted) {
        setState(() {
          paymentType = purchase.paymentType;
          selectedDate = purchase.date;
          isEditing = true;
          editingPurchaseId = purchase.id;
        });
      }

      // Load supplier data
      await purchase.supplier.load();
      final supplier = purchase.supplier.value;
      if (supplier != null) {
        supplierCodeController.text = supplier.code;
        supplierNameController.text = supplier.name;
        editingSupplierId = supplier.id;
        selectedSupplier = supplier;
        selectedSupplierCode = supplier.code;
      }
    } catch (e) {
      print("Error loading purchase for editing: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("त्रुटी: ${e.toString()}")),
      );
    }
  }

  Future<void> _savePurchase() async {
    try {
      final isar = IsarService.getInstance();

      if (voucherNoController.text.isEmpty || itemNameController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("कृपया नोंद क्र. आणि मालाचे नाव प्रविष्ट करा")),
        );
        return;
      }

      await isar.writeTxn(() async {
        // Handle Supplier
        Supplier? supplier;
        if (supplierCodeController.text.isNotEmpty && supplierNameController.text.isNotEmpty) {
          supplier = Supplier()
            ..id = editingSupplierId ?? Isar.autoIncrement
            ..code = supplierCodeController.text
            ..name = supplierNameController.text;

          await isar.suppliers.put(supplier);
        }

        // Create/Update Purchase
        final purchase = ItemPurchase()
          ..id = isEditing ? editingPurchaseId! : Isar.autoIncrement
          ..voucherNo = voucherNoController.text
          ..paymentType = paymentType!
          ..date = selectedDate
          ..voucherNum = voucherNumController.text
          ..seqNo = seqNoController.text
          ..itemName = itemNameController.text
          ..qty = qtyController.text
          ..rate = rateController.text
          ..amount = amountController.text
          ..vat = vatController.text
          ..commission = commissionController.text
          ..hamali = hamaliController.text
          ..totalAmount = totalAmountController.text
          ..billAmount = billAmountController.text
          ..details = detailsController.text;

        if (supplier != null) {
          purchase.supplier.value = supplier;
        }

        await isar.itemPurchases.put(purchase);
      });

      await _loadPurchases();
      await _loadSuppliers();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(isEditing ? "माहिती अद्यतन झाली" : "माहिती जतन झाली")),
      );

      _clearForm();

    } catch (e) {
      print("Error saving purchase: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("त्रुटी: ${e.toString()}")),
      );
    }
  }

  Future<void> _addSupplier() async {
    if (supplierCodeController.text.isEmpty || supplierNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("कृपया कोड आणि पुरवठादाराचे नाव प्रविष्ट करा")),
      );
      return;
    }

    try {
      await _supplierService.addSupplier(
          supplierCodeController.text,
          supplierNameController.text
      );

      await _loadSuppliers();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("पुरवठादार जतन झाला: ${supplierCodeController.text}")),
      );
    } catch (e) {
      print("Error adding supplier: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("त्रुटी: ${e.toString()}")),
      );
    }
  }

  Future<void> _editSupplier() async {
    if (selectedSupplier == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("कृपया संपादन करण्यासाठी पुरवठादार निवडा")),
      );
      return;
    }

    if (supplierCodeController.text.isEmpty || supplierNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("कृपया कोड आणि पुरवठादाराचे नाव प्रविष्ट करा")),
      );
      return;
    }

    try {
      await _supplierService.updateSupplier(
          selectedSupplier!.id,
          supplierCodeController.text,
          supplierNameController.text
      );

      await _loadSuppliers();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("पुरवठादार अद्यतन झाला: ${supplierCodeController.text}")),
      );
    } catch (e) {
      print("Error editing supplier: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("त्रुटी: ${e.toString()}")),
      );
    }
  }

  void _onSupplierSelected(Supplier? supplier) {
    if (supplier != null) {
      setState(() {
        selectedSupplier = supplier;
        selectedSupplierCode = supplier.code;
        supplierCodeController.text = supplier.code;
        supplierNameController.text = supplier.name;
        editingSupplierId = supplier.id;
      });
    }
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
                // Header
                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text(
                          isEditing ? "माल खरेदी - संपादन" : "माल खरेदी",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        if (isEditing)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(Icons.edit, color: Colors.orange, size: 16),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Record Information
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
                                  Row(
                                    children: [
                                      Flexible(
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

                                      Flexible(
                                        child: InkWell(
                                          onTap: () async {
                                            final picked = await showDatePicker(
                                              context: context,
                                              initialDate: selectedDate,
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(2100),
                                            );
                                            if (picked != null && mounted) {
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
                                              "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
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

                                  // Supplier Section with Dropdown
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Code Dropdown
                                      SizedBox(
                                        width: 120,
                                        child: DropdownButtonFormField<String>(
                                          value: selectedSupplierCode,
                                          decoration: InputDecoration(
                                            labelText: "कोड निवडा",
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                              borderSide: const BorderSide(color: Color(0xFF2563EB)),
                                            ),
                                          ),
                                          items: suppliers.map((supplier) {
                                            return DropdownMenuItem<String>(
                                              value: supplier.code,
                                              child: Text(supplier.code, style: TextStyle(fontSize: 12)),
                                            );
                                          }).toList(),
                                          onChanged: (code) {
                                            final supplier = suppliers.firstWhere(
                                                    (s) => s.code == code,
                                                orElse: () => Supplier()..code = ""..name = ""
                                            );
                                            _onSupplierSelected(supplier.code.isNotEmpty ? supplier : null);
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 16),

                                      // Supplier Name Dropdown
                                      Expanded(
                                        child: DropdownButtonFormField<Supplier>(
                                          value: selectedSupplier,
                                          decoration: InputDecoration(
                                            labelText: "पुरवठादार निवडा",
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                              borderSide: const BorderSide(color: Color(0xFF2563EB)),
                                            ),
                                          ),
                                          items: suppliers.map((supplier) {
                                            return DropdownMenuItem<Supplier>(
                                              value: supplier,
                                              child: Text(supplier.name, style: TextStyle(fontSize: 12)),
                                            );
                                          }).toList(),
                                          onChanged: _onSupplierSelected,
                                        ),
                                      ),
                                      const SizedBox(width: 10),

                                      // Manual Code Input
                                      SizedBox(
                                        width: 80,
                                        child: TextField(
                                          controller: supplierCodeController,
                                          decoration: InputDecoration(
                                            labelText: "कोड",
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                              borderSide: const BorderSide(color: Color(0xFF2563EB)),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              selectedSupplierCode = value;
                                              selectedSupplier = null;
                                            });
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 10),

                                      // Manual Name Input
                                      Expanded(
                                        child: TextField(
                                          controller: supplierNameController,
                                          decoration: InputDecoration(
                                            labelText: "पुरवठादार",
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

                                      // Add Button
                                      IconButton(
                                        icon: Icon(Icons.add_circle, color: Colors.green),
                                        onPressed: _addSupplier,
                                      ),

                                      // Edit Button
                                      IconButton(
                                        icon: Icon(Icons.edit, color: Colors.blue),
                                        onPressed: _editSupplier,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Item Information Section (keep your existing item information section)
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
                                  Row(
                                    children: [
                                      Flexible(
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
                                      Flexible(
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
                                      Flexible(
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
                                      const SizedBox(width: 10),

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
                                    ],
                                  ),
                                  const SizedBox(height: 10),

                                  //ROW 2
                                  Row(
                                    children: [
                                      Flexible(
                                        child: TextField(
                                          controller: commissionController,
                                          decoration: InputDecoration(
                                            labelText: "कमिशन",
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
                                          controller: hamaliController,
                                          decoration: InputDecoration(
                                            labelText: "हमाली",
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
                                      Flexible(
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
                                      Flexible(
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

                        // Buttons Row (keep your existing buttons)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
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
                              onPressed: _clearForm,
                            ),

                            // Save/Update Button
                            ElevatedButton.icon(
                              icon: Icon(isEditing ? Icons.update : Icons.check_circle,
                                  color: Colors.white),
                              label: Text(isEditing ? "अद्यतन करा" : "जतन करा"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isEditing ? Colors.orange.shade600 : Colors.green.shade600,
                                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: _savePurchase,
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
                              onPressed: purchaseRows.isEmpty
                                  ? null
                                  : () async {
                                try {
                                  if (purchaseRows.isNotEmpty) {
                                    final lastPurchase = purchaseRows.last;
                                    await _purchaseService.deletePurchase(lastPurchase.id!);
                                    await _loadPurchases();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("नोंद हटवली गेली")),
                                    );
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("त्रुटी: ${e.toString()}")),
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
                              onPressed: purchaseRows.isEmpty ? null : () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("नोंद निवडा"),
                                    content: Container(
                                      width: double.maxFinite,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: purchaseRows.length,
                                        itemBuilder: (context, index) {
                                          final purchase = purchaseRows[index];
                                          return ListTile(
                                            title: Text("${purchase.voucherNo} - ${purchase.itemName}"),
                                            subtitle: Text("तारीख: ${purchase.date?.toString().substring(0, 10) ?? ''}"),
                                            onTap: () {
                                              Navigator.pop(context);
                                              _loadPurchaseForEditing(purchase);
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text("रद्द करा"),
                                      ),
                                    ],
                                  ),
                                );
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
                        const SizedBox(height: 30),

                        // Table for entered items
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: purchaseRows.isEmpty
                              ? const Center(child: Text("अद्याप कोई नोंद नाही"))
                              : ListView.builder(
                            itemCount: purchaseRows.length,
                            itemBuilder: (context, index) {
                              final row = purchaseRows[index];
                              return ListTile(
                                title: Text("नोंद क्र: ${row.voucherNo} - माल: ${row.itemName}"),
                                subtitle: Text("नग: ${row.qty} - दर: ${row.rate} - रक्कम: ${row.amount}"),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit, color: Colors.blue),
                                      onPressed: () => _loadPurchaseForEditing(row),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red),
                                      onPressed: () async {
                                        await _purchaseService.deletePurchase(row.id!);
                                        await _loadPurchases();
                                      },
                                    ),
                                  ],
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