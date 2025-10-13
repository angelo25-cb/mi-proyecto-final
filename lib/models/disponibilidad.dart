class Disponibilidad {
  final String idEspacio;
  String estado; // "disponible" o "ocupado"

  Disponibilidad({
    required this.idEspacio,
    required this.estado,
  });

  Map<String, dynamic> toJson() => {
        'idEspacio': idEspacio,
        'estado': estado,
      };

  factory Disponibilidad.fromJson(Map<String, dynamic> json) {
    return Disponibilidad(
      idEspacio: json['idEspacio'],
      estado: json['estado'],
    );
  }
}
