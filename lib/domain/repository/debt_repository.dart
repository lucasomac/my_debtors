import '../model/debt.dart';

abstract class DebtRepository {
  Future<bool> insertDebt(Debt debt);

  Future<List<Debt>> getAllDebtsByDebtorEmail(String email);

  Future<int> getCountDebtsByDebtor(String email);

  Future<bool> updateDebt(Debt debt);

  Future<bool> deleteDebt(String id);
}
