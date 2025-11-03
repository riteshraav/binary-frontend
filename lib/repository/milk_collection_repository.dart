import '../model/milk_collection_model.dart';

abstract class MilkCollectionRepository {
  Future<int?> insertMilkCollection(MilkCollectionModel collection);
  Future<List<MilkCollectionModel>> getAllCollections();
  Future<List<MilkCollectionModel>> getCollectionsByDate(DateTime date);
  Future<void> deleteCollection(int id);
  Future<void> clearAll();
  Future<List<MilkCollectionModel>> getCollectionsBetween(DateTime from, DateTime to);
  Future<List<MilkCollectionModel>> getCollectionsBetweenAndByAdminId(DateTime from, DateTime to,String adminId);
  Future<List<MilkCollectionModel>> getCollectionsBetweenAndByAdminIdAndMilkType(DateTime from, DateTime to,String adminId,int milkType);
  Future<List<MilkCollectionModel>> getCollectionsBetweenAndByAdminIdAndCustomerAndMilkType(String customerId,int milkType,DateTime from,DateTime to,String adminId);
}
