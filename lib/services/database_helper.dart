import 'package:hackernews_topstories/models/article.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DataBaseHelper {
  static DataBaseHelper _dataBaseHelper;
  static Database _database;

  String newsTable = 'news_table';
  String colBy = 'by';
  String colId = 'id';
  String colTableId = 'table_id';
  String colTitle = 'title';
  String colTime = 'time';
  String colType = 'type';
  String colUrl = 'url';

  DataBaseHelper._createInstance();

  factory DataBaseHelper() {
    if (_dataBaseHelper == null) {
      _dataBaseHelper = DataBaseHelper._createInstance();
    }
    return _dataBaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'news.db';

    var newsDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: createDatabase,
    );
    return newsDatabase;
  }

  void createDatabase(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $newsTable($colTableId INTEGER PRIMARY KEY AUTOINCREMENT, $colBy TEXT, $colId INTEGER, $colTime INTEGER, $colTitle TEXT,$colType TEXT,$colUrl TEXT)',
    );
  }

  //insert news article
  Future<int> insertNews(Article article) async {
    Database db = await this.database;
    var result = await db.insert(
      newsTable,
      article.toMap(),
    );
    print('inserted in table');
    return result;
  }

  //check if id exist
  Future<int> idInDatabase(int id) async {
    Database db = await this.database;
    var query = await db.rawQuery(
      'SELECT COUNT(*) FROM $newsTable WHERE $colId =$id',
    );
    var result = Sqflite.firstIntValue(query);
    return result;
  }

  //read news article
  Future<Map<String, dynamic>> readNewsFromDatabase(int index) async {
    Database db = await this.database;
    var res = await db.rawQuery(
      'SELECT * FROM $newsTable WHERE $colId = $index',
    );
    var result = res[0];
    print('from database');
    return result;
  }
}
