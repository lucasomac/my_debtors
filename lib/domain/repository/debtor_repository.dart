import '../model/debtor.dart';

abstract class DebtorRepository {
  Future<int> insertDebtor(Debtor debtor);

  Future<List> getAllDebtors();

  Future<int> getCountDebtors();

  Future<int> updateDebtor(Debtor debtor);

  Future<int> deleteDebtor(int id);
}
