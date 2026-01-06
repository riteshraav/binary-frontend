import 'package:isar/isar.dart';
import '../model/supplier_model.dart';

abstract class SupplierRepository {
  Future<List<Supplier>> getAllSuppliers();
  Future<Supplier?> getSupplierById(int id);
  Future<int> addSupplier(Supplier supplier);
  Future<int> updateSupplier(Supplier supplier);
  Future<int> deleteSupplier(int id);
  Future<Supplier?> getSupplierByCode(String code);
}