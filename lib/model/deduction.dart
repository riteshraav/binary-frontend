// file: models/deductoin.dart
import 'package:isar/isar.dart';

part 'deduction.g.dart';

@Collection()
class Deduction {
  // Isar id (auto-increment)
  Id id = Isar.autoIncrement;

  // Fields
  late String name;
  @Index(unique: true, replace: true) // make code unique if needed
  late String code;
  late String vasuliType;
  late String aakarani;
  late double rate;
  late int priority;
  late bool rounding;
  late bool milkat;
  late bool kapatLock;

  // Constructor
  Deduction({
    required this.name,
    required this.code,
    required this.vasuliType,
    required this.aakarani,
    required this.rate,
    required this.priority,
    required  this.rounding ,
    required  this.milkat ,
    required  this.kapatLock ,
  }) {
    if (id != null) this.id = id;
  }

  // fromJson
  factory Deduction.fromJson(Map<String, dynamic> json) {
    return Deduction(
      name: json['name']?.toString() ?? '',
      code: json['code']?.toString() ?? '',
      vasuliType: json['vasuliType']?.toString() ?? '',
      aakarani: json['aakarani']?.toString() ?? '',
      rate: (json['rate'] is num) ? (json['rate'] as num).toDouble() : double.tryParse('${json['rate']}') ?? 0.0,
      priority: (json['priority'] is int) ? json['priority'] as int : int.tryParse('${json['priority']}') ?? 0,
      rounding: json['rounding'] == true || json['rounding'] == 1 || json['rounding'] == 'true',
      milkat: json['milkat'] == true || json['milkat'] == 1 || json['milkat'] == 'true',
      kapatLock: json['kapatLock'] == true || json['kapatLock'] == 1 || json['kapatLock'] == 'true',
    );
  }

  // toJson
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'code': code,
    'vasuliType': vasuliType,
    'aakarani': aakarani,
    'rate': rate,
    'priority': priority,
    'rounding': rounding,
    'milkat': milkat,
    'kapatLock': kapatLock,
  };

  // copyWith
  Deduction copyWith({
    Id? id,
    String? name,
    String? code,
    String? vasuliType,
    String? aakarani,
    double? rate,
    int? priority,
    bool? rounding,
    bool? milkat,
    bool? kapatLock,
  }) {
    return Deduction(
      name: name ?? this.name,
      code: code ?? this.code,
      vasuliType: vasuliType ?? this.vasuliType,
      aakarani: aakarani ?? this.aakarani,
      rate: rate ?? this.rate,
      priority: priority ?? this.priority,
      rounding: rounding ?? this.rounding,
      milkat: milkat ?? this.milkat,
      kapatLock: kapatLock ?? this.kapatLock,
    );
  }

  @override
  String toString() =>
      'Deduction{id:$id, name:$name, code:$code, rate:$rate, priority:$priority, rounding:$rounding, milkat:$milkat, kapatLock:$kapatLock}';
}
