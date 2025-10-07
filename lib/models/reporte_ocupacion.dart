class ReporteOcupacion {
  final String idReporte;
  final String estadoReportado;
  final DateTime fecha;

  ReporteOcupacion({
    required this.idReporte,
    required this.estadoReportado,
    required this.fecha,
  });

  Map<String, dynamic> toJson() {
    return {
      'idReporte': idReporte,
      'estadoReportado': estadoReportado,
      'fecha': fecha.toIso8601String(),
    };
  }

  factory ReporteOcupacion.fromJson(Map<String, dynamic> json) {
    return ReporteOcupacion(
      idReporte: json['idReporte'],
      estadoReportado: json['estadoReportado'],
      fecha: DateTime.parse(json['fecha']),
    );
  }
}
