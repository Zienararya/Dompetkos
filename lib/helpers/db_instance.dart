import 'dart:io';
import 'package:dompetkos/models/transaksi.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseInstance {
  static final DatabaseInstance _instance = DatabaseInstance._internal();
  static Database? _database;
  final String _databaseName = 'dompetkos.db';
  final int _databaseVersion = 1;

  factory DatabaseInstance() {
    return _instance;
  }

  DatabaseInstance._internal();

  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
    CREATE TABLE "transactions" (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date DATETIME,
      category TEXT,
      amount INTEGER ,
      desc TEXT,
      type TEXT,
      isreminder BOOL
    )
  ''');
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchTransactions() async {
    final db = await database();
    return await db.query('transactions');
  }

  Future<List<TransactionModel>> all() async {
    final db = await database();
    final data = await db.query('transactions');
    return data.map((e) => TransactionModel.fromJson(e)).toList();
  }

  Future<int> insertTransaction(Map<String, dynamic> row) async {
    final db = await database();
    final query = await db.insert('transactions', row);
    return query;
  }

  Future<int> deleteTransaction(int id) async {
    final db = await database();
    return await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    await databaseFactory.deleteDatabase(path);
  }
}
