// lib/dao/http_espacio_dao.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/espacio.dart';
import 'espacio_dao.dart';

class HttpEspacioDAO implements EspacioDAO {
  final String baseUrl;

  HttpEspacioDAO({required this.baseUrl});

  Uri _uri([String path = '']) => Uri.parse('$baseUrl/espacios$path');

  // 🔹 Normaliza el JSON que viene del backend para adaptarlo
  // al Espacio.fromJson() del front
  Map<String, dynamic> _normalizeEspacioJson(Map<String, dynamic> json) {
    final normalized = Map<String, dynamic>.from(json);

    // _id -> idEspacio (por si el back usa _id de Mongo)
    if (!normalized.containsKey('idEspacio') && normalized['_id'] != null) {
      normalized['idEspacio'] = normalized['_id'];
    }

    // nivelOcupacion por defecto
    normalized['nivelOcupacion'] ??= 'medio';

    // promedioCalificacion siempre double
    final prom = normalized['promedioCalificacion'];
    if (prom is int) {
      normalized['promedioCalificacion'] = prom.toDouble();
    } else if (prom == null) {
      normalized['promedioCalificacion'] = 0.0;
    }

    // ubicacion con idUbicacion
    if (normalized['ubicacion'] != null && normalized['ubicacion'] is Map) {
      final ubic = Map<String, dynamic>.from(
          normalized['ubicacion'] as Map<String, dynamic>);
      ubic['idUbicacion'] ??=
          normalized['idEspacio'] ?? normalized['_id'] ?? 'ubic-auto';
      normalized['ubicacion'] = ubic;
    }

    // listas nunca nulas
    normalized['caracteristicas'] ??= [];
    normalized['categoriaIds'] ??= [];

    return normalized;
  }

  List<dynamic> _extractList(dynamic body) {
    if (body is List) return body;
    if (body is Map) {
      if (body['data'] is List) return body['data'];
      if (body['espacios'] is List) return body['espacios'];
    }
    return [];
  }

  Map<String, String> _headers() => {
        'Content-Type': 'application/json',
      };

  @override
  Future<List<Espacio>> obtenerTodos() async {
    final resp = await http.get(_uri(), headers: _headers());

    if (resp.statusCode != 200) {
      throw Exception(
          'Error al cargar espacios (${resp.statusCode}): ${resp.body}');
    }

    final decoded = jsonDecode(resp.body);
    final list = _extractList(decoded);

    return list
        .map((e) =>
            Espacio.fromJson(_normalizeEspacioJson(e as Map<String, dynamic>)))
        .toList();
  }

  @override
  Future<Espacio?> obtenerPorId(String id) async {
    final resp = await http.get(_uri('/$id'), headers: _headers());

    if (resp.statusCode == 404) return null;
    if (resp.statusCode != 200) {
      throw Exception(
          'Error al obtener espacio ($id) (${resp.statusCode}): ${resp.body}');
    }

    final decoded = jsonDecode(resp.body);
    final json = decoded is Map && decoded['data'] != null
        ? decoded['data']
        : decoded;

    return Espacio.fromJson(
        _normalizeEspacioJson(json as Map<String, dynamic>));
  }

  // Por ahora estos filtros los hacemos en memoria usando obtenerTodos()

  @override
  Future<List<Espacio>> obtenerPorTipo(String tipo) async {
    final todos = await obtenerTodos();
    return todos
        .where((e) => e.tipo.toLowerCase() == tipo.toLowerCase())
        .toList();
  }

  @override
  Future<List<Espacio>> obtenerPorNivelOcupacion(String nivel) async {
    final todos = await obtenerTodos();
    return todos
        .where((e) => e.nivelOcupacion.name.toLowerCase() == nivel.toLowerCase())
        .toList();
  }

  @override
  Future<List<Espacio>> filtrarPorCaracteristicas(
      Map<String, String> filtros) async {
    final todos = await obtenerTodos();
    return todos.where((espacio) {
      return filtros.entries.every((filtro) {
        return espacio.caracteristicas.any((c) =>
            c.nombre.toLowerCase() == filtro.key.toLowerCase() &&
            c.valor.toLowerCase().contains(filtro.value.toLowerCase()));
      });
    }).toList();
  }

  // Estos los dejamos pendientes hasta que quieras crear/editar desde la app

  @override
  Future<void> crear(Espacio espacio) async {
    throw UnimplementedError(
        'crear() aún no está implementado en HttpEspacioDAO');
  }

  @override
  Future<void> actualizar(Espacio espacio) async {
    throw UnimplementedError(
        'actualizar() aún no está implementado en HttpEspacioDAO');
  }

  @override
  Future<void> eliminar(String id) async {
    throw UnimplementedError(
        'eliminar() aún no está implementado en HttpEspacioDAO');
  }
}
