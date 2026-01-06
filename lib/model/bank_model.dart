import 'package:isar/isar.dart';

part 'bank_model.g.dart';

@collection
class BankMaster {
  // This field will act as Isar's primary key
  Id id = Isar.autoIncrement;

  static int _codeCounter = 0; // keeps track of last code assigned

  late int? code;
  late String name;
  late String branch;
  late String ifsc;
  // Constructor
  BankMaster({required this.name, int? code, required this.branch,required this.ifsc}) {
    this.code = code ?? ++_codeCounter;
  }

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'branch': branch,
      'ifsc':ifsc
    };
  }

  // Create object from JSON
  factory BankMaster.fromJson(Map<String, dynamic> json) {
    int parsedCode = json['code'];
    if (parsedCode > _codeCounter) {
      _codeCounter = parsedCode;
    }
    return BankMaster(
      code: parsedCode,
      name: json['name'],
      branch: json['branch'],
      ifsc: json['ifsc']
    );
  }
}
