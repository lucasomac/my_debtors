import '../../domain/model/debtor.dart';
import '../../domain/repository/debtor_repository.dart';
import '../../util/db_helper.dart';

class DebtorSqliteRepositoryImpl implements DebtorRepository {
  DbHelper helper;

  DebtorSqliteRepositoryImpl(this.helper);

  @override
  Future<bool> insertDebtor(Debtor debtor) async {
    int result = await helper.insertDebtor(debtor).then((onValue) {
      return onValue;
    });
    return Future.value(result != 0);
  }

  @override
  Future<List<Debtor>> getAllDebtors() {
    return helper.getAllDebtors().then((value) {
      return value.map((e) => Debtor.fromJson(e)).toList();
    });
  }

  @override
  Future<int> getCountDebtors() {
    return helper.getCountDebtors();
  }

  @override
  Future<bool> updateDebtor(Debtor debtor) async {
    int result = await helper.updateDebtor(debtor).then((onValue) {
      return onValue;
    });
    return Future.value(result != 0);
  }

  @override
  Future<bool> deleteDebtor(String email) async {
    int result = await helper.deleteDebtor(email).then((onValue) {
      return onValue;
    });
    return Future.value(result == 1);
  }

  @override
  Future<Debtor?> getByField(String fieldToSearch) {
    return helper.getDebtorByField(fieldToSearch).then((value) {
      return value != null ? Debtor.fromJson(value) : null;
    });
  }
}
