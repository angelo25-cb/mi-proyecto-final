import 'espacio.dart';

class CaracteristicaEspacio {
  final String idCaracteristica;
  final String nombre;
  final String valor;
  final String tipoFiltro;

  CaracteristicaEspacio({
    required this.idCaracteristica,
    required this.nombre,
    required this.valor,
    required this.tipoFiltro,
  });

  List<Espacio> obtenerEspaciosPorFiltro(String tipo, String valor) {
    // Mock implementation - returns empty list
    return [];
  }

  Map<String, dynamic> toJson() {
    return {
      'idCaracteristica': idCaracteristica,
      'nombre': nombre,
      'valor': valor,
      'tipoFiltro': tipoFiltro,
    };
  }

  factory CaracteristicaEspacio.fromJson(Map<String, dynamic> json) {
    return CaracteristicaEspacio(
      idCaracteristica: json['idCaracteristica'],
      nombre: json['nombre'],
      valor: json['valor'],
      tipoFiltro: json['tipoFiltro'],
    );
  }
}
