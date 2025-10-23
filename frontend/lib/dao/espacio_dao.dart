import '../models/espacio.dart';

abstract class EspacioDAO {
  Future<Espacio?> obtenerPorId(String id);
  Future<List<Espacio>> obtenerTodos();
  Future<List<Espacio>> obtenerPorTipo(String tipo);
  Future<List<Espacio>> obtenerPorNivelOcupacion(String nivel);
  Future<List<Espacio>> filtrarPorCaracteristicas(Map<String, String> filtros);
  Future<void> crear(Espacio espacio);
  Future<void> actualizar(Espacio espacio);
  Future<void> eliminar(String id);
}
