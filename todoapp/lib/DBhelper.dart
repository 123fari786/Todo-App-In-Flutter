import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Create Table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE tasks(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      description TEXT,
      category TEXT
    )
    ''');
  }

  // Add
  Future<int> insertTask(Map<String, dynamic> task) async {
    final db = await instance.database;
    return db.insert('tasks', task);
  }

  // Display
  Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await instance.database;
    return db.query('tasks');
  }
}
