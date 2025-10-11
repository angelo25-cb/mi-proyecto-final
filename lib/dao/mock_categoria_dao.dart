import '../models/categoria_espacio.dart';
import 'categoria_dao.dart';

/// Implementación Mock del DAO de categorías
/// Para desarrollo y testing sin base de datos real
class MockCategoriaDAO implements CategoriaDAO {
  // Almacenamiento en memoria
  static final List<CategoriaEspacio> _categorias = [
    // Tipos de Espacio predeterminados
    CategoriaEspacio(
      idCategoria: '1',
      nombre: 'Estudio',
      tipo: TipoCategoria.tipoEspacio,
      fechaCreacion: DateTime.now().subtract(const Duration(days: 30)),
    ),
    CategoriaEspacio(
      idCategoria: '2',
      nombre: 'Descanso',
      tipo: TipoCategoria.tipoEspacio,
      fechaCreacion: DateTime.now().subtract(const Duration(days: 25)),
    ),
    CategoriaEspacio(
      idCategoria: '3',
      nombre: 'Biblioteca',
      tipo: TipoCategoria.tipoEspacio,
      fechaCreacion: DateTime.now().subtract(const Duration(days: 20)),
    ),
    CategoriaEspacio(
      idCategoria: '4',
      nombre: 'Cafetería',
      tipo: TipoCategoria.tipoEspacio,
      fechaCreacion: DateTime.now().subtract(const Duration(days: 15)),
    ),
    // Niveles de Ruido predeterminados
    CategoriaEspacio(
      idCategoria: '5',
      nombre: 'Silencioso',
      tipo: TipoCategoria.nivelRuido,
      fechaCreacion: DateTime.now().subtract(const Duration(days: 30)),
    ),
    CategoriaEspacio(
      idCategoria: '6',
      nombre: 'Moderado',
      tipo: TipoCategoria.nivelRuido,
      fechaCreacion: DateTime.now().subtract(const Duration(days: 25)),
    ),
    CategoriaEspacio(
      idCategoria: '7',
      nombre: 'Ruidoso',
      tipo: TipoCategoria.nivelRuido,
      fechaCreacion: DateTime.now().subtract(const Duration(days: 20)),
    ),
    // Comodidades predeterminadas
    CategoriaEspacio(
      idCategoria: '8',
      nombre: 'WiFi',
      tipo: TipoCategoria.comodidad,
      fechaCreacion: DateTime.now().subtract(const Duration(days: 30)),
    ),
    CategoriaEspacio(
      idCategoria: '9',
      nombre: 'Aire Acondicionado',
      tipo: TipoCategoria.comodidad,
      fechaCreacion: DateTime.now().subtract(const Duration(days: 28)),
    ),
    CategoriaEspacio(
      idCategoria: '10',
      nombre: 'Enchufes',
      tipo: TipoCategoria.comodidad,
      fechaCreacion: DateTime.now().subtract(const Duration(days: 26)),
    ),
    CategoriaEspacio(
      idCategoria: '11',
      nombre: 'Computadoras',
      tipo: TipoCategoria.comodidad,
      fechaCreacion: DateTime.now().subtract(const Duration(days: 24)),
    ),
    // Capacidades predeterminadas
    CategoriaEspacio(
      idCategoria: '12',
      nombre: 'Individual',
      tipo: TipoCategoria.capacidad,
      fechaCreacion: DateTime.now().subtract(const Duration(days: 30)),
    ),
    CategoriaEspacio(
      idCategoria: '13',
      nombre: 'Pequeño Grupo (2-5)',
      tipo: TipoCategoria.capacidad,
      fechaCreacion: DateTime.now().subtract(const Duration(days: 28)),
    ),
    CategoriaEspacio(
      idCategoria: '14',
      nombre: 'Grupo Grande (6+)',
      tipo: TipoCategoria.capacidad,
      fechaCreacion: DateTime.now().subtract(const Duration(days: 26)),
    ),
    // Bloques Horarios predeterminados
    CategoriaEspacio(
      idCategoria: '15',
      nombre: 'Mañana (08:00 - 12:00)',
      tipo: TipoCategoria.bloqueHorario,
      fechaCreacion: DateTime.now().subtract(const Duration(days: 30)),
    ),
    CategoriaEspacio(
      idCategoria: '16',
      nombre: 'Tarde (12:00 - 18:00)',
      tipo: TipoCategoria.bloqueHorario,
      fechaCreacion: DateTime.now().subtract(const Duration(days: 28)),
    ),
    CategoriaEspacio(
      idCategoria: '17',
      nombre: 'Noche (18:00 - 22:00)',
      tipo: TipoCategoria.bloqueHorario,
      fechaCreacion: DateTime.now().subtract(const Duration(days: 26)),
    ),
  ];

  @override
  Future<CategoriaEspacio?> obtenerPorId(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      return _categorias.firstWhere((c) => c.idCategoria == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<CategoriaEspacio>> obtenerTodas() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(_categorias);
  }

  @override
  Future<List<CategoriaEspacio>> obtenerPorTipo(TipoCategoria tipo) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _categorias.where((c) => c.tipo == tipo).toList();
  }

  @override
  Future<void> crear(CategoriaEspacio categoria) async {
    await Future.delayed(const Duration(milliseconds: 100));
    
    // Validar que no exista una categoría con el mismo nombre y tipo
    final existe = await existeCategoria(categoria.nombre, categoria.tipo);
    if (existe) {
      throw Exception('Ya existe una categoría con ese nombre y tipo');
    }
    
    _categorias.add(categoria);
  }

  @override
  Future<void> actualizar(CategoriaEspacio categoria) async {
    await Future.delayed(const Duration(milliseconds: 100));
    
    final index = _categorias.indexWhere((c) => c.idCategoria == categoria.idCategoria);
    if (index == -1) {
      throw Exception('Categoría no encontrada');
    }
    
    // Validar que no exista otra categoría con el mismo nombre y tipo
    final existeOtra = _categorias.any((c) =>
        c.idCategoria != categoria.idCategoria &&
        c.nombre.toLowerCase() == categoria.nombre.toLowerCase() &&
        c.tipo == categoria.tipo);
    
    if (existeOtra) {
      throw Exception('Ya existe otra categoría con ese nombre y tipo');
    }
    
    _categorias[index] = categoria;
  }

  @override
  Future<void> eliminar(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    
    final index = _categorias.indexWhere((c) => c.idCategoria == id);
    if (index == -1) {
      throw Exception('Categoría no encontrada');
    }
    
    _categorias.removeAt(index);
  }

  @override
  Future<bool> existeCategoria(String nombre, TipoCategoria tipo) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return _categorias.any((c) =>
        c.nombre.toLowerCase() == nombre.toLowerCase() && c.tipo == tipo);
  }
}
