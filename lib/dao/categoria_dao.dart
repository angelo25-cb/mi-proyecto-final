import '../models/categoria_espacio.dart';

/// DAO abstracto para el manejo de categorías de espacios
/// Sigue el principio de segregación de interfaces (ISP)
abstract class CategoriaDAO {
  /// Obtiene una categoría por su ID
  Future<CategoriaEspacio?> obtenerPorId(String id);
  
  /// Obtiene todas las categorías
  Future<List<CategoriaEspacio>> obtenerTodas();
  
  /// Obtiene categorías por tipo (tipoEspacio o nivelRuido)
  Future<List<CategoriaEspacio>> obtenerPorTipo(TipoCategoria tipo);
  
  /// Crea una nueva categoría
  Future<void> crear(CategoriaEspacio categoria);
  
  /// Actualiza una categoría existente
  Future<void> actualizar(CategoriaEspacio categoria);
  
  /// Elimina una categoría por su ID
  Future<void> eliminar(String id);
  
  /// Verifica si existe una categoría con el mismo nombre y tipo
  Future<bool> existeCategoria(String nombre, TipoCategoria tipo);
}
