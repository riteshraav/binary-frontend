// lib/services/rat_group_service.dart
import 'dart:developer';

import '../model/rate_group.dart';
import '../repository/rate_group_repository.dart';


class RateGroupService {
  final RateGroupRepository _repository;

  RateGroupService(this._repository);

  Future<RateGroup?> getGroupById(int id) async {
    log("Service: getGroupById($id)");
    return await _repository.getById(id);
  }

  Future<List<RateGroup>> listGroups() async {
    log("Service: listGroups()");
    return await _repository.getAll();
  }

  Future<int> addGroup(RateGroup group) async {
    log("Service: addGroup(${group.name})");
    _validate(group);
    return await _repository.insert(group);
  }

  Future<bool> updateGroup(RateGroup group) async {
    log("Service: updateGroup(${group.id})");
    _validate(group);
    return await _repository.update(group);
  }

  Future<bool> removeGroup(int id) async {
    log("Service: removeGroup($id)");
    return await _repository.delete(id);
  }

  void _validate(RateGroup group) {
    if (group.name.trim().isEmpty) {
      throw ArgumentError("RatGroup name cannot be empty");
    }
    log("Validation passed for RatGroup: ${group.name}");
  }
}
