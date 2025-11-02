import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/order.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('orders.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE orders(
        id TEXT PRIMARY KEY,
        billNo TEXT,
        billSrl TEXT,
        billDate TEXT,
        status TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertOrder(Order order) async {
    final db = await instance.database;
    await db.insert(
      'orders',
      order.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Order>> fetchAllOrders() async {
    final db = await instance.database;
    final maps = await db.query('orders');
    return maps.map((map) => Order.fromMap(map)).toList();
  }

  Future<void> clearOrders() async {
    final db = await instance.database;
    await db.delete('orders');
  }

  Future close() async {
    final db = await instance.database;
    await db.close();
  }
}
