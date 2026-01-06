// lib/models/rat_group.dart
import 'dart:convert';
import 'package:isar/isar.dart';

part 'rate_group.g.dart';

@collection
class RateGroup {
  Id id = Isar.autoIncrement;

  late String name;

  // --- Constructors ---
  RateGroup({required this.name});

  // --- JSON Serialization ---
  factory RateGroup.fromJson(Map<String, dynamic> json) {
    return RateGroup(
      name: json['name'] as String,
    )..id = json['id'] ?? Isar.autoIncrement;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}
