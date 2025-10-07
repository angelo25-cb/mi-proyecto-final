
enum EstadoUsuario { activo, inactivo, suspendido }

class Usuario {
  final String idUsuario;
  final String email;
  final String passwordHash;
  final DateTime fechaCreacion;
  final EstadoUsuario estado;

  Usuario({
    required this.idUsuario,
    required this.email,
    required this.passwordHash,
    required this.fechaCreacion,
    required this.estado,
  });

  bool iniciarSesion(String email, String password) {
    return this.email == email && passwordHash == password.hashCode.toString();
  }

  void crearCuenta(Map<String, dynamic> datos) {
    // Mock implementation - no real functionality
  }

  void editarPerfil(Map<String, dynamic> datos) {
    // Mock implementation - no real functionality
  }

  Map<String, dynamic> toJson() {
    return {
      'idUsuario': idUsuario,
      'email': email,
      'passwordHash': passwordHash,
      'fechaCreacion': fechaCreacion.toIso8601String(),
      'estado': estado.name,
    };
  }

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
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
