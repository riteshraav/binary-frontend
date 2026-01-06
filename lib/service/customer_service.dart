import '../model/customer_model.dart';
import '../repository/customer_repository.dart';

class CustomerService {
  final CustomerRepo repo;

  CustomerService(this.repo);

  Future<List<CustomerMaster>> fetchAllCustomers(String adminId) => repo.getAllCustomers(adminId);
  Future<CustomerMaster?> fetchCustomer(int id) => repo.getCustomerById(id);
  Future<int> addCustomer(CustomerMaster customer) => repo.insertCustomer(customer);
  Future<bool> editCustomer(CustomerMaster customer) => repo.updateCustomer(customer);
  Future<bool> removeCustomer(int id) => repo.deleteCustomer(id);
  Future<void> clearCustomers() => repo.clearAll();
}
