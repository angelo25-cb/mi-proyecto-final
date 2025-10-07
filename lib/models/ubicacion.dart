import 'espacio.dart';

class Ubicacion {
  final String idUbicacion;
  final double latitud;
  final double longitud;
  final int piso;

  Ubicacion({
    required this.idUbicacion,
    required this.latitud,
    required this.longitud,
    required this.piso,
  });

  List<Espacio> obtenerCercanos(double radioKm) {
    // Mock implementation - returns empty list
    return [];
  }

  Map<String, dynamic> toJson() {
    return {
      'idUbicacion': idUbicacion,
      'latitud': latitud,
      'longitud': longitud,
      'piso': piso,
    };
  }

  factory Ubicacion.fromJson(Map<String, dynamic> json) {
    return Ubicacion(
      idUbicacion: json['idUbicacion'],
      latitud: json['latitud'].toDouble(),
      longitud: json['longitud'].toDouble(),
      piso: json['piso'],
    );
  }
}
