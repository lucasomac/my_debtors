import '../../domain/model/debtor.dart';
import '../../domain/repository/debtor_repository.dart';
import '../../util/db_helper.dart';

class DebtorSqliteRepositoryImpl implements DebtorRepository {
  DbHelper helper;

  DebtorSqliteRepositoryImpl(this.helper);

  @override
  Future<String> deleteDebtor(String email) {
     helper.deleteDebtor(email);
    return Future.value(email);
  }

  @override
  Future<List> getAllDebtors() {
    return helper.getAllDebtors();
  }

  @override
  Future<int> getCountDebtors() {
    return helper.getCountDebtors();
  }

  @override
  Future<String> insertDebtor(Debtor debtor) {
    return helper.insertDebtor(debtor);
  }

  @override
  Future<String> updateDebtor(Debtor debtor) {
    helper.updateDebtor(debtor);
    return Future.value(debtor.email);
  }
}
