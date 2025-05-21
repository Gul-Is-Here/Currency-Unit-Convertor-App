// app/data/local/database_helper.dart
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper extends GetxService {
  late Database _database;

  Future<DatabaseHelper> init() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'unit_converter.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE conversion_history(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            category TEXT,
            fromValue REAL,
            fromUnit TEXT,
            toValue REAL,
            toUnit TEXT,
            timestamp INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE currency_rates(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            currencyCode TEXT UNIQUE,
            rate REAL,
            lastUpdated INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS favorites(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            category TEXT,
            fromValue REAL,
            fromUnit TEXT,
            toValue REAL,
            toUnit TEXT,
            timestamp INTEGER
          )
        ''');
      },
      version: 1,
    );
    return this;
  }

  // Conversion History Methods
  Future<int> insertConversion(Map<String, dynamic> conversion) async {
    return await _database.insert('conversion_history', conversion);
  }

  Future<List<Map<String, dynamic>>> getRecentConversions(String category) async {
    return await _database.query(
      'conversion_history',
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'timestamp DESC',
      limit: 10,
    );
  }

  // Currency Rate Methods
  Future<int> updateCurrencyRate(String code, double rate) async {
    return await _database.rawInsert('''
      INSERT OR REPLACE INTO currency_rates (currencyCode, rate, lastUpdated)
      VALUES (?, ?, ?)
    ''', [code, rate, DateTime.now().millisecondsSinceEpoch]);
  }

  Future<double?> getCurrencyRate(String code) async {
    final result = await _database.query(
      'currency_rates',
      where: 'currencyCode = ?',
      whereArgs: [code],
    );
    if (result.isNotEmpty) {
      return result.first['rate'] as double?;
    }
    return null;
  }

  Future<DateTime?> getLastUpdated() async {
    final result = await _database.query(
      'currency_rates',
      orderBy: 'lastUpdated DESC',
      limit: 1,
    );
    if (result.isNotEmpty) {
      return DateTime.fromMillisecondsSinceEpoch(result.first['lastUpdated'] as int);
    }
    return null;
  }

  // Favorite Methods
  Future<int> addFavorite(Map<String, dynamic> favorite) async {
    return await _database.insert('favorites', favorite);
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    return await _database.query('favorites');
  }

  Future<int> removeFavorite(int id) async {
    return await _database.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Generic Query Method
  Future<List<Map<String, dynamic>>> query(
    String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    return await _database.query(
      table,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }
}