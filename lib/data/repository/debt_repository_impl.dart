import '../../domain/model/debt.dart';
import '../../domain/repository/debt_repository.dart';
import '../../util/db_helper.dart';

class DebtRepositoryImpl implements DebtRepository {
  DbHelper helper;

  DebtRepositoryImpl(this.helper);

  @override
  Future<int> deleteDebt(int id) {
    return helper.deleteDebt(id);
  }

  @override
  Future<List> getAllDebtsByDebtor(int debtorId) {
    return helper.getAllDebtsByDebtor(debtorId);
  }

  @override
  Future<int> getCountDebtsByDebtor(int debtorId) {
    return helper.getCountDebtsByDebtor(debtorId);
  }

  @override
  Future<int> insertDebt(Debt debt) {
    return insertDebt(debt);
  }

  @override
  Future<int> updateDebt(Debt debt) {
    return updateDebt(debt);
  }
}
