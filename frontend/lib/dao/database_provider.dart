import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const String _dbName = 'smart_break.db';
  static const int _dbVersion = 1;

  DatabaseProvider._();
  static final DatabaseProvider instance = DatabaseProvider._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _dbName);

    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    // Table 'espacios' stores complex fields (ubicacion, caracteristicas) as JSON
    await db.execute('''
      CREATE TABLE espacios(
        idEspacio TEXT PRIMARY KEY,
        nombre TEXT,
        tipo TEXT,
        nivelOcupacion TEXT,
        promedioCalificacion REAL,
        ubicacion TEXT,
        caracteristicas TEXT
      )
    ''');
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) await db.close();
    _database = null;
  }
}
