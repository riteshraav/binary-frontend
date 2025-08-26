import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../model/branch_model.dart';
import '../repository/branch_master_repository.dart';

class BranchMasterService {
  final IBranchMasterRepository _repo;

  BranchMasterService(this._repo);

  /// ✅ Import JSON data into Isar (update if exists)
  Future<void> importBranchesFromJson(String assetPath) async {
    try {
      // Load JSON file from assets
      final String jsonString = await rootBundle.loadString(assetPath);
      final List<dynamic> jsonList = jsonDecode(jsonString);

      List<BranchMaster> branches = jsonList.map((json) {
        return BranchMaster.fromJson(json);
      }).toList();

      for (var branch in branches) {
        // Check if branch with same code exists
        final existing = await _repo.getBranchByCode(branch.code!);
        if (existing != null) {
          // ✅ Update existing
          await _repo.updateBranch(existing.id, branch.name, branch.rate);
        } else {
          // ✅ Insert new
          await _repo.addBranch(branch);
        }
      }

      print("✅ Branch data imported successfully!");
    } catch (e) {
      print("❌ Error importing branches: $e");
    }
  }

  /// Get all branches
  Future<List<BranchMaster>> getAllBranches() => _repo.getAllBranches();

  /// Find branch by code
  Future<BranchMaster?> getBranchByCode(int code) =>
      _repo.getBranchByCode(code);
  Future<void> addBranch(BranchMaster branch) => _repo.addBranch(branch);
  /// Clear all branches
  Future<void> clearAllBranches() => _repo.clearAll();
}
