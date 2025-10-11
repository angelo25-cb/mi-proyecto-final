enum EstadoCalificacion { pendiente, aprobada, rechazada }

class Calificacion {
  final String idCalificacion;
  final int puntuacion;
  final String comentario;
  final DateTime fecha;
  final EstadoCalificacion estado;

  Calificacion({
    required this.idCalificacion,
    required this.puntuacion,
    required this.comentario,
    required this.fecha,
    required this.estado,
  });

  void editar(Map<String, dynamic> nuevosDatos) {
    // Mock implementation - no real functionality
  }

  void eliminar() {
    // Mock implementation - no real functionality
  }

  Map<String, dynamic> toJson() {
    return {
      'idCalificacion': idCalificacion,
      'puntuacion': puntuacion,
      'comentario': comentario,
      'fecha': fecha.toIso8601String(),
      'estado': estado.name,
    };
  }

  factory Calificacion.fromJson(Map<String, dynamic> json) {
    return Calificacion(
      idCalificacion: json['idCalificacion'],
      puntuacion: json['puntuacion'],
      comentario: json['comentario'],
      fecha: DateTime.parse(json['fecha']),
      estado: EstadoCalificacion.values.firstWhere(
        (e) => e.name == json['estado'],
        orElse: () => EstadoCalificacion.pendiente,
      ),
    );
  }
}
