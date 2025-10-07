import '../models/calificacion.dart';
import 'calificacion_dao.dart';

/// Implementación mock del patrón DAO para gestionar calificaciones.
/// Simula una base de datos en memoria con una lista estática.
class MockCalificacionDAO implements CalificacionDAO {
  static final List<Calificacion> _calificaciones = [
    Calificacion(
      idCalificacion: '1',
      puntuacion: 5,
      comentario: 'Excelente lugar para estudiar, muy silencioso',
      fecha: DateTime.now().subtract(const Duration(days: 2)),
      estado: EstadoCalificacion.aprobada,
    ),
    Calificacion(
      idCalificacion: '2',
      puntuacion: 4,
      comentario: 'Buen ambiente, pero a veces hay mucho ruido',
      fecha: DateTime.now().subtract(const Duration(days: 5)),
      estado: EstadoCalificacion.aprobada,
    ),
    Calificacion(
      idCalificacion: '3',
      puntuacion: 3,
      comentario: 'Regular, podría mejorar la limpieza',
      fecha: DateTime.now().subtract(const Duration(days: 7)),
      estado: EstadoCalificacion.pendiente,
    ),
  ];

  @override
  Future<Calificacion?> obtenerPorId(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      return _calificaciones.firstWhere((c) => c.idCalificacion == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Calificacion>> obtenerPorEspacio(String espacioId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    // Simulación: en esta versión mock devolvemos todas las calificaciones
    return List.from(_calificaciones);
  }

  @override
  Future<List<Calificacion>> obtenerPorUsuario(String usuarioId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    // Simulación: en esta versión mock devolvemos todas las calificaciones
    return List.from(_calificaciones);
  }

  @override
  Future<List<Calificacion>> obtenerTodas() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(_calificaciones);
  }

  @override
  Future<void> crear(Calificacion calificacion) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _calificaciones.add(calificacion);
  }

  @override
  Future<void> actualizar(Calificacion calificacion) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final index = _calificaciones.indexWhere(
        (c) => c.idCalificacion == calificacion.idCalificacion);
    if (index != -1) {
      _calificaciones[index] = calificacion;
    }
  }

  @override
  Future<void> eliminar(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _calificaciones.removeWhere((c) => c.idCalificacion == id);
  }
}
