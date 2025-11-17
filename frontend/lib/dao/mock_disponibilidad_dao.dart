import '../models/disponibilidad.dart';

class MockDisponibilidadDAO {
  static final List<Disponibilidad> _disponibilidades = [];

  Future<Disponibilidad?> obtenerPorEspacio(String idEspacio) async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      return _disponibilidades.firstWhere((d) => d.idEspacio == idEspacio);
    } catch (_) {
      return null;
    }
  }

  Future<void> guardar(Disponibilidad disponibilidad) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final index =
        _disponibilidades.indexWhere((d) => d.idEspacio == disponibilidad.idEspacio);

    if (index == -1) {
      _disponibilidades.add(disponibilidad);
    } else {
      _disponibilidades[index] = disponibilidad;
    }
  }

  Future<void> eliminar(String idEspacio) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _disponibilidades.removeWhere((d) => d.idEspacio == idEspacio);
  }
}
