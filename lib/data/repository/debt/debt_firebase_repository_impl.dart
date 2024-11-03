import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:mydebtors/domain/model/debt.dart';

import '../../../domain/repository/debt_repository.dart';

class DebtFirebaseRepositoryImpl implements DebtRepository {
  FirebaseDatabase database;
  final String tableDebt = "debt";
  late DatabaseReference reference;

  DebtFirebaseRepositoryImpl(this.database) {
    reference = database.ref(tableDebt);
  }

  @override
  Future<bool> deleteDebt(String id) async {
    try {
      await reference.child(id).remove();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Debt>> getAllDebtsByDebtorEmail(String email) async {
    List<Debt> debts = [];
    final snapshot = await reference.get();
    if (snapshot.value == null) {
      return debts;
    }
    final map = snapshot.value as Map<dynamic, dynamic>;
    map.forEach((key, value) {
      var debt = Debt.fromJson(value);
      if (debt.debtor == email) {
        debts.add(debt);
      }
    });
    return debts;
  }

  @override
  Future<int> getCountDebtsByDebtor(String email) {
    return reference.get().then((value) {
      final map = value.value as Map<dynamic, dynamic>;
      return map.length;
    });
  }

  @override
  Future<bool> insertDebt(Debt debt) {
    reference.child(debt.id.toString()).set(debt.toJson());
    var result = reference.child(debt.id.toString()).get().then((onValue) {
      return onValue.value != null;
    });
    return Future.value(result);
  }

  @override
  Future<bool> updateDebt(Debt debt) {
    reference.child(debt.id.toString()).update(debt.toJson());
    var result = reference.child(debt.id.toString()).get().then((onValue) {
      return onValue.value != null;
    });
    return Future.value(result);
  }
}
