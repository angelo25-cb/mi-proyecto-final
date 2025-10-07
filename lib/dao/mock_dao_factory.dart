import 'dao_factory.dart';
import 'usuario_dao.dart';
import 'espacio_dao.dart';
import 'calificacion_dao.dart';
import 'reporte_ocupacion_dao.dart';
import 'mock_usuario_dao.dart';
import 'mock_espacio_dao.dart';
import 'mock_calificacion_dao.dart';
import 'mock_reporte_ocupacion_dao.dart';

class MockDAOFactory implements DAOFactory {
  static final MockDAOFactory _instance = MockDAOFactory._internal();
  
  factory MockDAOFactory() {
    return _instance;
  }
  
  MockDAOFactory._internal();

  @override
  UsuarioDAO createUsuarioDAO() {
    return MockUsuarioDAO();
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
}
