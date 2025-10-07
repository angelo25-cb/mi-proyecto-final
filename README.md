# Smart Break - Frontend Flutter

Una aplicación móvil que permite a estudiantes universitarios encontrar espacios tranquilos para estudiar o descansar dentro del campus.

## Características

- **Pantalla de bienvenida/login**: Interfaz simple de inicio de sesión (no funcional, solo UI)
- **Mapa interactivo**: Mapa del campus con marcadores de espacios tranquilos usando Google Maps
- **Lista filtrable**: Vista de lista de espacios con filtros por tipo y nivel de ocupación
- **Detalle de espacios**: Información completa de cada espacio con sistema de calificaciones
- **Navegación fluida**: Transiciones suaves entre pantallas
- **Diseño responsivo**: Optimizado para dispositivos móviles

## Arquitectura

El proyecto sigue el patrón **DAO (Data Access Object)** según el diagrama de clases proporcionado:

- **Models**: Entidades del dominio (Usuario, Estudiante, AdministradorSistema, Espacio, Ubicacion, etc.)
- **DAO**: Interfaces y implementaciones mock para acceso a datos
- **Screens**: Pantallas principales de la aplicación
- **Widgets**: Componentes reutilizables

## Tecnologías Utilizadas

- **Flutter**: Framework de desarrollo móvil
- **Google Maps Flutter**: Integración de mapas
- **Provider**: Gestión de estado
- **Flutter Rating Bar**: Componente de calificaciones

## Instalación y Ejecución

### Prerrequisitos

- Flutter SDK (versión 3.9.2 o superior)
- Android Studio / VS Code con extensiones de Flutter
- Dispositivo Android o emulador

### Pasos para ejecutar

1. **Clonar el repositorio**
   ```bash
   git clone <repository-url>
   cd smart_break
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Ejecutar la aplicación**
   ```bash
   flutter run
   ```

### Configuración de Google Maps

El proyecto incluye una API key de Google Maps configurada para desarrollo. Para producción, deberás:

1. Obtener tu propia API key de Google Maps
2. Reemplazar la key en `android/app/src/main/AndroidManifest.xml`
3. Configurar las restricciones de la API key según sea necesario

## Estructura del Proyecto

```
lib/
├── dao/                    # Patrón DAO
│   ├── dao_factory.dart
│   ├── espacio_dao.dart
│   ├── usuario_dao.dart
│   ├── calificacion_dao.dart
│   ├── reporte_ocupacion_dao.dart
│   └── mock_*.dart         # Implementaciones mock
├── models/                 # Modelos de datos
│   ├── usuario.dart
│   ├── estudiante.dart
│   ├── administrador_sistema.dart
│   ├── espacio.dart
│   ├── ubicacion.dart
│   ├── caracteristica_espacio.dart
│   ├── calificacion.dart
│   └── reporte_ocupacion.dart
├── screens/               # Pantallas de la aplicación
│   ├── welcome_screen.dart
│   ├── mapa_screen.dart
│   ├── lista_espacios_screen.dart
│   └── detalle_espacio_screen.dart
└── main.dart              # Punto de entrada
```

## Datos Mock

La aplicación incluye datos simulados para:

- **5 espacios diferentes**: Biblioteca Central, Cafetería Estudiantil, Jardín Botánico, Sala de Estudio 24/7, Patio de Comidas
- **Ubicaciones reales**: Coordenadas del campus universitario en Bogotá, Colombia
- **Características**: WiFi, silencio, comida, naturaleza, horarios, etc.
- **Calificaciones**: Sistema de puntuación de 1 a 5 estrellas con comentarios
- **Usuarios**: Estudiante y Administrador de sistema

## Funcionalidades Implementadas

### Pantalla de Bienvenida
- Formulario de login con validación
- Diseño moderno con gradiente
- Botón de acceso demo

### Mapa Interactivo
- Mapa real del campus con Google Maps
- Marcadores coloridos según nivel de ocupación
- Leyenda de colores
- Navegación a detalles del espacio

### Lista de Espacios
- Vista de lista con información resumida
- Filtros por tipo y ocupación
- Búsqueda por texto
- Navegación a detalles

### Detalle de Espacio
- Información completa del espacio
- Sistema de calificaciones
- Características y ubicación
- Historial de calificaciones

## Notas Importantes

- **No hay backend real**: Todos los datos son simulados usando el patrón DAO mock
- **No hay autenticación real**: El login es solo visual
- **Optimizado para móviles**: Diseño responsivo para pantallas pequeñas
- **Código limpio**: Estructura organizada siguiendo buenas prácticas

## Próximos Pasos

Para convertir esto en una aplicación completa, se necesitaría:

1. Implementar backend real con base de datos
2. Sistema de autenticación real
3. Integración con APIs de mapas reales
4. Sistema de notificaciones push
5. Funcionalidades offline
6. Tests unitarios y de integración

## Contribución

Este es un proyecto de demostración del frontend. Para contribuir:

1. Fork el repositorio
2. Crea una rama para tu feature
3. Realiza los cambios
4. Envía un pull request

## Licencia

Este proyecto es para fines educativos y de demostración.