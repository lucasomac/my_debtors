import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

import '../../../domain/model/debtor.dart';
import '../../../domain/repository/debtor_repository.dart';

class DebtorFirebaseRepositoryImpl implements DebtorRepository {
  FirebaseDatabase database;
  final String tableDebtor = "debtor";
  late DatabaseReference reference;

  DebtorFirebaseRepositoryImpl(this.database) {
    reference = database.ref(tableDebtor);
  }

  @override
  Future<bool> insertDebtor(Debtor debtor) {
    reference.child(debtor.cellphone).set(debtor.toJson());
    var result = reference.child(debtor.cellphone).get().then((onValue) {
      return onValue.value != null;
    });
    return Future.value(result);
  }

  @override
  Future<List<Debtor>> getAllDebtors() async {
    List<Debtor> debtors = [];
    final snapshot = await reference.get();
    if (snapshot.value == null) {
      return debtors;
    }
    final map = snapshot.value as Map<dynamic, dynamic>;
    map.forEach((key, value) {
      debtors.add(Debtor.fromJson(value));
    });
    return debtors;
  }

  @override
  Future<int> getCountDebtors() {
    return reference.get().then((value) {
      final map = value.value as Map<dynamic, dynamic>;
      return map.length;
    });
  }

  @override
  Future<bool> updateDebtor(Debtor debtor) {
    reference.child(debtor.cellphone).update(debtor.toJson());
    var result = reference.child(debtor.cellphone).get().then((onValue) {
      return onValue.value != null;
    });
    return Future.value(result);
  }

  @override
  Future<bool> deleteDebtor(String cellphone) async {
    try {
      await reference.child(cellphone).remove();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Debtor?> getByField(String fieldToSearch) async {
    final snapshot = await reference.child(fieldToSearch).get();
    if (snapshot.value == null) {
      return null;
    }
    return Debtor.fromJson(snapshot.value);
  }
}
