import 'package:isar/isar.dart';

part 'rate_model.g.dart';

@collection
class RateModel {
  Id id = Isar.autoIncrement; // Primary key for Isar
  late String name;

  RateModel({required this.name});

  // From JSON
  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(name: json['name']);
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
