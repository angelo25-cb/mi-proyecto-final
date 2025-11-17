/// Modelo que representa una categoría de espacio
/// Puede ser Tipo de Espacio o Nivel de Ruido
class CategoriaEspacio {
  final String idCategoria;
  final String nombre;
  final TipoCategoria tipo;
  final DateTime fechaCreacion;

  CategoriaEspacio({
    required this.idCategoria,
    required this.nombre,
    required this.tipo,
    required this.fechaCreacion,
  });

  Map<String, dynamic> toJson() {
    return {
      'idCategoria': idCategoria,
      'nombre': nombre,
      'tipo': tipo.name,
      'fechaCreacion': fechaCreacion.toIso8601String(),
    };
  }

  factory CategoriaEspacio.fromJson(Map<String, dynamic> json) {
    return CategoriaEspacio(
      idCategoria: json['idCategoria'],
      nombre: json['nombre'],
      tipo: TipoCategoria.values.firstWhere(
        (e) => e.name == json['tipo'],
        orElse: () => TipoCategoria.tipoEspacio,
      ),
      fechaCreacion: DateTime.parse(json['fechaCreacion']),
    );
  }

  CategoriaEspacio copyWith({
    String? idCategoria,
    String? nombre,
    TipoCategoria? tipo,
    DateTime? fechaCreacion,
  }) {
    return CategoriaEspacio(
      idCategoria: idCategoria ?? this.idCategoria,
      nombre: nombre ?? this.nombre,
      tipo: tipo ?? this.tipo,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
    );
  }
}

/// Enum que define los tipos de categorías
enum TipoCategoria {
  tipoEspacio,  // Ej: Estudio, Descanso, Cafetería
  nivelRuido,   // Ej: Silencioso, Moderado, Ruidoso
  comodidad,    // Ej: WiFi, Aire Acondicionado, Enchufes
  capacidad,    // Ej: Individual, Pequeño Grupo, Grupo Grande
  bloqueHorario, // Ej: Mañana (08:00 - 12:00), Tarde (12:00 - 18:00)
}

/// Extension para obtener nombres legibles de las categorías
extension TipoCategoriaExtension on TipoCategoria {
  String get displayName {
    switch (this) {
      case TipoCategoria.tipoEspacio:
        return 'Tipos de Espacio';
      case TipoCategoria.nivelRuido:
        return 'Niveles de Ruido';
      case TipoCategoria.comodidad:
        return 'Comodidades';
      case TipoCategoria.capacidad:
        return 'Capacidades';
      case TipoCategoria.bloqueHorario:
        return 'Bloques Horarios Disponibles';
    }
  }

  String get singularName {
    switch (this) {
      case TipoCategoria.tipoEspacio:
        return 'tipo';
      case TipoCategoria.nivelRuido:
        return 'nivel';
      case TipoCategoria.comodidad:
        return 'comodidad';
      case TipoCategoria.capacidad:
        return 'capacidad';
      case TipoCategoria.bloqueHorario:
        return 'bloque horario';
    }
  }

  String get buttonText {
    switch (this) {
      case TipoCategoria.tipoEspacio:
        return 'Añadir Tipo';
      case TipoCategoria.nivelRuido:
        return 'Añadir Nivel';
      case TipoCategoria.comodidad:
        return 'Añadir Comodidad';
      case TipoCategoria.capacidad:
        return 'Añadir Capacidad';
      case TipoCategoria.bloqueHorario:
        return 'Añadir Bloque Horario';
    }
  }
}
