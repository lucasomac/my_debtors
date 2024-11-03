import '../../../domain/model/debt.dart';
import '../../../domain/repository/debt_repository.dart';
import '../../../util/db_helper.dart';

class DebtSqliteRepositoryImpl implements DebtRepository {
  DbHelper helper;

  DebtSqliteRepositoryImpl(this.helper);

  @override
  Future<bool> deleteDebt(String id) async {
    int result = await helper.deleteDebt(id).then((onValue) {
      return onValue;
    });
    return Future.value(result == 1);
  }

  @override
  Future<List<Debt>> getAllDebtsByDebtorEmail(String email) async {
    var response = await helper.getAllDebtsByDebtor(email);
    return Future.value(response.map((e) => Debt.fromJson(e)).toList());
  }

  @override
  Future<int> getCountDebtsByDebtor(String email) {
    return helper.getCountDebtsByDebtorCellphone(email);
  }

  @override
  Future<bool> insertDebt(Debt debt) async {
    int result = await helper.insertDebt(debt).then((onValue) {
      return onValue;
    });
    return Future.value(result != 0);
  }

  @override
  Future<bool> updateDebt(Debt debt) async {
    int result = await helper.updateDebt(debt).then((onValue) {
      return onValue;
    });
    return Future.value(result != 0);
  }
}
