import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../model/Debtor.dart';
import '../model/Invoice.dart';

class DbHelper {
  // Table Debtor
  String tableDebtor = "debtor";
  String columnDebtorId = "id";
  String columnDebtorName = "name";
  String columnDebtorCity = "city";

  // Table Invoice
  String tableInvoice = "invoice";
  String columnInvoiceId = "id";
  String columnInvoiceDatePayment = "datePayment";
  String columnInvoiceTypePayment = "typePayment";
  String columnInvoiceDescriptionPayment = "descriptionPayment";
  String columnInvoiceValuePayment = "valuePayment";
  String columnInvoiceVDebtor = "debtor";

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
    String path = "${dir.path}my_debtors.db";
    var dbMyDebtors = await openDatabase(path,
        version: 1, onCreate: _createDb, onConfigure: _onConfigure);
    return dbMyDebtors;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tableDebtor ($columnDebtorId INTEGER PRIMARY KEY AUTOINCREMENT, $columnDebtorName TEXT, $columnDebtorCity TEXT);");
    await db.execute("CREATE TABLE $tableInvoice ("
        "$columnInvoiceId INTEGER PRIMARY KEY AUTOINCREMENT, $columnInvoiceDatePayment DATE, $columnInvoiceTypePayment TEXT,"
        "$columnInvoiceDescriptionPayment TEXT, $columnInvoiceValuePayment DOUBLE,"
        "$columnInvoiceVDebtor INTEGER, "
        "FOREIGN KEY ($columnInvoiceVDebtor) REFERENCES $tableDebtor (id) ON DELETE CASCADE ON UPDATE CASCADE"
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

  Future<int> insertInvoice(Invoice invoice) async {
    Database db = await this.db;
    var result = await db.insert(tableInvoice, invoice.toJson());
    return result;
  }

  Future<List> getAllDebtors() async {
    Database db = await this.db;
    var result = await db
        .rawQuery("SELECT * FROM $tableDebtor order by $columnDebtorId ASC");
    return result;
  }

  Future<List> getAllInvoicesByDebtor(int debtorId) async {
    Database db = await this.db;
    var result = await db.query(tableInvoice,
        where: "$columnInvoiceVDebtor = $debtorId");
    return result;
  }

  Future<int> getCountDebtors() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT (*) FROM $tableDebtor"));
    return result!;
  }

  Future<int> getCountInvoicesByDebtor(int debtorId) async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT COUNT (*) FROM $tableInvoice WHERE $columnInvoiceVDebtor = $debtorId"));
    return result!;
  }

  Future<int> updateDebtor(Debtor debtor) async {
    var db = await this.db;
    var result = await db.update(tableDebtor, debtor.toJson(),
        where: "$columnDebtorId = ?", whereArgs: [debtor.id]);
    return result;
  }

  Future<int> updateInvoice(Invoice invoice) async {
    var db = await this.db;
    var result = await db.update(tableInvoice, invoice.toJson(),
        where: "$columnInvoiceId = ?", whereArgs: [invoice.id]);
    return result;
  }

  Future<int> deleteDebtor(int id) async {
    int result;
    var db = await this.db;
    result = await db
        .rawDelete('DELETE FROM $tableDebtor WHERE $columnDebtorId = $id');
    return result;
  }

  Future<int> deleteInvoice(int id) async {
    int result;
    var db = await this.db;
    result = await db
        .rawDelete('DELETE FROM $tableInvoice WHERE $columnDebtorId = $id');
    return result;
  }
}
