import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mydebtors/domain/model/debt.dart';

import '../../../domain/model/debtor.dart';
import '../../../domain/repository/debt_repository.dart';
import '../../../domain/repository/debtor_repository.dart';

class DebtFirestoreRepositoryImpl implements DebtRepository {
  FirebaseFirestore database;
  final String tableDebt = "debt";
  late CollectionReference collection;

  DebtFirestoreRepositoryImpl(this.database) {
    collection = database.collection(tableDebt);
  }

  @override
  Future<bool> deleteDebt(String id) {
    collection.doc(id).delete();
    var result = collection.doc(id).get().then((onValue) {
      return onValue.data() == null;
    });
    return Future.value(result);
  }

  @override
  Future<List<Debt>> getAllDebtsByDebtorEmail(String email) async {
    List<Debt> debts = [];
    final snapshot = await collection.where('debtor', isEqualTo: email).get();
    if (snapshot.docs.isNotEmpty) {
      for (var doc in snapshot.docs) {
        debts.add(Debt.fromJson(doc));
      }
    }
    return debts;
  }

  @override
  Future<int> getCountDebtsByDebtor(String email) {
    return collection.where('debtor', isEqualTo: email).get().then((value) {
      final map = value.docs as Map<dynamic, dynamic>;
      return map.length;
    });
  }

  @override
  Future<bool> insertDebt(Debt debt) {
    collection.doc(debt.id).set(debt.toJson());
    var result = collection.doc(debt.id).get().then((onValue) {
      return onValue.data() != null;
    });
    return Future.value(result);
  }

  @override
  Future<bool> updateDebt(Debt debt) {
    collection.doc(debt.id).update(debt.toJson());
    var result = collection.doc(debt.id).get().then((onValue) {
      return onValue.data() != null;
    });
    return Future.value(result);
  }
}
