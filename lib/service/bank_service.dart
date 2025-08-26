import '../model/bank_model.dart';
import '../repository/brank_master_repository.dart';

class BankService {
  final BankRepository _bankRepository;

  BankService(this._bankRepository);

  Future<List<BankMaster>> getAllBanks() async {
    return await _bankRepository.getAllBanks();
  }

  Future<BankMaster?> findBankByIfsc(String ifsc) async {
    return await _bankRepository.getBankByIfsc(ifsc);
  }

  Future<BankMaster> createBank({
    required String name,
    required String branch,
    required String ifsc,
    int? code,
  }) async {
    // Check if IFSC already exists
    final existingBank = await _bankRepository.getBankByIfsc(ifsc);
    if (existingBank != null) {
      throw Exception('Bank with IFSC $ifsc already exists');
    }

    // Check if code already exists (if provided)
    if (code != null) {
      final existingBankByCode = await _bankRepository.getBankByCode(code);
      if (existingBankByCode != null) {
        throw Exception('Bank with code $code already exists');
      }
    }

    final bank = BankMaster(
      name: name,
      branch: branch,
      ifsc: ifsc,
      code: code,
    );

    return await _bankRepository.addBank(bank);
  }

}