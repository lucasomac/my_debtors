import '../model/debt.dart';

abstract class DebtRepository {
  Future<int> insertDebt(Debt debt);

  Future<List> getAllDebtsByDebtorEmail(String email);

  Future<int> getCountDebtsByDebtor(String email);

  Future<int> updateDebt(Debt debt);

  Future<int> deleteDebt(int id);
}
