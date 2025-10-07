import 'package:smart_break/models/espacio.dart';
import 'package:smart_break/models/ubicacion.dart';

import 'usuario.dart';

class AdministradorSistema extends Usuario {
  final String rol = "Admin";

  AdministradorSistema({
    required super.idUsuario,
    required super.email,
    required super.passwordHash,
    required super.fechaCreacion,
    required super.estado,
  });

  void crearEspacio(Map<String, dynamic> datosEspacio) {
    try {
      // 1️⃣ Crear el objeto Espacio a partir del mapa recibido
      final nuevoEspacio = Espacio(
        idEspacio: datosEspacio['idEspacio'],
        nombre: datosEspacio['nombre'],
        tipo: datosEspacio['tipo'],
        nivelOcupacion: datosEspacio['nivelOcupacion'],
        promedioCalificacion: (datosEspacio['promedioCalificacion'] ?? 0)
            .toDouble(),
        ubicacion: datosEspacio['ubicacion'] as Ubicacion,
        caracteristicas: [],
      );

      // 2️⃣ Simular persistencia (puedes reemplazarlo por DAO real más adelante)
      print('✅ Espacio creado correctamente: ${nuevoEspacio.toJson()}');

      // Si tuvieras un DAO real sería algo así:
      // final dao = PostgresDAOFactory().createEspacioDAO();
      // dao.insertar(nuevoEspacio);
    } catch (e) {
      print('❌ Error al crear el espacio: $e');
    }
  }

  void categorizarEspacio(String espacioId, List<String> caracteristicas) {
    // Mock implementation - no real functionality
  }

  void reiniciarEstadoEspacios() {
    // Mock implementation - no real functionality
  }

  void moderarCalificacion(String califId, String estado) {
    // Mock implementation - no real functionality
  }

  void aplicarControlAbuso(String usuarioId) {
    // Mock implementation - no real functionality
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({'rol': rol});
    return json;
  }

  factory AdministradorSistema.fromJson(Map<String, dynamic> json) {
    return AdministradorSistema(
      idUsuario: json['idUsuario'],
      email: json['email'],
      passwordHash: json['passwordHash'],
      fechaCreacion: DateTime.parse(json['fechaCreacion']),
      estado: EstadoUsuario.values.firstWhere(
        (e) => e.name == json['estado'],
        orElse: () => EstadoUsuario.activo,
      ),
    );
  }
}
