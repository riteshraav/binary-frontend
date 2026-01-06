import '../model/supplier_model.dart';
import '../repository/supplier_repository.dart';

class SupplierService {
  final SupplierRepository _repository;

  SupplierService(this._repository);

  Future<List<Supplier>> getSuppliers() async {
    return await _repository.getAllSuppliers();
  }

  Future<Supplier?> getSupplierById(int id) async {
    return await _repository.getSupplierById(id);
  }

  Future<int> addSupplier(String code, String name) async {
    final supplier = Supplier()
      ..code = code
      ..name = name;
    return await _repository.addSupplier(supplier);
  }

  Future<int> updateSupplier(int id, String code, String name) async {
    final supplier = Supplier()
      ..id = id
      ..code = code
      ..name = name;
    return await _repository.updateSupplier(supplier);
  }

  Future<int> deleteSupplier(int id) async {
    return await _repository.deleteSupplier(id);
  }

  Future<Supplier?> getSupplierByCode(String code) async {
    return await _repository.getSupplierByCode(code);
  }
}