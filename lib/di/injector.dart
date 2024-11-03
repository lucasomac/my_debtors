import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mydebtors/data/repository/debtor/debtor_firestore_repository_impl.dart';
import '../data/repository/debt/debt_firebase_repository_impl.dart';
import '../data/repository/debt/debt_firestore_repository_impl.dart';
import '../data/repository/debt/debt_sqlite_repository_impl.dart';
import '../data/repository/debtor/debtor_firebase_repository_impl.dart';
import '../data/repository/debtor/debtor_sqlite_repository_impl.dart';
import '../domain/repository/debt_repository.dart';
import '../domain/repository/debtor_repository.dart';
import '../util/db_helper.dart';

enum Nominal { DEFAULT, SQLITE, FIREBASE_DATABASE, FIREBASE_FIRESTORE }

class Injector {
  static const Nominal nominalDefault = Nominal.FIREBASE_FIRESTORE;
  static Injector? _instance;

  static Injector get instance => _instance ??= Injector._();

  Injector._();

  final Map<Nominal, Map<Type, dynamic>> _objects = {};

  bool _contains<T>({Nominal nominal = Nominal.DEFAULT}) {
    if (_objects.containsKey(nominal)) {
      return _objects[nominal]!.containsKey(T);
    } else {
      return false;
    }
  }

  void _add<T>(T instance, {Nominal nominal = Nominal.DEFAULT}) {
    if (_contains<T>(nominal: nominal)) {
      throw Exception('Class ${T.runtimeType} already registered!');
    } else {
      if (!_objects.containsKey(nominal)) {
        _objects[nominal] = {};
      }
      if (!_objects[nominal]!.containsKey(T)) {
        _objects[nominal]![T] = {};
      }
      _objects[nominal]![T] = instance;
    }
  }

  T get<T>({Nominal nominal = Nominal.DEFAULT}) {
    return _contains<T>(nominal: nominal)
        ? _objects[nominal]![T]
        : throw Exception('Class $T not registered!');
  }

  void remove<T>({Nominal nominal = Nominal.DEFAULT}) =>
      _objects[nominal]?.remove(T);

  void clear() => _objects.clear();

  static void setUpDependencies() {
    Injector injector = Injector.instance;

    //Database
    injector._add<DbHelper>(DbHelper());
    injector._add<FirebaseDatabase>(FirebaseDatabase.instance);
    injector._add<FirebaseFirestore>(FirebaseFirestore.instance);
    // repositories
    //Sqlite
    injector._add<DebtRepository>(
        DebtSqliteRepositoryImpl(injector.get<DbHelper>()),
        nominal: Nominal.SQLITE);
    injector._add<DebtorRepository>(
        DebtorSqliteRepositoryImpl(injector.get<DbHelper>()),
        nominal: Nominal.SQLITE);
    //Firebase database
    injector._add<DebtorRepository>(
        DebtorFirebaseRepositoryImpl(injector.get<FirebaseDatabase>()),
        nominal: Nominal.FIREBASE_DATABASE);
    injector._add<DebtRepository>(
        DebtFirebaseRepositoryImpl(injector.get<FirebaseDatabase>()),
        nominal: Nominal.FIREBASE_DATABASE);
    //Firebase firestore
    injector._add<DebtorRepository>(
        DebtorFirestoreRepositoryImpl(injector.get<FirebaseFirestore>()),
        nominal: Nominal.FIREBASE_FIRESTORE);
    injector._add<DebtRepository>(
        DebtFirestoreRepositoryImpl(injector.get<FirebaseFirestore>()),
        nominal: Nominal.FIREBASE_FIRESTORE);
  }
}
