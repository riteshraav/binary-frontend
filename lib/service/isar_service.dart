// lib/service/isar_service.dart
import 'dart:io';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

// Import your models so their generated `*Schema` symbols are available.
// Keep these imports in-sync with your actual model file paths.
import '../model/item_purchase_model.dart';
import '../model/rate_model.dart';
import '../model/branch_model.dart';
import '../model/supplier_model.dart';

/// A small Isar service wrapper to initialize and access Isar safely.
///
/// Usage:
///   void main() async {
///     WidgetsFlutterBinding.ensureInitialized();
///     await IsarService.initialize();
///     runApp(const MyApp());
///   }
class IsarService {
  IsarService._(); // private ctor to prevent instantiation

  static Isar? _isar;

  /// Initialize Isar. Call this once (e.g. in main()) before using the DB.
  static Future<void> initialize({bool inspector = false}) async {
    if (_isar != null) return;

    // Ensure directory exists
    final dir = await getApplicationDocumentsDirectory();
    final directoryPath = dir.path;

    // Open Isar with all collection schemas used in the app.
    // Add or remove schemas here as you add new models.
    _isar = await Isar.open(
      [
        RateModelSchema,
        BranchMasterSchema,
        SupplierSchema,
        ItemPurchaseSchema,
      ],
      directory: directoryPath,
      inspector: inspector,
    );
  }

  /// Synchronous getter - throws if initialize() wasn't called.
  static Isar get isarInstance {
    if (_isar == null) {
      throw Exception(
          'Isar not initialized. Call await IsarService.initialize() before using isarInstance.');
    }
    return _isar!;
  }

  /// Async getter that will initialize Isar if needed.
  static Future<Isar> get db async {
    if (_isar != null) return _isar!;
    await initialize();
    return _isar!;
  }

  /// For compatibility with older code
  static Isar getInstance() => isarInstance;

  /// Close Isar (e.g. on app shutdown or tests)
  static Future<void> close() async {
    if (_isar != null && _isar!.isOpen) {
      await _isar!.close();
      _isar = null;
    }
  }

  /// Helper: run a write transaction (convenience wrapper)
  static Future<T> writeTxn<T>(Future<T> Function(Isar isar) action) async {
    final isar = await db;
    return await isar.writeTxn(() => action(isar));
  }

  /// Helper: get a collection instance without relying on generated top-level getters
  /// Example: final col = IsarService.collection<MainAccountEntry>();
  static IsarCollection<T> collection<T>() {
    return isarInstance.collection<T>();
  }
}
