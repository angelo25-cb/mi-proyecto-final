import '../models/reporte_ocupacion.dart';
import 'reporte_ocupacion_dao.dart';

class MockReporteOcupacionDAO implements ReporteOcupacionDAO {
  static final List<ReporteOcupacion> _reportes = [
    ReporteOcupacion(
      idReporte: '1',
      estadoReportado: 'Lleno',
      fecha: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    ReporteOcupacion(
      idReporte: '2',
      estadoReportado: 'Medio',
      fecha: DateTime.now().subtract(const Duration(hours: 4)),
    ),
    ReporteOcupacion(
      idReporte: '3',
      estadoReportado: 'Vacio',
      fecha: DateTime.now().subtract(const Duration(hours: 1)),
    ),
  ];

  @override
  Future<ReporteOcupacion?> obtenerPorId(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      return _reportes.firstWhere((r) => r.idReporte == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<ReporteOcupacion>> obtenerPorEspacio(String espacioId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    // Mock implementation - returns all reportes for simplicity
    return List.from(_reportes);
  }

  @override
  Future<List<ReporteOcupacion>> obtenerPorUsuario(String usuarioId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    // Mock implementation - returns all reportes for simplicity
    return List.from(_reportes);
  }

  @override
  Future<List<ReporteOcupacion>> obtenerTodos() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(_reportes);
  }

  @override
  Future<void> crear(ReporteOcupacion reporte) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _reportes.add(reporte);
  }

  @override
  Future<void> actualizar(ReporteOcupacion reporte) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final index = _reportes.indexWhere((r) => r.idReporte == reporte.idReporte);
    if (index != -1) {
      _reportes[index] = reporte;
    }
  }

  @override
  Future<void> eliminar(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _reportes.removeWhere((r) => r.idReporte == id);
  }
}
