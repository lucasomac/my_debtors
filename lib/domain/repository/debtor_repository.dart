import '../model/debtor.dart';

abstract class DebtorRepository {
  Future<String> insertDebtor(Debtor debtor);

  Future<List> getAllDebtors();

  Future<int> getCountDebtors();

  Future<String> updateDebtor(Debtor debtor);

  Future<String> deleteDebtor(String email);
}
