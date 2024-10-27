import '../../../domain/model/debt.dart';
import '../../../domain/repository/debt_repository.dart';
import '../../../util/db_helper.dart';

class DebtRepositoryImpl implements DebtRepository {
  DbHelper helper;

  DebtRepositoryImpl(this.helper);

  @override
  Future<int> deleteDebt(int id) {
    return helper.deleteDebt(id);
  }

  @override
  Future<List> getAllDebtsByDebtorEmail(String email) {
    return helper.getAllDebtsByDebtor(email);
  }

  @override
  Future<int> getCountDebtsByDebtor(String email) {
    return helper.getCountDebtsByDebtorCellphone(email);
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
