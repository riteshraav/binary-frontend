import '../model/customer_model.dart';

abstract class CustomerRepo {
  Future<List<CustomerMaster>> getAllCustomers(String adminId);
  Future<CustomerMaster?> getCustomerById(int id);
  Future<int> insertCustomer(CustomerMaster customer);
  Future<bool> updateCustomer(CustomerMaster customer);
  Future<bool> deleteCustomer(int id);
  Future<void> clearAll();
}
