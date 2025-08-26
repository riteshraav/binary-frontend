import 'package:isar/isar.dart';

part 'local_rate_model.g.dart'; // required for codegen

@collection
class LocalRateModel {
  Id id = Isar.autoIncrement; // Auto increment primary key

  late String name;

  LocalRateModel({required this.name});

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  // Create object from JSON
  factory LocalRateModel.fromJson(Map<String, dynamic> json) {
    return LocalRateModel(
      name: json['name'],
    )..id = json['id'] ?? Isar.autoIncrement;
  }
}
