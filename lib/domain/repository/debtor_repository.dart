import '../model/debtor.dart';

abstract class DebtorRepository {
  Future<bool> insertDebtor(Debtor debtor);

  Future<List<Debtor>> getAllDebtors();

  Future<int> getCountDebtors();

  Future<bool> updateDebtor(Debtor debtor);

  Future<bool> deleteDebtor(String fieldToSearch);

  Future<Debtor?> getByField(String fieldToSearch);
}
