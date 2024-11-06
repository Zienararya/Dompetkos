import 'dart:io';
import 'package:dompetkos/models/kategori.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseInstance{
  final String _databaseName = 'dompetkos.db';
  final int _databaseVersion = 1;

  // Category table
  final String table = 'category';
  final String id = 'id_category';
  final String name = 'name_category';
  final String desc = 'desc_category';
  final String icon = 'icon_category';
  // Transaction table
  // Budget table
  // Reminder table

  Database? _database;
  Future<Database> database() async{
    if(_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future _initDatabase() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async{
    await db.execute(
      'Create Table $table ($id INTEGER PRIMARY KEY, $name TEXT, $desc TEXT, $icon TEXT) '
      );
  }

  Future<List<CategoryModel>> all() async{
    final data= await _database!.query(table);
    List<CategoryModel> result =
    data.map((e) =>CategoryModel.fromJson(e)).toList();
    return result;
  }

  Future<int> insert(Map<String, dynamic> row) async{
    final query = await _database!.insert(table, row);
    return query;
  }
}