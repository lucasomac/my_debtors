import '../data/repository/debt_repository_impl.dart';
import '../data/repository/debtor_repository_impl.dart';
import '../domain/repository/debt_repository.dart';
import '../domain/repository/debtor_repository.dart';
import '../util/db_helper.dart';

class Injector {
  static Injector? _instance;

  static Injector get instance => _instance ??= Injector._();

  Injector._();

  final Map<Type, dynamic> _objects = {};

  bool contains<T>() => _objects.containsKey(T);

  void add<T>(T instance) => contains<T>()
      ? throw Exception('Class ${T.runtimeType} already registered!')
      : _objects[T] = instance;

  T get<T>() => contains<T>()
      ? _objects[T]
      : throw Exception('Class ${T.runtimeType} not registered!');

  void remove<T>() => _objects.remove(T);

  void clear() => _objects.clear();

  static void setUpDependencies() {
    Injector injector = Injector.instance;

    //Database
    injector.add<DbHelper>(DbHelper());
    // repositories
    injector.add<DebtRepository>(DebtRepositoryImpl(injector.get<DbHelper>()));
    injector
        .add<DebtorRepository>(DebtorRepositoryImpl(injector.get<DbHelper>()));
  }
}
