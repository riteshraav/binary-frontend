import 'package:isar/isar.dart';
import '../model/customer_model.dart';
import '../repository/customer_repository.dart';


class CustomerIsarRepository implements CustomerRepo {
  final Isar isar;

  CustomerIsarRepository(this.isar);

  @override
  Future<List<CustomerMaster>> getAllCustomers(String adminId) async {
    return await isar.customerMasters
        .filter()
        .adminIdEqualTo(adminId)
        .findAll();
  }

  @override
  Future<CustomerMaster?> getCustomerById(int id) async {
    return await isar.customerMasters.get(id);
  }

  @override
  Future<int> insertCustomer(CustomerMaster customer) async {
    final insertedId = await isar.writeTxn(() => isar.customerMasters.put(customer));
    print('insertedid is $insertedId');
    return await isar.writeTxn(() => isar.customerMasters.put(customer));
  }

  @override
  Future<bool> updateCustomer(CustomerMaster customer) async {
    final insertedId = await isar.writeTxn(() => isar.customerMasters.put(customer));
    return insertedId > 0;
  }

  @override
  Future<bool> deleteCustomer(int id) async {
    return await isar.writeTxn(() => isar.customerMasters.delete(id));
  }

  @override
  Future<void> clearAll() async {
    await isar.writeTxn(() => isar.customerMasters.clear());
  }
}
