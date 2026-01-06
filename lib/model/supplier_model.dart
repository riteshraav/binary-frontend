import 'package:isar/isar.dart';

part 'supplier_model.g.dart';

@collection
class Supplier {
  Id id = Isar.autoIncrement;

  @Index()
  late String code;

  late String name;

  @override
  String toString() {
    return '$code - $name';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Supplier &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              code == other.code &&
              name == other.name;

  @override
  int get hashCode => id.hashCode ^ code.hashCode ^ name.hashCode;
}