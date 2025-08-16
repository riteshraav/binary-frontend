import 'package:isar/isar.dart';

part 'branch_model.g.dart'; // Required for Isar code generation

@collection
class BranchMaster {
  // This field will act as Isar's primary key
  Id id = Isar.autoIncrement;

  static int _codeCounter = 0; // keeps track of last code assigned

  late int? code;
  late String name;
  late String rate;

  // Constructor
  BranchMaster({required this.name, int? code, required this.rate}) {
    this.code = code ?? ++_codeCounter;
  }

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'rate': rate,
    };
  }

  // Create object from JSON
  factory BranchMaster.fromJson(Map<String, dynamic> json) {
    int parsedCode = json['code'];
    if (parsedCode > _codeCounter) {
      _codeCounter = parsedCode;
    }
    return BranchMaster(
      code: parsedCode,
      name: json['name'],
      rate: json['rate'],
    );
  }
}
