import '../model/branch_model.dart';

abstract class IBranchMasterRepository {
  Future<void> addBranch(BranchMaster branch);
  Future<List<BranchMaster>> getAllBranches();
  Future<BranchMaster?> getBranchByCode(int code);
  Future<void> updateBranch(int id, String newName, String newRate);
  Future<void> deleteBranch(int id);
  Future<void> clearAll();
}
