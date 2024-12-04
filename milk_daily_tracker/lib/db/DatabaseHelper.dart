import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/DefaultSetting.dart';
import '../models/Expense.dart';
import '../models/MilkDelivery.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tracker_app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Trackers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        goal TEXT,
        frequency TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS Entries (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tracker_id INTEGER NOT NULL,
        date DATE NOT NULL,
        value TEXT,
        notes TEXT,
        FOREIGN KEY(tracker_id) REFERENCES Trackers(id)
      )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS MilkDelivery (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date DATE NOT NULL,
      quantity REAL NOT NULL,
      price REAL NOT NULL,
      milkman_name TEXT,
      tracker_id INTEGER,
      FOREIGN KEY(tracker_id) REFERENCES Trackers(id)
    );
    ''');

    await db.execute('''
    CREATE TABLE Expenses (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date TEXT NOT NULL,
      amount REAL NOT NULL,
      category TEXT NOT NULL,
      description TEXT,
      tracker_id INTEGER,
      FOREIGN KEY(tracker_id) REFERENCES Trackers(id)
    );
    ''');

    await db.execute('''
    CREATE TABLE Defaults (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    key TEXT NOT NULL UNIQUE,
    value TEXT
  );
    ''');
  }

  Future<int> insert(String table, Map<String, Object?> values) async {
    final db = await instance.database;
    return await db.insert(table, values);
  }

  Future<List<Map<String, Object?>>> query(
    String table, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final db = await instance.database;
    return await db.query(table, where: where, whereArgs: whereArgs);
  }

  Future<List<Map<String, Object?>>> queryCols(
    String table, {
    String? where,
    List<Object?>? whereArgs,
        int? limit,
        List<String>? columns,
  }) async {
    final db = await instance.database;
    return await db.query(table, where: where, whereArgs: whereArgs,columns: columns,limit: limit);
  }



  Future<void> close() async {
    final db = await _database;
    if (db != null) await db.close();
  }

  // Insert a milk delivery record
  Future<void> insertMilkDelivery(MilkDelivery milkDelivery) async {
    final db = await instance.database;
    await db.insert(
      'MilkDelivery',
      milkDelivery.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insertExpense(Expense expense) async {
    final db = await database;
    return await db.insert('Expenses', expense.toMap());
  }

  Future<List<Expense>> fetchExpensesByDate(String date, int trackerId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'Expenses',
      where: 'date = ? AND tracker_id=?',
      whereArgs: [date, trackerId],
    );

    return result.map((expense) => Expense.fromMap(expense)).toList();
  }

  Future<List<Expense>> fetchAllExpenses(trackerId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'Expenses',
      where: 'trackerId=?',
      whereArgs: [trackerId],
    );

    return result.map((expense) => Expense.fromMap(expense)).toList();
  }

  Future<int> updateExpense(Expense expense) async {
    final db = await database;
    return await db.update(
      'Expenses',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  Future<int> deleteExpense(int id) async {
    final db = await database;
    return await db.delete('Expenses', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> insertOrUpdateDefault(String key, String? value) async {
    final db = await database;
    await db.insert('Defaults', {
      'key': key,
      'value': value,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<String?> fetchDefaultByKey(String key) async {
    final db = await database;
    final result = await db.query(
      'Defaults',
      where: 'key = ?',
      whereArgs: [key],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first['value'] as String?;
    }
    return null;
  }

  Future<List<DefaultSetting>> fetchAllDefaults() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('Defaults');
    return result.map((entry) => DefaultSetting.fromMap(entry)).toList();
  }

  Future<void> deleteSetting(String key) async {
    final db = await database;
    await db.delete(
      'Defaults',
      where: 'key = ?',
      whereArgs: [key],
    );
  }


  Map<String, String?> appDefaults = {};

  void loadDefaults() async {
    List<DefaultSetting> defaults =
        await DatabaseHelper.instance.fetchAllDefaults();
    for (var defaultSetting in defaults) {
      appDefaults[defaultSetting.key] = defaultSetting.value;
    }
  }
}
