import '../../domain/model/debtor.dart';
import '../../domain/repository/debtor_repository.dart';
import '../../util/db_helper.dart';

class DebtorRepositoryImpl implements DebtorRepository {
  DbHelper helper;

  DebtorRepositoryImpl(this.helper);

  @override
  Future<int> deleteDebtor(int id) {
    return helper.deleteDebtor(id);
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
  Future<int> insertDebtor(Debtor debtor) {
    return helper.insertDebtor(debtor);
  }

  @override
  Future<int> updateDebtor(Debtor debtor) {
    return helper.updateDebtor(debtor);
  }
}
