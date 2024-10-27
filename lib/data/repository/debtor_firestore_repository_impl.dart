import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/model/debtor.dart';
import '../../domain/repository/debtor_repository.dart';

class DebtorFirestoreRepositoryImpl implements DebtorRepository {
  FirebaseFirestore database;
  final String tableDebtor = "debtor";
  late CollectionReference collection;

  DebtorFirestoreRepositoryImpl(this.database) {
    collection = database.collection(tableDebtor);
  }

  @override
  Future<bool> insertDebtor(Debtor debtor) {
    collection.doc(debtor.email).set(debtor.toJson());
    var result = collection.doc(debtor.email).get().then((onValue) {
      return onValue.data() != null;
    });
    return Future.value(result);
  }

  @override
  Future<List<Debtor>> getAllDebtors() async {
    List<Debtor> debtors = [];
    final snapshot = await collection.get();
    if (snapshot.docs.isNotEmpty) {
      for (var doc in snapshot.docs) {
        debtors.add(Debtor.fromDocumentSnapshot(doc));
      }
    }
    return debtors;
  }

  @override
  Future<int> getCountDebtors() {
    return collection.get().then((value) {
      final map = value.docs as Map<dynamic, dynamic>;
      return map.length;
    });
  }

  @override
  Future<bool> updateDebtor(Debtor debtor) {
    collection.doc(debtor.email).update(debtor.toJson());
    var result = collection.doc(debtor.email).get().then((onValue) {
      return onValue.data() != null;
    });
    return Future.value(result);
  }

  @override
  Future<bool> deleteDebtor(String fieldToSearch) {
    collection.doc(fieldToSearch).delete();
    var result = collection.doc(fieldToSearch).get().then((onValue) {
      return onValue.data() == null;
    });
    return Future.value(result);
  }

  @override
  Future<Debtor?> getByField(String fieldToSearch) {
    return collection.doc(fieldToSearch).get().then((onValue) {
      return onValue.data() != null ? Debtor.fromDocumentSnapshot(onValue) : null;
    });
  }
}
