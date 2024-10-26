import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import '../../domain/model/debtor.dart';
import '../../domain/repository/debtor_repository.dart';
import '../../util/db_helper.dart';

class DebtorFirebaseRepositoryImpl implements DebtorRepository {
  DbHelper helper;
  FirebaseDatabase database;
  final String tableDebtor = "debtor";
  late DatabaseReference reference;

  DebtorFirebaseRepositoryImpl(this.helper, this.database) {
    reference = database.ref(tableDebtor);
  }

  @override
  Future<String> deleteDebtor(String email) {
    reference.child(email).remove();
    return Future.value(email);
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
    reference.child(debtor.email).set(debtor.toJson());
    return Future.value(debtor.email);
  }

  @override
  Future<String> updateDebtor(Debtor debtor) {
    reference.child(debtor.email).update(debtor.toJson());
    return Future.value(debtor.email);
  }
}
