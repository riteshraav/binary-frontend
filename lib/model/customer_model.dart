import 'package:isar/isar.dart';

part 'customer_model.g.dart';

@collection
class CustomerMaster {
  // Isar primary key
  Id id;

  late String code;
  late String name;
  late String branch;
  late String milkType;
  late String classType;
  late String gender;
  late String caste;
  late bool milkOn;
  late String accountNo;
  late String sabhasadNo;
  late String bankCode;
  late String bankBranch;
  late String bankAccountNo;
  late String ifsc;
  late String rateGroup;
  late String localRateGroup;
  late String mobileNo1;
  late String mobileNo2;
  late String aadhar;
  late String panNo;
  late String animalCount;
  late String averageQuantity;
  late String adminId;
  late String adminCode;

  // ✅ Constructor
  CustomerMaster({
    this.id = Isar.autoIncrement,
    required this.code,
    required this.name,
    required this.branch,
    required this.milkType,
    required this.classType,
    required this.gender,
    required this.caste,
    required this.milkOn,
    required this.accountNo,
    required this.sabhasadNo,
    required this.bankCode,
    required this.bankBranch,
    required this.bankAccountNo,
    required this.ifsc,
    required this.rateGroup,
    required this.localRateGroup,
    required this.mobileNo1,
    required this.mobileNo2,
    required this.aadhar,
    required this.panNo,
    required this.animalCount,
    required this.averageQuantity,
    required this.adminId,
    required this.adminCode,
  });

  // ✅ toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'branch': branch,
      'milkType': milkType,
      'classType': classType,
      'gender': gender,
      'caste': caste,
      'milkOn': milkOn,
      'accountNo': accountNo,
      'sabhasadNo': sabhasadNo,
      'bankCode': bankCode,
      'bankBranch': bankBranch,
      'bankAccountNo': bankAccountNo,
      'ifsc': ifsc,
      'rateGroup': rateGroup,
      'localRateGroup': localRateGroup,
      'mobileNo1': mobileNo1,
      'mobileNo2': mobileNo2,
      'aadhar': aadhar,
      'panNo': panNo,
      'animalCount': animalCount,
      'averageQuantity': averageQuantity,
      'adminId': adminId,
      'adminCode': adminCode,
    };
  }

  // ✅ fromJson
  factory CustomerMaster.fromJson(Map<String, dynamic> json) {
    return CustomerMaster(
      id: (json['id'] as int?) ?? Isar.autoIncrement,
      code: json['code'] as String,
      name: json['name'] as String,
      branch: json['branch'] as String,
      milkType: json['milkType'] as String,
      classType: json['classType'] as String,
      gender: json['gender'] as String,
      caste: json['caste'] as String,
      milkOn: json['milkOn'] as bool,
      accountNo: json['accountNo'] as String,
      sabhasadNo: json['sabhasadNo'] as String,
      bankCode: json['bankCode'] as String,
      bankBranch: json['bankBranch'] as String,
      bankAccountNo: json['bankAccountNo'] as String,
      ifsc: json['ifsc'] as String,
      rateGroup: json['rateGroup'] as String,
      localRateGroup: json['localRateGroup'] as String,
      mobileNo1: json['mobileNo1'] as String,
      mobileNo2: json['mobileNo2'] as String,
      aadhar: json['aadhar'] as String,
      panNo: json['panNo'] as String,
      animalCount: json['animalCount'] as String,
      averageQuantity: json['averageQuantity'] as String,
      adminId: json['adminId'] as String,
      adminCode: json['adminCode'] as String,
    );
  }
}
