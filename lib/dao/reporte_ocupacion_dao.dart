import '../models/reporte_ocupacion.dart';

abstract class ReporteOcupacionDAO {
  Future<ReporteOcupacion?> obtenerPorId(String id);
  Future<List<ReporteOcupacion>> obtenerPorEspacio(String espacioId);
  Future<List<ReporteOcupacion>> obtenerPorUsuario(String usuarioId);
  Future<List<ReporteOcupacion>> obtenerTodos();
  Future<void> crear(ReporteOcupacion reporte);
  Future<void> actualizar(ReporteOcupacion reporte);
  Future<void> eliminar(String id);
}
