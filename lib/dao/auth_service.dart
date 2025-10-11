import 'package:flutter/foundation.dart';
import '../models/usuario.dart';

/// Servicio singleton para manejar la sesión del usuario actual
/// Sigue el principio de responsabilidad única (SRP)
class AuthService extends ChangeNotifier {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  Usuario? _usuarioActual;

  /// Obtiene el usuario actualmente autenticado
  Usuario? get usuarioActual => _usuarioActual;

  /// Verifica si hay un usuario autenticado
  bool get isAuthenticated => _usuarioActual != null;

  /// Verifica si el usuario actual es un administrador
  bool get isAdmin => _usuarioActual != null && 
      _usuarioActual!.runtimeType.toString() == 'AdministradorSistema';

  /// Establece el usuario actual después del login
  void setUsuario(Usuario usuario) {
    _usuarioActual = usuario;
    notifyListeners();
  }

  /// Cierra la sesión del usuario actual
  void logout() {
    _usuarioActual = null;
    notifyListeners();
  }

  /// Actualiza los datos del usuario actual
  void actualizarUsuario(Usuario usuario) {
    if (_usuarioActual?.idUsuario == usuario.idUsuario) {
      _usuarioActual = usuario;
      notifyListeners();
    }
  }
}
