import 'dao_factory.dart';
import 'espacio_dao.dart';
import 'sqlite_espacio_dao.dart';
import 'usuario_dao.dart';
import 'calificacion_dao.dart';
import 'reporte_ocupacion_dao.dart';
<<<<<<< HEAD
=======
import 'categoria_dao.dart';
import 'sqlite_categoria_dao.dart';
import 'auth_dao.dart';
>>>>>>> main

class SqliteDAOFactory implements DAOFactory {
  static final SqliteDAOFactory _instance = SqliteDAOFactory._internal();
  factory SqliteDAOFactory() => _instance;
  SqliteDAOFactory._internal();

  @override
  UsuarioDAO createUsuarioDAO() {
    throw UnimplementedError('UsuarioDAO sqlite not implemented yet');
  }

  @override
<<<<<<< HEAD
=======
  AuthDAO createAuthDAO() {
    throw UnimplementedError('AuthDAO sqlite not implemented yet');
  }

  @override
>>>>>>> main
  EspacioDAO createEspacioDAO() => SqliteEspacioDAO();

  @override
  CalificacionDAO createCalificacionDAO() {
    throw UnimplementedError('CalificacionDAO sqlite not implemented yet');
  }

  @override
  ReporteOcupacionDAO createReporteOcupacionDAO() {
    throw UnimplementedError('ReporteOcupacionDAO sqlite not implemented yet');
  }
<<<<<<< HEAD
=======

  @override
  CategoriaDAO createCategoriaDAO() => SqliteCategoriaDAO();
>>>>>>> main
}
