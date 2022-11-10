import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  DB._();

  static final DB instance = DB._();

  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'cade_o_dinheiro.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, versao) async {
    await db.execute(_wallets);
    await db.execute(_budgets);
    await db.execute(_transactions);
  }

  String get _wallets => '''
    CREATE TABLE wallets (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      value REAL
    );
  ''';

  String get _budgets => '''
    CREATE TABLE budgets (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      value REAL,
      goal TEXT
    );
  ''';

  String get _transactions => '''
    CREATE TABLE transactions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      total REAL,
      transaction_type TEXT,
      date INT,
      wallet_id INTEGER,
      budget_id INTEGER
    );
  ''';
}
