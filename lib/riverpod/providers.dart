// isar_provider.dart
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:windows_sample/isar_repository/customer_master_isar_repository.dart';
import 'package:windows_sample/isar_repository/rate_master_isar_repository.dart';
import 'package:windows_sample/model/customer_model.dart';
import 'package:windows_sample/model/milk_collection_model.dart';
import 'package:windows_sample/model/rate_model.dart';
import 'package:windows_sample/repository/branch_master_repository.dart';
import 'package:windows_sample/service/branch_service.dart';
import 'package:windows_sample/service/customer_service.dart';
import 'package:windows_sample/service/daily_collection_service.dart';
import 'package:windows_sample/service/milk_collection_service.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../isar_repository/bank_master_repository.dart';
import '../isar_repository/branch_master_isar_repository.dart';
import '../isar_repository/daily_collection_isar_repository.dart';
import '../isar_repository/milk_collection_isar_repository.dart';
import '../model/branch_model.dart';
import '../model/bank_model.dart'; // Add this import
import '../model/daily_collection_data.dart';
import '../repository/brank_master_repository.dart';
import '../service/bank_service.dart';
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
final rateMasterProvider = Provider<RateService>((ref) {
  final isar = ref.watch(isarProvider);
  final rateMasterRepository =RateIsarRepository(isar);
  return RateService(rateMasterRepository);
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

Future<ProviderContainer> initIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [BranchMasterSchema, BankMasterSchema, CustomerMasterSchema,MilkCollectionModelSchema,RateModelSchema,DailyCollectionDataSchema], // Add BankMasterSchema here
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
  if (existingBranchCount == 0) {
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
  if (existingRateCount == 0) {
    // Initial default data
    List<RateModel> rateModelList = [
      RateModel(name: "20-08-2025"),
      RateModel(name: "01-08-2025"),
      RateModel(name: "20-07-2025"),
    ];

    // Write to Isar in a transaction
    await isar.writeTxn(() async {
      await isar.rateModels.putAll(rateModelList);
    });

    print("✅ Initial rate master data inserted");
  } else {
    print("ℹ️ rate master data already exists — skipping insert");
  }
  if (existingCustomerCount == 0) {

    await importCustomers(isar);
    print("✅ Initial customer master data inserted");
  } else {
    print("ℹ️ bank customer data already exists — skipping insert");
  }

  return container;
}


// Load and insert MilkCollection data from assets/milk_collection.json

Future<void> importMilkCollections(Isar isar) async {
  final String rawJson = await rootBundle.loadString('assets/data/milk_collection_data.json');
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
  // Read cleaned JSON
  final raw = await File('assets/data/customer_data.json').readAsString();
  final List<dynamic> jsonList = jsonDecode(raw);

  // Convert JSON -> CustomerMaster objects
  final customers = jsonList.map((e) => CustomerMaster(
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
  )).toList();

  // Write to Isar (putAll = insert or update existing)
  await isar.writeTxn(() async {
    await isar.customerMasters.putAll(customers);
  });

  print("✅ Imported ${customers.length} customers into Isar (with update on duplicate).");
}

