import 'package:sqflite/sqflite.dart';
import '../models/categoria_espacio.dart';
import 'categoria_dao.dart';
import 'database_provider.dart';

/// Implementación SQLite del DAO de categorías
/// Sigue el principio de responsabilidad única (SRP)
class SqliteCategoriaDAO implements CategoriaDAO {
  static const String tableName = 'categorias';

  /// Obtiene la instancia de la base de datos
  Future<Database> get _db async => await DatabaseProvider.instance.database;

  @override
  Future<CategoriaEspacio?> obtenerPorId(String id) async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'idCategoria = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) {
      return null;
    }

    return CategoriaEspacio.fromJson(maps.first);
  }

  @override
  Future<List<CategoriaEspacio>> obtenerTodas() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      orderBy: 'tipo, nombre',
    );

    return maps.map((map) => CategoriaEspacio.fromJson(map)).toList();
  }

  @override
  Future<List<CategoriaEspacio>> obtenerPorTipo(TipoCategoria tipo) async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'tipo = ?',
      whereArgs: [tipo.name],
      orderBy: 'nombre',
    );

    return maps.map((map) => CategoriaEspacio.fromJson(map)).toList();
  }

  @override
  Future<void> crear(CategoriaEspacio categoria) async {
    final db = await _db;
    
    // Validar que no exista una categoría con el mismo nombre y tipo
    final existe = await existeCategoria(categoria.nombre, categoria.tipo);
    if (existe) {
      throw Exception('Ya existe una categoría con ese nombre y tipo');
    }

    await db.insert(
      tableName,
      categoria.toJson(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  @override
  Future<void> actualizar(CategoriaEspacio categoria) async {
    final db = await _db;
    
    // Validar que no exista otra categoría con el mismo nombre y tipo
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'nombre = ? AND tipo = ? AND idCategoria != ?',
      whereArgs: [categoria.nombre, categoria.tipo.name, categoria.idCategoria],
    );
    
    if (maps.isNotEmpty) {
      throw Exception('Ya existe otra categoría con ese nombre y tipo');
    }

    final count = await db.update(
      tableName,
      categoria.toJson(),
      where: 'idCategoria = ?',
      whereArgs: [categoria.idCategoria],
    );

    if (count == 0) {
      throw Exception('Categoría no encontrada');
    }
  }

  @override
  Future<void> eliminar(String id) async {
    final db = await _db;
    
    final count = await db.delete(
      tableName,
      where: 'idCategoria = ?',
      whereArgs: [id],
    );

    if (count == 0) {
      throw Exception('Categoría no encontrada');
    }
  }

  @override
  Future<bool> existeCategoria(String nombre, TipoCategoria tipo) async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'LOWER(nombre) = LOWER(?) AND tipo = ?',
      whereArgs: [nombre, tipo.name],
    );

    return maps.isNotEmpty;
  }
}
