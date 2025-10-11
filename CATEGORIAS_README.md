# Sistema de Gestión de Categorías - Smart Break

## 📋 Descripción
Sistema completo para la gestión de categorías de espacios (Tipos de Espacio y Niveles de Ruido) en la aplicación Smart Break, implementado siguiendo los principios SOLID y la arquitectura existente del proyecto.

## 🏗️ Arquitectura Implementada

### Principios SOLID Aplicados

#### 1. **Single Responsibility Principle (SRP)**
- Cada clase tiene una única responsabilidad bien definida:
  - `CategoriaEspacio`: Modelo de datos de categoría
  - `CategoriaDAO`: Interfaz para operaciones de datos
  - `MockCategoriaDAO`: Implementación en memoria
  - `SqliteCategoriaDAO`: Implementación con base de datos
  - `GestionarCategoriasScreen`: Interfaz de usuario
  - `AuthService`: Manejo de sesión de usuario

#### 2. **Open/Closed Principle (OCP)**
- Las clases están abiertas para extensión pero cerradas para modificación:
  - Se pueden agregar nuevas implementaciones de `CategoriaDAO` sin modificar el código existente
  - El patrón Factory permite cambiar entre implementaciones fácilmente

#### 3. **Liskov Substitution Principle (LSP)**
- Las implementaciones `MockCategoriaDAO` y `SqliteCategoriaDAO` son intercambiables
- Se pueden usar indistintamente sin afectar la funcionalidad

#### 4. **Interface Segregation Principle (ISP)**
- `CategoriaDAO` define una interfaz específica solo con los métodos necesarios
- No se fuerza a implementar métodos innecesarios

#### 5. **Dependency Inversion Principle (DIP)**
- Las clases de alto nivel dependen de abstracciones (interfaces), no de implementaciones concretas
- Se usa `DAOFactory` para crear instancias, desacoplando la creación de objetos

## 📁 Estructura de Archivos Creados/Modificados

### Nuevos Archivos

```
lib/
├── models/
│   └── categoria_espacio.dart          # Modelo de categoría con enum TipoCategoria
├── dao/
│   ├── categoria_dao.dart              # Interfaz abstracta del DAO
│   ├── mock_categoria_dao.dart         # Implementación Mock (datos en memoria)
│   ├── sqlite_categoria_dao.dart       # Implementación SQLite (base de datos)
│   └── auth_service.dart               # Servicio singleton para gestión de sesión
└── screens/
    ├── gestionar_categorias_screen.dart # Pantalla de gestión de categorías
    └── admin_profile_screen.dart       # Pantalla de perfil de administrador
```

### Archivos Modificados

```
lib/
├── dao/
│   ├── dao_factory.dart                # Agregado createCategoriaDAO()
│   ├── mock_dao_factory.dart           # Implementación del factory Mock
│   └── sqlite_dao_factory.dart         # Implementación del factory SQLite
└── screens/
    ├── login_screen.dart               # Guarda usuario en AuthService al login
    ├── profile_screen.dart             # Añadida sección de administración
    └── mapa_screen.dart                # Añadido botón de navegación a perfil
```

## 🎯 Funcionalidades Implementadas

### Modelo de Categorías
- **Enum TipoCategoria**: Define cinco tipos de categorías
  - `tipoEspacio`: Para clasificar espacios (Estudio, Descanso, Biblioteca, etc.)
  - `nivelRuido`: Para niveles de ruido (Silencioso, Moderado, Ruidoso, etc.)
  - `comodidad`: Para comodidades disponibles (WiFi, Aire Acondicionado, Enchufes, etc.)
  - `capacidad`: Para capacidad de personas (Individual, Pequeño Grupo, Grupo Grande)
  - `bloqueHorario`: Para bloques de horarios disponibles (Mañana 08:00-12:00, Tarde 12:00-18:00, etc.)
- **Extension TipoCategoriaExtension**: Nombres legibles, en singular y textos de botones para la UI

### 2. Operaciones CRUD Completas
- ✅ **Crear**: Añadir nuevas categorías
- ✅ **Leer**: Obtener todas las categorías o filtradas por tipo
- ✅ **Actualizar**: Editar categorías existentes
- ✅ **Eliminar**: Borrar categorías

### 3. Validaciones
- Nombres únicos por tipo de categoría
- No permite categorías vacías
- Validación al editar para evitar duplicados

### 4. Interfaz de Usuario
- Secciones dinámicas para cada tipo de categoría (5 secciones)
- Lista separada para cada tipo: Tipos de Espacio, Niveles de Ruido, Comodidades, Capacidades, Horarios
- Campo de texto para añadir nuevas categorías en cada sección
- Botones de Editar y Eliminar para cada categoría
- Diálogos de confirmación para operaciones críticas
- Indicadores de carga y mensajes de error/éxito
- Scroll infinito con RefreshIndicator

### 5. Control de Acceso
- Solo administradores pueden acceder a la gestión de categorías
- Sistema de autenticación con `AuthService`
- Perfiles diferenciados para estudiantes y administradores

## 🔐 Sistema de Autenticación

### AuthService (Singleton)
```dart
// Obtener instancia
AuthService authService = AuthService();

// Verificar si es administrador
bool esAdmin = authService.isAdmin;

// Obtener usuario actual
Usuario? usuario = authService.usuarioActual;
```

### Credenciales de Prueba

**Estudiante:**
- Email: `20251234@aloe.ulima.edu.pe`
- Password: `123456`

**Administrador:**
- Email: `admin@aloe.ulima.edu.pe`
- Password: `admin123`

## 🚀 Cómo Usar

### Para Administradores

1. **Iniciar Sesión como Administrador**
   - Usar credenciales: `admin@aloe.ulima.edu.pe` / `admin123`

2. **Acceder a Gestión de Categorías**
   - Desde el mapa principal, hacer clic en el ícono de perfil (persona)
   - En el perfil de administrador, seleccionar "Gestionar Categorías"

3. **Gestionar Tipos de Espacio**
   - Ver tipos existentes: Estudio, Descanso, Biblioteca, Cafetería
   - Añadir nuevo tipo: Escribir nombre y hacer clic en "Añadir"
   - Editar: Hacer clic en el ícono de lápiz (naranja)
   - Eliminar: Hacer clic en el ícono de papelera (rojo) y confirmar

4. **Gestionar Niveles de Ruido**
   - Ver niveles existentes: Silencioso, Moderado, Ruidoso
   - Gestionar de la misma forma que los tipos de espacio

5. **Gestionar Comodidades**
   - Ver comodidades: WiFi, Aire Acondicionado, Enchufes, Computadoras
   - Añadir nuevas comodidades: Proyector, Pizarra, Impresora, etc.
   - Botón: "Añadir Comodidad"
   
6. **Gestionar Capacidades**
   - Ver capacidades: Individual (1 persona), Pequeño Grupo (2-4), Grupo Grande (6+)
   - Añadir nuevas capacidades según necesidad
   - Botón: "Añadir Capacidad"

7. **Gestionar Bloques Horarios**
   - Ver bloques: Mañana (08:00 - 12:00), Tarde (12:00 - 18:00), Noche (18:00 - 22:00)
   - Añadir bloques personalizados: Madrugada, Mediodía, etc.
   - Formato sugerido: "Nombre (HH:MM - HH:MM)"
   - Botón: "Añadir Bloque Horario"

### Para Desarrolladores

#### Usar el DAO en tu código

```dart
// Obtener instancia del DAO
final daoFactory = MockDAOFactory(); // o SqliteDAOFactory()
final categoriaDAO = daoFactory.createCategoriaDAO();

// Crear categoría
final nuevaCategoria = CategoriaEspacio(
  idCategoria: DateTime.now().millisecondsSinceEpoch.toString(),
  nombre: 'Nuevo Tipo',
  tipo: TipoCategoria.tipoEspacio,
  fechaCreacion: DateTime.now(),
);
await categoriaDAO.crear(nuevaCategoria);

// Obtener todas las categorías
List<CategoriaEspacio> todasCategorias = await categoriaDAO.obtenerTodas();

// Obtener por tipo
List<CategoriaEspacio> tiposEspacio = 
    await categoriaDAO.obtenerPorTipo(TipoCategoria.tipoEspacio);

// Actualizar
await categoriaDAO.actualizar(categoriaEditada);

// Eliminar
await categoriaDAO.eliminar(idCategoria);
```

#### Cambiar entre Mock y SQLite

En `main.dart` o donde se inicialice el `DAOFactory`:

```dart
// Para desarrollo/testing
final daoFactory = MockDAOFactory();

// Para producción
final daoFactory = SqliteDAOFactory();
```

## 📊 Datos Predeterminados

### Tipos de Espacio
1. Estudio
2. Descanso
3. Biblioteca
4. Cafetería

### Niveles de Ruido
1. Silencioso
2. Moderado
3. Ruidoso

### Comodidades
1. WiFi
2. Aire Acondicionado
3. Enchufes
4. Computadoras

### Capacidades
1. Individual (1 persona)
2. Pequeño Grupo (2-4)
3. Grupo Grande (6+)

### Bloques Horarios Disponibles
1. Mañana (08:00 - 12:00)
2. Tarde (12:00 - 18:00)
3. Noche (18:00 - 22:00)

## 🎨 Diseño de UI

La interfaz sigue el diseño proporcionado con:
- Colores corporativos (naranja `#F97316` para botones y acciones)
- Cards con elevación y bordes redondeados
- Botones de acción con iconos intuitivos
- Feedback visual con SnackBars
- Confirmaciones para operaciones destructivas

## 🔄 Refresh y Actualización

La pantalla se actualiza automáticamente después de cada operación:
- Al añadir una categoría
- Al editar una categoría
- Al eliminar una categoría
- Se puede hacer pull-to-refresh deslizando hacia abajo

## ⚠️ Manejo de Errores

- Validación de entrada antes de crear/editar
- Mensajes de error descriptivos
- Try-catch en todas las operaciones asíncronas
- Indicadores de carga durante operaciones

## 🧪 Testing

### Mock Implementation
La implementación `MockCategoriaDAO` permite:
- Testing sin base de datos
- Desarrollo rápido
- Datos de prueba predefinidos
- Simulación de latencia de red (100ms)

### SQLite Implementation
La implementación `SqliteCategoriaDAO`:
- Persistencia real de datos
- Queries SQL optimizadas
- Transacciones para integridad de datos
- Preparada para producción

## 📝 Notas Importantes

1. **Persistencia**: En la versión Mock, los datos se pierden al reiniciar la app. Usa SqliteDAOFactory para persistencia real.

2. **Restricciones**: No se pueden crear dos categorías con el mismo nombre dentro del mismo tipo.

3. **Navegación**: El botón de perfil en el mapa detecta automáticamente el tipo de usuario y muestra el perfil correspondiente.

4. **Extensibilidad**: Para añadir más funciones de administración, solo se necesita:
   - Crear el DAO correspondiente
   - Añadir la pantalla de gestión
   - Agregar la opción en `AdminProfileScreen`

## 🔮 Futuras Mejoras

- [ ] Búsqueda y filtrado de categorías
- [ ] Ordenamiento personalizado
- [ ] Iconos personalizados por categoría
- [ ] Categorías con subcategorías
- [ ] Auditoría de cambios (quién y cuándo modificó)
- [ ] Importar/Exportar categorías
- [ ] Validación de categorías en uso antes de eliminar

## 👥 Roles y Permisos

| Función | Estudiante | Administrador |
|---------|-----------|---------------|
| Ver espacios | ✅ | ✅ |
| Gestionar categorías | ❌ | ✅ |
| Crear espacios | ❌ | ✅ |
| Ver perfil | ✅ | ✅ |
| Gestionar usuarios | ❌ | ✅ (futuro) |

---

**Desarrollado con ❤️ siguiendo principios SOLID y las mejores prácticas de Flutter**
