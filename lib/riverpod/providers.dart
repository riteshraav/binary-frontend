// isar_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../isar_repository/branch_master_isar_repository.dart';
import '../model/branch_model.dart';

final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError("Isar instance not initialized yet");
});
final branchMasterRepoProvider = Provider<BranchMasterIsarRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return BranchMasterIsarRepository.create(isar);
});
Future<ProviderContainer> initIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [BranchMasterSchema],
    directory: dir.path,
  );

  final container = ProviderContainer(
    overrides: [
      isarProvider.overrideWithValue(isar),
    ],
  );
  // Check if there's any data in BranchMaster collection
  final existingCount = await isar.branchMasters.count();

  if (existingCount == 0) {
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

  return container;
}
