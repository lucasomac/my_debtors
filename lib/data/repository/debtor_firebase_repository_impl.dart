import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

import '../../domain/model/debtor.dart';
import '../../domain/repository/debtor_repository.dart';

class DebtorFirebaseRepositoryImpl implements DebtorRepository {
  FirebaseDatabase database;
  final String tableDebtor = "debtor";
  late DatabaseReference reference;

  DebtorFirebaseRepositoryImpl(this.database) {
    reference = database.ref(tableDebtor);
  }

  @override
  Future<String> deleteDebtor(String cellphone) {
    reference.child(cellphone).remove();
    return Future.value(cellphone);
  }

  @override
  Future<List> getAllDebtors() async {
    List<Debtor> debtors = [];
    final snapshot = await reference.get();

    if (snapshot.value == null) {
      return debtors;
    }
    return (snapshot.value as Map<dynamic, dynamic>).values.toList();
  }

  @override
  Future<int> getCountDebtors() {
    return reference.get().then((value) {
      final map = value.value as Map<dynamic, dynamic>;
      return map.length;
    });
  }

  @override
  Future<String> insertDebtor(Debtor debtor) {
    reference.child(debtor.cellphone).set(debtor.toJson());
    return Future.value(debtor.cellphone);
  }

  @override
  Future<String> updateDebtor(Debtor debtor) {
    reference.child(debtor.cellphone).update(debtor.toJson());
    return Future.value(debtor.cellphone);
  }
}
