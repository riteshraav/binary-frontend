/*
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/item_info_model.dart';
import '../riverpod/providers.dart';
import 'home_window.dart';

class ItemInfoWindow extends ConsumerStatefulWidget {
  const ItemInfoWindow({Key? key}) : super(key: key);

  @override
  ConsumerState<ItemInfoWindow> createState() => _ItemInfoWindowState();
}

class _ItemInfoWindowState extends ConsumerState<ItemInfoWindow> {
  // state
  String? selectedItemCode;
  String? selectedItemName;
  String? selectedUnit;

  final TextEditingController openingQtyController = TextEditingController();
  final TextEditingController minQtyController = TextEditingController();
  final TextEditingController purchaseRateController = TextEditingController();
  final TextEditingController currentQtyController = TextEditingController();
  final TextEditingController sellingRateController = TextEditingController();
  final TextEditingController vatController = TextEditingController();

  String? purchaseAccount;
  String? salesAccount;
  String? creditSalesAccount;

  // track currently editing item id (null => new)
  int? editingId;

  @override
  void initState() {
    super.initState();

    // Load items into provider when window opens
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final service = ref.read(itemInfoServiceProvider);
      final items = await service.getItems();
      ref.read(itemListProvider.notifier).state = items;
    });

    // Add listeners to auto-calculate amount
    openingQtyController.addListener(_calculateAmount);
    purchaseRateController.addListener(_calculateAmount);
  }

  void _calculateAmount() {
    final opening = double.tryParse(openingQtyController.text) ?? 0;
    final rate = double.tryParse(purchaseRateController.text) ?? 0;
    final total = opening * rate;

    // Update रक्कम (currentQtyController)
    currentQtyController.text = total.toStringAsFixed(2);
  }

  String? _getValidNameValue() {
    if (selectedItemName == null || selectedItemName!.isEmpty) {
      return null;
    }

    // Check if the current name exists in items
    final existsInItems = ref.read(itemListProvider).any((item) => item.name == selectedItemName);

    if (existsInItems) {
      return selectedItemName;
    } else {
      // If it's a new name not in the list, return a special value or null
      return "__current__";
    }
  }

  List<DropdownMenuItem<String>> _buildNameDropdownItems() {
    final items = ref.read(itemListProvider);
    final dropdownItems = <DropdownMenuItem<String>>[];

    // Add existing unique names
    final uniqueNames = items.map((e) => e.name).toSet();
    dropdownItems.addAll(
      uniqueNames.map((name) => DropdownMenuItem(
        value: name,
        child: Text(name),
      )),
    );

    // Add current typed name if it's not in the list
    if (selectedItemName != null &&
        selectedItemName!.isNotEmpty &&
        !uniqueNames.contains(selectedItemName)) {
      dropdownItems.add(
        DropdownMenuItem(
          value: "__current__",
          child: Text("$selectedItemName (नवीन)"),
        ),
      );
    }

    // Add option to create new name
    dropdownItems.add(
      const DropdownMenuItem(
        value: "__new__",
        child: Text("नवीन नाव टाइप करा"),
      ),
    );

    return dropdownItems;
  }

  void _showNameInputDialog() {
    final nameController = TextEditingController(text: selectedItemName ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("नवीन मालाचे नाव"),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            hintText: "मालाचे नाव टाइप करा",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("रद्द करा"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                selectedItemName = nameController.text.trim();
              });
              Navigator.pop(context);
            },
            child: const Text("ठीक आहे"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // dispose controllers safely
    openingQtyController.removeListener(_calculateAmount);
    purchaseRateController.removeListener(_calculateAmount);
    super.dispose();
  }

  InputDecoration _roundedDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.blueAccent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    );
  }

  void clearFormForNew(String nextCode) {
    setState(() {
      selectedItemCode = nextCode;
      selectedItemName = null;
      selectedUnit = null;
      openingQtyController.clear();
      minQtyController.clear();
      purchaseRateController.clear();
      currentQtyController.clear();
      sellingRateController.clear();
      vatController.clear();
      purchaseAccount = null;
      salesAccount = null;
      creditSalesAccount = null;
      editingId = null;
    });
  }

  void fillFormFromItem(ItemInfoModel item) {
    setState(() {
      editingId = item.id;
      selectedItemCode = item.code;
      selectedItemName = item.name;
      selectedUnit = item.unit;
      openingQtyController.text = item.openingQty.toString();
      minQtyController.text = item.minQty.toString();
      purchaseRateController.text = item.purchaseRate.toString();
      currentQtyController.text = item.currentQty.toString();
      sellingRateController.text = item.sellingRate.toString();
      vatController.text = item.vat.toString();
      purchaseAccount = item.purchaseAccount;
      salesAccount = item.salesAccount;
      creditSalesAccount = item.creditSalesAccount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final service = ref.read(itemInfoServiceProvider);
    final items = ref.watch(itemListProvider);

    // compute next code locally if provider has data; fallback to service on actions
    final String computedNextCode = (() {
      if (items.isEmpty) return "1";
      final numericCodes = items
          .map((e) => int.tryParse(e.code) ?? 0)
          .toList();
      final maxCode = numericCodes.isEmpty ? 0 : numericCodes.reduce((a, b) => a > b ? a : b);
      return (maxCode + 1).toString();
    })();

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
            child: SingleChildScrollView(
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
                          Icon(Icons.inventory_2, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text(
                            "माल माहिती",
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

                  // Row 1 Box
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFEFF6FF), Color(0xFFDDEEFF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF2563EB), width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: const [
                              Icon(Icons.receipt_long, color: Color(0xFF1E3A8A), size: 18),
                              SizedBox(width: 6),
                              Text(
                                "नोंद माहिती",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E3A8A),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Row 1: Item Code, Item Name, Unit
                        Row(
                          children: [
                            // Code Dropdown (dynamic)
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: "माल (Code)",
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(color: Color(0xFF2563EB)),
                                  ),
                                ),
                                value: selectedItemCode ?? computedNextCode,
                                items: [
                                  // existing items - show code and name together
                                  ...items.map((e) => DropdownMenuItem(
                                    value: e.code,
                                    child: Text("${e.code} - ${e.name}"),
                                  )),
                                  // the computed next code shown as "new"
                                  DropdownMenuItem(
                                    value: computedNextCode,
                                    child: Text("$computedNextCode (नवीन)"),
                                  ),
                                ],
                                onChanged: (val) async {
                                  if (val == null) return;

                                  setState(() {
                                    selectedItemCode = val;
                                  });

                                  // if user picks computed next code -> new entry
                                  if (val == computedNextCode) {
                                    clearFormForNew(val);
                                  } else {
                                    // load existing item by code
                                    try {
                                      final existing = items.firstWhere(
                                            (item) => item.code == val,
                                      );
                                      fillFormFromItem(existing);
                                    } catch (e) {
                                      // fallback to clearing but keep selected code
                                      clearFormForNew(computedNextCode);
                                      setState(() {
                                        selectedItemCode = val;
                                      });
                                    }
                                  }
                                },
                              ),
                            ),

                            const SizedBox(width: 10),

                            // Name field with dropdown for existing names and option to add new
                            // Name field with dropdown for existing names and option to add new
                            Expanded(
                              flex: 2,
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: "मालाचे नाव",
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(color: Color(0xFF2563EB)),
                                  ),
                                ),
                                value: _getValidNameValue(),
                                items: _buildNameDropdownItems(),
                                onChanged: (val) {
                                  if (val == null) return;

                                  if (val == "__new__") {
                                    _showNameInputDialog();
                                  } else if (val == "__current__") {
                                    // This is the current typed value, do nothing special
                                  } else {
                                    // Existing name selected - auto-fill the form
                                    setState(() {
                                      selectedItemName = val;
                                    });

                                    try {
                                      final existing = items.firstWhere((item) => item.name == val);
                                      fillFormFromItem(existing);
                                    } catch (e) {
                                      // Name not found in items, keep the name but clear other fields
                                      clearFormForNew(computedNextCode);
                                      setState(() {
                                        selectedItemName = val;
                                      });
                                    }
                                  }
                                },
                              ),
                            ),

                            const SizedBox(width: 10),

                            // Unit dropdown
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: "नग (Unit)",
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(color: Color(0xFF2563EB)),
                                  ),
                                ),
                                value: selectedUnit,
                                items: ["नग", "लिटर", "किग्रॅ"]
                                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                                    .toList(),
                                onChanged: (val) => setState(() => selectedUnit = val),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Row 2: Opening Qty, Min Qty, Purchase Rate
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: openingQtyController,
                                decoration: InputDecoration(
                                  labelText: "सुरुवातीचे नग",
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(color: Color(0xFF2563EB)),
                                  ),
                                ),
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: minQtyController,
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
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: purchaseRateController,
                                decoration: InputDecoration(
                                  labelText: "खरेदी दर",
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(color: Color(0xFF2563EB)),
                                  ),
                                ),
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Row 3: Current Qty, Selling Rate, VAT
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: currentQtyController,
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
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: sellingRateController,
                                decoration: InputDecoration(
                                  labelText: "विक्री दर",
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(color: Color(0xFF2563EB)),
                                  ),
                                ),
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: vatController,
                                decoration: InputDecoration(
                                  labelText: "वॅट (%)",
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(color: Color(0xFF2563EB)),
                                  ),
                                ),
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Accounts Mapping
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFEBF4FF), Color(0xFFDBEAFE)],
                      ),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF93C5FD), width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.account_balance, color: Color(0xFF2563EB), size: 18),
                            SizedBox(width: 6),
                            Text(
                              "पोझिशन खाते",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xFF1E3A8A),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: "खरेदी खाते",
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(color: Color(0xFF2563EB)),
                            ),
                          ),
                          value: purchaseAccount,
                          items: ["Purchase A/c 1", "Purchase A/c 2"]
                              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (val) => setState(() => purchaseAccount = val),
                        ),
                        const SizedBox(height: 10),

                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: "विक्री खाते",
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(color: Color(0xFF2563EB)),
                            ),
                          ),
                          value: salesAccount,
                          items: ["Sales A/c 1", "Sales A/c 2"]
                              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (val) => setState(() => salesAccount = val),
                        ),
                        const SizedBox(height: 10),

                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: "क्रेडिट विक्री खाते",
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(color: Color(0xFF2563EB)),
                            ),
                          ),
                          value: creditSalesAccount,
                          items: ["Credit A/c 1", "Credit A/c 2"]
                              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (val) => setState(() => creditSalesAccount = val),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // New
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
                        onPressed: () async {
                          try {
                            final next = await service.getNextItemCode();
                            clearFormForNew(next);
                            // refresh list in provider
                            ref.read(itemListProvider.notifier).state = await service.getItems();
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

                      // Save
                      Consumer(builder: (context, ref2, _) {
                        return ElevatedButton.icon(
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
                            // Validation
                            if (selectedItemName == null || selectedItemName!.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("कृपया मालाचे नाव प्रविष्ट करा")),
                              );
                              return;
                            }

                            if (selectedUnit == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("कृपया युनिट निवडा")),
                              );
                              return;
                            }

                            try {
                              final model = ItemInfoModel(
                                id: editingId,
                                code: selectedItemCode ?? computedNextCode,
                                name: selectedItemName ?? '',
                                unit: selectedUnit ?? '',
                                openingQty: double.tryParse(openingQtyController.text) ?? 0,
                                minQty: double.tryParse(minQtyController.text) ?? 0,
                                purchaseRate: double.tryParse(purchaseRateController.text) ?? 0,
                                currentQty: double.tryParse(currentQtyController.text) ?? 0,
                                sellingRate: double.tryParse(sellingRateController.text) ?? 0,
                                vat: double.tryParse(vatController.text) ?? 0,
                                purchaseAccount: purchaseAccount ?? '',
                                salesAccount: salesAccount ?? '',
                                creditSalesAccount: creditSalesAccount ?? '',
                                isActive: true,
                              );

                              await service.saveItem(model);

                              // Refresh provider list
                              final updated = await service.getItems();
                              ref2.read(itemListProvider.notifier).state = updated;

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("माहिती जतन झाली")),
                              );

                              // prepare for new entry
                              final next = await service.getNextItemCode();
                              clearFormForNew(next);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Error: ${e.toString()}")),
                              );
                            }
                          },
                        );
                      }),

                      // Delete
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
                        onPressed: editingId == null
                            ? null
                            : () async {
                          try {
                            final idToDelete = editingId!;
                            final ok = await service.deleteItem(idToDelete);
                            if (ok) {
                              final updated = await service.getItems();
                              ref.read(itemListProvider.notifier).state = updated;
                              final next = await service.getNextItemCode();
                              clearFormForNew(next);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("नोंद हटवली गेली")),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Delete failed")),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error: ${e.toString()}")),
                            );
                          }
                        },
                      ),

                      // Edit
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
                          if (editingId == null) {
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

                      // Close
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
*/
