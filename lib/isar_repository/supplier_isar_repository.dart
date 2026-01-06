import 'package:isar/isar.dart';
import 'package:windows_sample/model/item_purchase_model.dart';
import '../model/supplier_model.dart';
import '../repository/supplier_repository.dart';

class SupplierIsarRepository implements SupplierRepository {
  final Isar isar;

  SupplierIsarRepository(this.isar);

  @override
  Future<List<Supplier>> getAllSuppliers() async {
    return await isar.suppliers.where().findAll();
  }

  @override
  Future<Supplier?> getSupplierById(int id) async {
    return await isar.suppliers.get(id);
  }

  @override
  Future<int> addSupplier(Supplier supplier) async {
    return await isar.writeTxn(() async {
      return await isar.suppliers.put(supplier); // returns int id
    });
  }

  @override
  Future<int> updateSupplier(Supplier supplier) async {
    return await isar.writeTxn(() async {
      return await isar.suppliers.put(supplier); // returns int id
    });
  }

  @override
  Future<int> deleteSupplier(int id) async {
    final success = await isar.writeTxn(() async {
      return await isar.suppliers.delete(id); // returns bool
    });

    if (success) {
      return id; // return deleted id
    } else {
      throw Exception("Failed to delete supplier with id $id");
    }
  }

  @override
  Future<Supplier?> getSupplierByCode(String code) async {
    return await isar.suppliers.filter().codeEqualTo(code).findFirst();
  }
}
