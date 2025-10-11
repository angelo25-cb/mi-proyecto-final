import 'dao_factory.dart';
import 'usuario_dao.dart';
import 'espacio_dao.dart';
import 'calificacion_dao.dart';
import 'reporte_ocupacion_dao.dart';
import 'auth_dao.dart';
import 'categoria_dao.dart';
import 'mock_usuario_dao.dart';
import 'mock_espacio_dao.dart';
import 'mock_calificacion_dao.dart';
import 'mock_reporte_ocupacion_dao.dart';
import 'mock_auth_dao.dart';
import 'mock_categoria_dao.dart';

class MockDAOFactory implements DAOFactory {
  static final MockDAOFactory _instance = MockDAOFactory._internal();
  final MockUsuarioDAO _usuarioDAO = MockUsuarioDAO();
  
  factory MockDAOFactory() {
    return _instance;
  }
  
  MockDAOFactory._internal();

  @override
  UsuarioDAO createUsuarioDAO() {
    return _usuarioDAO;
  }

  AuthDAO createAuthDAO() {
    return MockAuthDAO(_usuarioDAO);
  }

  @override
  EspacioDAO createEspacioDAO() {
    return MockEspacioDAO();
  }

  @override
  CalificacionDAO createCalificacionDAO() {
    return MockCalificacionDAO();
  }

  @override
  ReporteOcupacionDAO createReporteOcupacionDAO() {
    return MockReporteOcupacionDAO();
  }

  @override
  CategoriaDAO createCategoriaDAO() {
    return MockCategoriaDAO();
  }
}
