import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../domain/model/debt.dart';
import '../domain/model/debtor.dart';

class DbHelper {
  // Table Debtor
  String tableDebtor = "debtor";
  String columnDebtorId = "id";
  String columnDebtorName = "name";
  String columnDebtorCity = "city";
  String columnDebtorEmail = "email";
  String columnDebtorCellphone = "cellphone";

  // Table Debt
  String tableDebt = "debt";
  String columnDebtId = "id";
  String columnDebtDatePayment = "datePayment";
  String columnDebtTypePayment = "typePayment";
  String columnDebtDescriptionPayment = "description";
  String columnDebtValuePayment = "value";
  String columnDebtDebtor = "debtor";

  DbHelper._internal();

  static final DbHelper _dbHelper = DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = "${dir.path}mydebtors.db";
    var dbMyDebtors = await openDatabase(path,
        version: 2, onCreate: _createDb, onConfigure: _onConfigure);
    return dbMyDebtors;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tableDebtor ($columnDebtorId INTEGER PRIMARY KEY AUTOINCREMENT, $columnDebtorName TEXT, $columnDebtorCity TEXT, $columnDebtorEmail TEXT, $columnDebtorCellphone TEXT);");
    await db.execute("CREATE TABLE $tableDebt ("
        "$columnDebtId INTEGER PRIMARY KEY AUTOINCREMENT, $columnDebtDatePayment TEXT, $columnDebtTypePayment TEXT,"
        "$columnDebtDescriptionPayment TEXT, $columnDebtValuePayment DOUBLE,"
        "$columnDebtDebtor INTEGER, "
        "FOREIGN KEY ($columnDebtDebtor) REFERENCES $tableDebtor (id) ON DELETE CASCADE ON UPDATE CASCADE"
        ")");
  }

  static Database? _db;

  Future<Database> get db async {
    _db ??= await initializeDb();
    return _db!;
  }

  Future<int> insertDebtor(Debtor debtor) async {
    Database db = await this.db;
    var result = await db.insert(tableDebtor, debtor.toJson());
    return result;
  }

  Future<int> insertDebt(Debt debt) async {
    Database db = await this.db;
    var result = await db.insert(tableDebt, debt.toJson());
    return result;
  }

  Future<List> getAllDebtors() async {
    Database db = await this.db;
    var result = await db
        .rawQuery("SELECT * FROM $tableDebtor order by $columnDebtorId ASC");
    return result;
  }

  Future<List> getAllDebtsByDebtor(int debtorId) async {
    Database db = await this.db;
    var result =
        await db.query(tableDebt, where: "$columnDebtDebtor = $debtorId");
    return result;
  }

  Future<int> getCountDebtors() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT (*) FROM $tableDebtor"));
    return result!;
  }

  Future<int> getCountDebtsByDebtor(int debtorId) async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT COUNT (*) FROM $tableDebt WHERE $columnDebtDebtor = $debtorId"));
    return result!;
  }

  Future<int> updateDebtor(Debtor debtor) async {
    var db = await this.db;
    var result = await db.update(tableDebtor, debtor.toJson(),
        where: "$columnDebtorId = ?", whereArgs: [debtor.id]);
    return result;
  }

  Future<int> updateDebt(Debt debt) async {
    var db = await this.db;
    var result = await db.update(tableDebt, debt.toJson(),
        where: "$columnDebtId = ?", whereArgs: [debt.id]);
    return result;
  }

  Future<int> deleteDebtor(int id) async {
    int result;
    var db = await this.db;
    result = await db
        .rawDelete('DELETE FROM $tableDebtor WHERE $columnDebtorId = $id');
    return result;
  }

  Future<int> deleteDebt(int id) async {
    int result;
    var db = await this.db;
    result = await db
        .rawDelete('DELETE FROM $tableDebt WHERE $columnDebtorId = $id');
    return result;
  }
}
