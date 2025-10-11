import 'usuario.dart';
import 'ubicacion.dart';

class Estudiante extends Usuario {
  final String codigoAlumno;
  final String nombreCompleto;
  final bool ubicacionCompartida;
<<<<<<< HEAD
=======
  final String carrera;
>>>>>>> main

  Estudiante({
    required super.idUsuario,
    required super.email,
    required super.passwordHash,
    required super.fechaCreacion,
    required super.estado,
    required this.codigoAlumno,
    required this.nombreCompleto,
    required this.ubicacionCompartida,
<<<<<<< HEAD
=======
    required this.carrera,
>>>>>>> main
  });

  void verMapa(Ubicacion ubicacionActual) {
    // Mock implementation - no real functionality
  }

  List<dynamic> filtrarEspacios(Map<String, dynamic> filtros) {
    // Mock implementation - returns empty list
    return [];
  }

  void calificarEspacio(String espacioId, int puntuacion) {
    // Mock implementation - no real functionality
  }

  void reportarEstado(String espacioId, String estado) {
    // Mock implementation - no real functionality
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      'codigoAlumno': codigoAlumno,
      'nombreCompleto': nombreCompleto,
      'ubicacionCompartida': ubicacionCompartida,
<<<<<<< HEAD
=======
      'carrera': carrera,
>>>>>>> main
    });
    return json;
  }

  factory Estudiante.fromJson(Map<String, dynamic> json) {
    return Estudiante(
      idUsuario: json['idUsuario'],
      email: json['email'],
      passwordHash: json['passwordHash'],
      fechaCreacion: DateTime.parse(json['fechaCreacion']),
      estado: EstadoUsuario.values.firstWhere(
        (e) => e.name == json['estado'],
        orElse: () => EstadoUsuario.activo,
      ),
      codigoAlumno: json['codigoAlumno'],
      nombreCompleto: json['nombreCompleto'],
      ubicacionCompartida: json['ubicacionCompartida'],
<<<<<<< HEAD
=======
      carrera: json['carrera'] ?? 'No especificada',
>>>>>>> main
    );
  }
}
