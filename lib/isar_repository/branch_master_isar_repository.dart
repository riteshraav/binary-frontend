import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../model/branch_model.dart';
import '../repository/branch_master_repository.dart';

class BranchMasterIsarRepository implements IBranchMasterRepository {
  late final Isar _isar;

  BranchMasterIsarRepository._(this._isar);

  static BranchMasterIsarRepository create(Isar isarInstance) {
    return BranchMasterIsarRepository._(isarInstance);
  }


  @override
  Future<void> addBranch(BranchMaster branch) async {
    await _isar.writeTxn(() async {
      await _isar.branchMasters.put(branch);
    });
  }

  @override
  Future<List<BranchMaster>> getAllBranches() async {
    return await _isar.branchMasters.where().findAll();
  }

  @override
  Future<BranchMaster?> getBranchByCode(int code) async {
    return await _isar.branchMasters.filter().codeEqualTo(code).findFirst();
  }

  @override
  Future<void> updateBranch(int id, String newName, String newRate) async {
    final branch = await _isar.branchMasters.get(id);
    if (branch != null) {
      branch.name = newName;
      branch.rate = newRate;
      await _isar.writeTxn(() async {
        await _isar.branchMasters.put(branch);
      });
    }
  }

  @override
  Future<void> deleteBranch(int id) async {
    await _isar.writeTxn(() async {
      await _isar.branchMasters.delete(id);
    });
  }

  @override
  Future<void> clearAll() async {
    await _isar.writeTxn(() async {
      await _isar.branchMasters.clear();
    });
  }

}
