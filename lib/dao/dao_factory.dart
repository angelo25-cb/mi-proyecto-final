import 'usuario_dao.dart';
import 'espacio_dao.dart';
import 'calificacion_dao.dart';
import 'reporte_ocupacion_dao.dart';
<<<<<<< HEAD
=======
import 'auth_dao.dart';
import 'categoria_dao.dart';
>>>>>>> main

/// Fábrica abstracta para crear los DAOs
abstract class DAOFactory {
  UsuarioDAO createUsuarioDAO();
<<<<<<< HEAD
  EspacioDAO createEspacioDAO();
  CalificacionDAO createCalificacionDAO();
  ReporteOcupacionDAO createReporteOcupacionDAO();
=======
  AuthDAO createAuthDAO();
  EspacioDAO createEspacioDAO();
  CalificacionDAO createCalificacionDAO();
  ReporteOcupacionDAO createReporteOcupacionDAO();
  CategoriaDAO createCategoriaDAO();
>>>>>>> main
}
