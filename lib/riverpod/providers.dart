// isar_provider.dart
import 'dart:developer';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart'; 
import 'package:path_provider/path_provider.dart';
import 'package:windows_sample/isar_repository/customer_master_isar_repository.dart';
import 'package:windows_sample/isar_repository/deduction_isar_repository.dart';
import 'package:windows_sample/isar_repository/rate_grooup_isar_repository.dart';
import 'package:windows_sample/isar_repository/rate_master_isar_repository.dart';
import 'package:windows_sample/model/customer_model.dart';
import 'package:windows_sample/model/deduction_entry_model.dart';
import 'package:windows_sample/model/milk_collection_model.dart';
import 'package:windows_sample/model/opening_balance_model.dart';
import 'package:windows_sample/model/rate_group.dart';
import 'package:windows_sample/model/rate_model.dart';
import 'package:windows_sample/service/branch_service.dart';
import 'package:windows_sample/service/deduction_service.dart';
import 'package:windows_sample/service/opening_balance_service.dart';
import 'package:windows_sample/service/rate_chart_service.dart';
import 'package:windows_sample/service/customer_service.dart';
import 'package:windows_sample/service/daily_collection_service.dart';
import 'package:windows_sample/service/milk_collection_service.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../isar_repository/bank_master_repository.dart';
import '../isar_repository/branch_master_isar_repository.dart';
import '../isar_repository/daily_collection_isar_repository.dart';
import '../isar_repository/deduction_entry_isar_repository.dart';
import '../isar_repository/milk_collection_isar_repository.dart';
import '../isar_repository/opening_balance_isar_repository.dart';
import '../model/branch_model.dart';
import '../model/bank_model.dart';
import '../model/daily_collection_data.dart';
import '../model/deduction.dart';
import '../repository/brank_master_repository.dart';
import '../service/bank_service.dart';
import '../service/deduction_entry_service.dart';
import '../service/rate_group_service.dart';
import '../service/rate_master_service.dart';

final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError("Isar instance not initialized yet");
});


// Add these two providers
final bankRepositoryProvider = Provider<BankRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return BankRepositoryIsar(isar);
});

final bankServiceProvider = Provider<BankService>((ref) {
  final bankRepository = ref.watch(bankRepositoryProvider);
  return BankService(bankRepository);
});
final customerServiceProvider = Provider<CustomerService>((ref) {
  final isar = ref.watch(isarProvider);
  final customerRepository =CustomerIsarRepository(isar);
  return CustomerService(customerRepository);
});
final milkCollectionProvider = Provider<MilkCollectionService>((ref) {
  final isar = ref.watch(isarProvider);
  final milkCollectionRepository =MilkCollectionIsarRepository(isar);
  return MilkCollectionService(milkCollectionRepository);
});
final openingBalanceProvider = Provider<OpeningBalanceService>((ref) {
  final isar = ref.watch(isarProvider);
  final openingBalanceIsarRepository = IsarOpeningBalanceRepository(isar);
  return OpeningBalanceService(openingBalanceIsarRepository);
});
final rateMasterProvider = Provider<RateService>((ref) {
  final isar = ref.watch(isarProvider);
  final rateMasterRepository =IsarRateRepository(isar);
  return RateService(rateMasterRepository);
});
final deductionProvider = Provider<DeductionServiceImpl>((ref) {
  final isar = ref.watch(isarProvider);
  final deductionRepository =DeductionRepositoryIsar(isar);
  return DeductionServiceImpl(deductionRepository);
});

final rateGroupProvider = Provider<RateGroupService>((ref) {
  final isar = ref.watch(isarProvider);
  final rateGroupRepository =IsarRateGroupRepository(isar);
  return RateGroupService(rateGroupRepository);
});
final cowRateChartProvider = Provider<RateChartService>((ref) {
  return RateChartService();
});

final dataCollectionServiceProvider = Provider<DailyCollectionService>((ref) {
  final isar = ref.watch(isarProvider);
  final dailyCollectionRepository =DailyCollectionIsarRepository(isar);
  return DailyCollectionService(dailyCollectionRepository);
});
final branchMasterServiceProvider = Provider<BranchMasterService>((ref) {
  final isar = ref.watch(isarProvider);
  final branchMasterRepository =BranchMasterIsarRepository(isar);
  return BranchMasterService(branchMasterRepository);
});
final deductionEntryProvider = Provider<DeductionEntryService>((ref) {
  final isar = ref.watch(isarProvider);
  final deductionEntryRepository = IsarDeductionEntryRepository(isar);
  return DeductionEntryService(deductionEntryRepository);
});

Future<ProviderContainer> initIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [BranchMasterSchema,OpeningBalanceSchema ,DeductionEntrySchema,BankMasterSchema, CustomerMasterSchema,MilkCollectionModelSchema,RateModelSchema,DailyCollectionDataSchema,RateGroupSchema,DeductionSchema], // Add BankMasterSchema here
    directory: dir.path,
  );

  final container = ProviderContainer(
    overrides: [
      isarProvider.overrideWithValue(isar),
    ],
  );

  // Check if there's any data in BranchMaster collection
  final existingBranchCount = await isar.branchMasters.count();
  final existingBankCount = await isar.bankMasters.count();
  final existingCustomerCount = await isar.customerMasters.count();
  final existingRateCount = await isar.rateModels.count();
  final existingMilkCollection = await isar.milkCollectionModels.count();
  final existingRateGroup = await isar.rateGroups.count();
  final existingCount = await isar.deductions.count();
  final existingOpeningBalance = await isar.openingBalances.count();
 // importOpeningBalancesFromJson(isar, "assets/data/opening_balance_data.json");
  if (existingOpeningBalance == 0) {
    await importOpeningBalancesFromJson(isar, "assets/data/opening_balance_data.json");
  }
  if (existingCount == 0) {
    await importDeduction(isar,'assets/data/deduction_data.json');
    print("✅ Initial deduction master data inserted");
  }
  else {
    print("ℹ️ Deduction master data already exists — skipping insert");
  }
  if (existingRateGroup == 0) {
    // Initial default data
    List<RateGroup> rateGroups = [
      RateGroup(name: "वारणा दुध संघ", ),
      RateGroup(name: "गोकुळ दुध संघ", ),
      RateGroup(name: "चितळे दुध संघ", ),
    ];

    // Write to Isar in a transaction
    await isar.writeTxn(() async {
      await isar.rateGroups.putAll(rateGroups);
    });

    print("✅ Initial branch master data inserted");
  } else {
    print("ℹ️ Branch master data already exists — skipping insert");
  }  if (existingBranchCount == 0) {
    // Initial default data
    List<BranchMaster> branchModelList = [
      BranchMaster(name: "मुख्य शाखा", rate: 'दर क्र १'),
      BranchMaster(name: "शाखा क्र २", rate: 'दर क्र २'),
      BranchMaster(name: "शाखा क्र ३", rate: 'दर क्र ३'),
    ];

    // Write to Isar in a transaction
    await isar.writeTxn(() async {
      await isar.branchMasters.putAll(branchModelList);
    });

    print("✅ Initial branch master data inserted");
  } else {
    print("ℹ️ Branch master data already exists — skipping insert");
  }
  if (existingMilkCollection == 0) {
    // Initial default data
      await importMilkCollections(isar);

    print("✅ Initial milk collection master data inserted");
  } else {
 //   await importMilkCollections(isar);
    print("ℹ️ milk collection data already exists — skipping insert");
  }
  if (existingBankCount == 0) {
    // Initial default data
    List<BankMaster> bankMasterList = [
      BankMaster(name: 'के. डी. सी. कोल्हापूर', branch: 'कोल्हापूर', ifsc: 'kdcc565'),
      BankMaster(name: 'एस. बी. आय. वडगाव', branch: 'वडगाव', ifsc: 'sbin459'),
      BankMaster(name: 'बँक ऑफ इंडिया कोल्हापूर', branch: 'कोल्हापूर', ifsc: 'boin569'),
    ];

    // Write to Isar in a transaction
    await isar.writeTxn(() async {
      await isar.bankMasters.putAll(bankMasterList);
    });

    print("✅ Initial bank master data inserted");
  } else {
    print("ℹ️ bank master data already exists — skipping insert");
  }

  populateRateModelsFromJson(isar);

  if (existingCustomerCount == 0)
  {
    final List<CustomerMaster> customers = [
      CustomerMaster(
        code: "10",
        name: "अभि गावडे",
        branch: "मुख्य शाखा",
        milkType: "mixed",
        classType: "B",
        gender: "Male",
        caste: "Caste3",
        milkOn: true,
        accountNo: "44556677889",
        sabhasadNo: "40",
        bankCode: "889",
        bankBranch: "SBI",
        bankAccountNo: "44556677889",
        ifsc: "SBIN00004567",
        rateGroup: "कृष्णा दुध संघ",
        localRateGroup: "कृष्णा दुध संघ",
        mobileNo1: "9876543201",
        mobileNo2: "9012345678",
        aadhar: "456789012345",
        panNo: "DDTRF5678K",
        animalCount: "8",
        averageQuantity: "356",
        adminId: "1",
        adminCode: "",
      ),
      CustomerMaster(
        code: "9",
        name: "सौरभ पाटील",
        branch: "मुख्य शाखा",
        milkType: "cow",
        classType: "A",
        gender: "Male",
        caste: "Caste1",
        milkOn: true,
        accountNo: "99887766554",
        sabhasadNo: "41",
        bankCode: "777",
        bankBranch: "HDFC",
        bankAccountNo: "99887766554",
        ifsc: "HDFC00006789",
        rateGroup: "कृष्णा दुध संघ",
        localRateGroup: "कृष्णा दुध संघ",
        mobileNo1: "9823456789",
        mobileNo2: "9123456789",
        aadhar: "567890123456",
        panNo: "FGHJK1234L",
        animalCount: "6",
        averageQuantity: "280",
        adminId: "1",
        adminCode: "",
      ),
      CustomerMaster(
        code: "8",
        name: "प्रिया देशमुख",
        branch: "मुख्य शाखा",
        milkType: "buffalo",
        classType: "C",
        gender: "Female",
        caste: "Caste2",
        milkOn: true,
        accountNo: "11223344556",
        sabhasadNo: "42",
        bankCode: "555",
        bankBranch: "BOB",
        bankAccountNo: "11223344556",
        ifsc: "BARB0XYZ999",
        rateGroup: "कृष्णा दुध संघ",
        localRateGroup: "कृष्णा दुध संघ",
        mobileNo1: "9765432109",
        mobileNo2: "9021345678",
        aadhar: "678901234567",
        panNo: "GHJKL2345M",
        animalCount: "5",
        averageQuantity: "320",
        adminId: "1",
        adminCode: "",
      ),
    ];
    await isar.writeTxn(() async {
      await isar.customerMasters.putAll(customers);
    });

    // await importCustomers(isar);
    print("✅ Initial customer master data inserted");
  }
  else {
    await importCustomers(isar);
    print("ℹ️ bank customer data already exists — skipping insert");
  }

  return container;
}


Future<void> importMilkCollections(Isar isar) async {
  final String rawJson = await rootBundle.loadString('assets/data/filtered_output.json');
  final List<dynamic> decoded = jsonDecode(rawJson);

  final List<MilkCollectionModel> collections = decoded.map((entry) {
    final String dateStr = entry['date'] is Map
        ? entry['date']['\$date']
        : entry['date'];

    final DateTime parsedDate = DateTime.parse(dateStr);

    return MilkCollectionModel(
      customerId: entry['customerId'],
      adminId: entry['adminId'],
      fat: (entry['fat'] as num).toDouble(),
      snf: (entry['snf'] as num).toDouble(),
      milkType: entry['milkType'] == 'cow'
          ? 0
          : (entry['milkType'] == 'buffalo' ? 1 : entry['milkType']),
      time: entry['time'] == 'Morning'
          ? 0
          : (entry['time'] == 'Evening' ? 1 : entry['time']),
      date: parsedDate,
      rate: (entry['rate'] as num).toDouble(),
      amount: entry['totalValue'] != null
          ? (entry['totalValue'] as num).toDouble()
          : (entry['amount'] as num).toDouble(),
      quantity: (entry['quantity'] as num).toDouble(),
    )..generateUniqueKey();
  }).toList();

  // Insert or update safely
  await isar.writeTxn(() async {
    for (final item in collections) {
      // check if an entry with same uniqueKey exists
      final existing = await isar.milkCollectionModels
          .filter()
          .uniqueKeyEqualTo(item.uniqueKey)
          .findFirst();

      if (existing != null) {
        // keep same Isar id so it updates instead of insert
        item.id = existing.id;
        print("♻️ Updating existing: ${item.uniqueKey}");
      } else {
        print("🆕 Inserting new: ${item.uniqueKey}");
      }

      await isar.milkCollectionModels.put(item);
    }
  });

  print("✅ Import complete (inserted new + updated existing)");
}

Future<void> importCustomers(Isar isar) async {
  const jsonFilePath = 'assets/data/customer_data.json';
  final file = File(jsonFilePath);

  if (!await file.exists()) {
    print("❌ JSON file not found at $jsonFilePath");
    return;
  }

  try {
    // === Step 1: Read and Parse JSON ===
    final raw = await file.readAsString();
    final List<dynamic> jsonList = jsonDecode(raw);
    print("📦 Loaded ${jsonList.length} customer records from JSON.");

    // === Step 2: Map JSON to CustomerMaster Objects ===
    final customers = jsonList.map((e) {
      return CustomerMaster(
        code: e['code'] ?? "",
        name: e['name'] ?? "",
        branch: e['branch'] ?? "",
        milkType: e['milkType'] ?? "",
        classType: e['classType'] ?? "",
        gender: e['gender'] ?? "",
        caste: e['caste'] ?? "",
        milkOn: e['milkOn'] ?? false,
        accountNo: e['accountNo'] ?? "",
        sabhasadNo: e['sabhasadNo'] ?? "",
        bankCode: e['bankCode'] ?? "",
        bankBranch: e['bankBranch'] ?? "",
        bankAccountNo: e['bankAccountNo'] ?? "",
        ifsc: e['ifsc'] ?? "",
        rateGroup: e['rateGroup'] ?? "",
        localRateGroup: e['localRateGroup'] ?? "",
        mobileNo1: e['mobileNo1'] ?? "",
        mobileNo2: e['mobileNo2'] ?? "",
        aadhar: e['aadhar'] ?? "",
        panNo: e['panNo'] ?? "",
        animalCount: e['animalCount'] ?? "0",
        averageQuantity: e['averageQuantity'] ?? "0",
        adminId: e['adminId'] ?? "",
        adminCode: e['adminCode'] ?? "",
      );
    }).toList();

    // === Step 3: Transaction - Delete all + Insert fresh data ===
    await isar.writeTxn(() async {
     await isar.customerMasters.clear();
      print("🗑️ Deleted  existing customer records.");

      await isar.customerMasters.putAll(customers);
      print("✅ Inserted ${customers.length} new customer records.");
    });

    print("🎯 Import completed successfully.");

  } catch (e, st) {
    print("❌ Error during import: $e");
    print(st);
  }
}

Future<void> importOpeningBalancesFromJson(Isar isar, String assetPath) async {
  try {
    print('[IMPORT] Starting import from $assetPath');

    // Load JSON file from assets
    final String jsonString = await rootBundle.loadString(assetPath);
    final List<dynamic> jsonList = json.decode(jsonString);

    print('[IMPORT] Loaded ${jsonList.length} records from JSON');

    // Convert each record to OpeningBalance model
    final List<OpeningBalance> openingBalances = jsonList
        .map((data) => OpeningBalance.fromJson(data))
        .toList();

    // Insert/Update logic with unique (deductionCode, customerCode)
    await isar.writeTxn(() async {
      for (var record in openingBalances) {
        final existing = await isar.openingBalances.filter()
            .deductionCodeEqualTo(record.deductionCode)
            .and()
            .customerCodeEqualTo(record.customerCode)
            .findFirst();

        if (existing != null) {
          // Update existing
          print('[UPDATE] Existing entry found for ${record.deductionCode}-${record.customerCode}, updating...');
          existing
            ..openingBalance = record.openingBalance
            ..crTot = record.crTot
            ..drTot = record.drTot
            ..clBal = record.clBal
            ..clTot = record.clTot;

          await isar.openingBalances.put(existing);
        } else {
          // Insert new
          print('[INSERT] New entry for ${record.deductionCode}-${record.customerCode}');
          await isar.openingBalances.put(record);
        }
      }
    });

    print('[IMPORT] Import completed successfully.');
  } catch (e, st) {
    print('[ERROR] Failed to import OpeningBalance data: $e');
    print(st);
  }
}
Future<void> importDeduction(Isar isar, String assetPath) async {
  try {
    print('[IMPORT] Starting Deduction import from $assetPath');

    // Load JSON file
    final String jsonString = await rootBundle.loadString(assetPath);
    final List<dynamic> jsonList = json.decode(jsonString);

    print('[IMPORT] Loaded ${jsonList.length} raw records');

    // Convert JSON → Model
    final List<Deduction> deductionList = jsonList
        .map((data) => Deduction.fromJson(data))
        .toList();

    print('[IMPORT] Converted to ${deductionList.length} Deduction objects');

    // Write into Isar
    print('[IMPORT] Writing ${deductionList.length} records to Isar...');

    await isar.writeTxn(() async {
      await isar.deductions.putAll(deductionList);
    });

    print('[IMPORT] Successfully inserted ${deductionList.length} deductions into Isar');

  } catch (e, st) {
    print('[ERROR] Failed to import Deduction data: $e');
    print(st);
  }
}

List<RateModel> parseRateModelsFromJson(List<dynamic> jsonList) {
  double toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  return jsonList.map((json) {
    // Parse date safely
    DateTime parsedDate;
    final dateStr = json['date']?.toString() ?? '';

    try {
      if (dateStr.contains('T')) {
        parsedDate = DateTime.parse(dateStr);
      } else if (dateStr.contains('/')) {
        final parts = dateStr.split('/');
        parsedDate = DateTime(
          int.parse(parts[2]),
          int.parse(parts[1]),
          int.parse(parts[0]),
        );
      } else {
        throw FormatException("Unknown date format");
      }
    } catch (e) {
      print("⚠ Failed to parse date '$dateStr', defaulting to 1970-01-01");
      parsedDate = DateTime(1970);
    }


    // ✅ Use your constructor directly with double-safe parsing
    return RateModel(
      name: json['name'] ?? '',
      date: parsedDate,
      milkType: json['milkType'] ?? 0,
      excelJson: json['excelJson'] ?? '',
      minFat: toDouble(json['minFat']),
      minsnf: toDouble(json['minsnf']),
      minRate: toDouble(json['minRate']),
      maxFat: toDouble(json['maxFat']),
      maxsnf: toDouble(json['maxsnf']),
      maxRate: toDouble(json['maxRate']),
      row: json['row'] ?? 0,
      col: json['col'] ?? 0,
      increment: toDouble(json['increment']),
      isCurrent: json['isCurrent'] ?? false,
    )..id = json['id'] ?? Isar.autoIncrement;
  }).toList();
}
Future<void> populateRateModelsFromJson(Isar isar) async {
  double toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
  // Count existing records
  final existingRateCount = await isar.rateModels.count();

  if (existingRateCount == 0) {
    try {
      // Read JSON file from assets
      final jsonString = await rootBundle.loadString('assets/data/rate_models.json');
      final List<dynamic> jsonList = jsonDecode(jsonString);

      // Convert JSON list to RateModel objects
      final rateModelList = jsonList.map((json) {
        // Parse date safely
        final dateStr = json['date']?.toString();
        DateTime? parsedDate;

        if (dateStr != null && dateStr.isNotEmpty) {
          try {
            if (dateStr.contains('T')) {
              parsedDate = DateTime.parse(dateStr);
            } else if (dateStr.contains('/')) {
              final parts = dateStr.split('/');
              parsedDate = DateTime(
                int.parse(parts[2]),
                int.parse(parts[1]),
                int.parse(parts[0]),
              );
            }
          } catch (e) {
            print("⚠ Invalid date format: $dateStr — defaulting to epoch");
            parsedDate = DateTime(1970);
          }
        }

        return RateModel(
          name: json['name'] ?? '',
          date: parsedDate!,
          milkType: json['milkType'] ?? 0,
          excelJson: json['excelJson'] ?? '',
          minFat: toDouble(json['minFat']),
          minsnf: toDouble(json['minsnf']),
          minRate: toDouble(json['minRate']),
          maxFat: toDouble(json['maxFat']),
          maxsnf: toDouble(json['maxsnf']),
          maxRate: toDouble(json['maxRate']),
          row: json['row'] ?? 0,
          col: json['col'] ?? 0,
          increment: toDouble(json['increment']),
          isCurrent: json['isCurrent'] ?? false,
        )..id = json['id'] ?? Isar.autoIncrement;
      }).toList();

      // Write to Isar in a transaction
      await isar.writeTxn(() async {
        await isar.rateModels.putAll(rateModelList);
      });

      print("✅ Inserted ${rateModelList.length} rate models from JSON");
    } catch (e) {
      print("❌ Failed to populate RateModel data: $e");
    }
  } else {
    print("ℹ Rate master data already exists — skipping insert");
  }


  /// Converts a string like "buffalo"/"cow" into an int (0 = cow, 1 = buffalo)
  int milkTypeToInt(String milkType) {
    switch (milkType.toLowerCase()) {
      case 'buffalo':
        return 1;
      case 'cow':
        return 0;
      default:
        print("Unknown milkType '$milkType', defaulting to 0");
        return 0;
    }
  }

  /// Converts "Morning"/"Evening" into an int (0 = Morning, 1 = Evening)
  int timeToInt(String time) {
    switch (time.toLowerCase()) {
      case 'morning':
        return 0;
      case 'evening':
        return 1;
      default:
        print("Unknown time '$time', defaulting to 0");
        return 0;
    }
  }

  /// Reads a JSON file exported from MongoDB, converts to MilkCollectionModel, and stores in Isar
  Future<void> importMilkCollectionFromJson(Isar isar, String jsonFilePath) async {
    try {
      final file = File(jsonFilePath);
      if (!await file.exists()) {
        print("File not found: $jsonFilePath");
        return;
      }

      final content = await file.readAsString();
      final Map<String, dynamic> jsonMap = json.decode(content);

      print("Loaded JSON: $jsonMap");

      // Parse date from Mongo-style object
      final String dateStr = jsonMap['date']['\$date'];
      final DateTime parsedDate = DateTime.parse(dateStr);

      // Parse numeric and string fields safely
      final milkCollection = MilkCollectionModel(
        adminId: jsonMap['adminId'].toString(),
        customerId: jsonMap['customerId'].toString(),
        fat: (jsonMap['fat'] as num).toDouble(),
        snf: (jsonMap['snf'] as num).toDouble(),
        milkType: jsonMap['milkType'],
        time: jsonMap['time'],
        date: parsedDate,
        rate: (jsonMap['rate'] as num).toDouble(),
        amount: (jsonMap['totalValue'] as num).toDouble(),
        quantity: (jsonMap['quantity'] as num).toDouble(),
      );

      await isar.writeTxn(() async {
        await isar.milkCollectionModels.put(milkCollection);
        print("✅ Imported MilkCollection record for customer ${milkCollection.customerId} on ${milkCollection.date}");
      });

    } catch (e, st) {
      print("❌ Error importing JSON: $e\n$st");
    }
  }


}

/// Reads JSON file, modifies dates, and stores updated data into Isar
Future<void> importAndAdjustDatesInIsar(
    Isar isar,
    String jsonFilePath,
    ) async
{
  try {
    final file = File(jsonFilePath);
    if (!await file.exists()) {
      log("❌ File not found: $jsonFilePath");
      return;
    }

    final content = await file.readAsString();
    final List<dynamic> jsonList = json.decode(content);

    log("📄 Loaded ${jsonList.length} records from $jsonFilePath");

    final List<MilkCollectionModel> models = [];

    for (final record in jsonList) {
      try {
        final String dateStr = record['date'] ?? '';
        if (dateStr.isEmpty) {
          log("⚠ Skipping record with missing date: $record");
          continue;
        }

        DateTime date = DateTime.parse(dateStr);
        int newMonth = date.month;

        // Convert months
        if (date.month == 5) {
        if(date.day != 31)
          {
            newMonth = 9;
            final model = MilkCollectionModel(
              adminId: record['adminId'].toString(),
              customerId: record['customerId'].toString(),
              fat: (record['fat'] as num).toDouble(),
              snf: (record['snf'] as num).toDouble(),
              milkType: record['milkType'],
              time: record['time'],
              date: date,
              rate: (record['rate'] as num).toDouble(),
              amount: (record['amount'] as num).toDouble(),
              quantity: (record['quantity'] as num).toDouble(),
            )..generateUniqueKey();
            models.add(model);

          }
        newMonth = 10;
        final model = MilkCollectionModel(
          adminId: record['adminId'].toString(),
          customerId: record['customerId'].toString(),
          fat: (record['fat'] as num).toDouble(),
          snf: (record['snf'] as num).toDouble(),
          milkType: record['milkType'],
          time: record['time'],
          date: date,
          rate: (record['rate'] as num).toDouble(),
          amount: (record['amount'] as num).toDouble(),
          quantity: (record['quantity'] as num).toDouble(),
        )..generateUniqueKey();
        models.add(model);

        }

        // If month changed, rebuild the date safely
        if (newMonth != date.month) {
          date = DateTime(date.year, newMonth, date.day);
          log("🗓 Date adjusted from $dateStr to ${date.toIso8601String()}");
        }

      } catch (e, st) {
        log("❌ Failed to process record: $record\nError: $e\n$st");
      }
    }

    if (models.isEmpty) {
      log("⚠ No valid records to insert.");
      return;
    }
    print('lenght of model is ${models.length}');
    // Write all models to Isar in a single transaction
      print('writing models in isar');
      await isar.writeTxn(() async {
        await isar.milkCollectionModels.putAll(models);
        final total = await isar.milkCollectionModels.count();
        log("✅ Total entries now in Isar: $total");
        log("✅ Successfully inserted ${models.length} records into Isar.");
      });

  } catch (e, st) {
    log("❌ Error in importAndAdjustDatesInIsar: $e\n$st");
  }
}
