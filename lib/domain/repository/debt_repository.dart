import '../model/debt.dart';

abstract class DebtRepository {
  Future<int> insertDebt(Debt debt);

  Future<List> getAllDebtsByDebtor(int debtorId);

  Future<int> getCountDebtsByDebtor(int debtorId);

  Future<int> updateDebt(Debt debt);

  Future<int> deleteDebt(int id);
}
