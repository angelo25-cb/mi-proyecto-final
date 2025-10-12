import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dao/mock_dao_factory.dart';
import '../models/espacio.dart';
import 'detalle_espacio_screen.dart';
import 'filtered_spaces_screen.dart';

class ListaEspaciosScreen extends StatefulWidget {
  const ListaEspaciosScreen({super.key});

  @override
  State<ListaEspaciosScreen> createState() => _ListaEspaciosScreenState();
}

class _ListaEspaciosScreenState extends State<ListaEspaciosScreen> {
  List<Espacio> _espacios = [];
  List<Espacio> _espaciosFiltrados = [];
  bool _isLoading = true;
  String _filtroTipo = 'Todos';
  String _filtroOcupacion = 'Todos';
  String _busqueda = '';

  final List<String> _tipos = ['Todos', 'Biblioteca', 'Cafetería', 'Exterior', 'Sala de Estudio', 'Comedor', 'Laboratorio', 'Auditorio'];
  final List<String> _ocupaciones = ['Todos', 'Vacío', 'Bajo', 'Medio', 'Alto', 'Lleno'];

  @override
  void initState() {
    super.initState();
    _loadEspacios();
  }

  Future<void> _loadEspacios() async {
    final daoFactory = Provider.of<MockDAOFactory>(context, listen: false);
    final espacioDAO = daoFactory.createEspacioDAO();
    
    try {
      final espacios = await espacioDAO.obtenerTodos();
      setState(() {
        _espacios = espacios;
        _espaciosFiltrados = espacios;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _aplicarFiltros() {
    setState(() {
      _espaciosFiltrados = _espacios.where((espacio) {
        // Filtro por tipo
        bool cumpleTipo = _filtroTipo == 'Todos' || espacio.tipo == _filtroTipo;
        
        // Filtro por ocupación
        bool cumpleOcupacion = _filtroOcupacion == 'Todos' || 
            espacio.nivelOcupacion.name.toLowerCase() == _filtroOcupacion.toLowerCase();
        
        // Filtro por búsqueda
        bool cumpleBusqueda = _busqueda.isEmpty ||
            espacio.nombre.toLowerCase().contains(_busqueda.toLowerCase()) ||
            espacio.tipo.toLowerCase().contains(_busqueda.toLowerCase());
        
        return cumpleTipo && cumpleOcupacion && cumpleBusqueda;
      }).toList();
    });
  }

  Color _getOcupacionColor(NivelOcupacion nivel) {
    switch (nivel) {
      case NivelOcupacion.vacio:
        return Colors.green;
      case NivelOcupacion.bajo:
        return Colors.yellow[700]!;
      case NivelOcupacion.medio:
        return Colors.orange;
      case NivelOcupacion.alto:
        return Colors.red;
      case NivelOcupacion.lleno:
        return Colors.purple;
    }
  }

  String _getOcupacionText(NivelOcupacion nivel) {
    switch (nivel) {
      case NivelOcupacion.vacio:
        return 'Vacío';
      case NivelOcupacion.bajo:
        return 'Baja ocupación';
      case NivelOcupacion.medio:
        return 'Ocupación media';
      case NivelOcupacion.alto:
        return 'Alta ocupación';
      case NivelOcupacion.lleno:
        return 'Lleno';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Espacios Disponibles'),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
        actions: [
          // Botón para filtrar por categorías
          IconButton(
            icon: const Icon(Icons.filter_list),
            tooltip: 'Filtrar por categorías',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FilteredSpacesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Barra de búsqueda
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar espacios...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    onChanged: (value) {
                      setState(() {
                        _busqueda = value;
                      });
                      _aplicarFiltros();
                    },
                  ),
                ),
                
                // Filtros
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: _filtroTipo,
                          decoration: InputDecoration(
                            labelText: 'Tipo',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          ),
                          items: _tipos.map((String tipo) {
                            return DropdownMenuItem<String>(
                              value: tipo,
                              child: Text(tipo),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _filtroTipo = newValue!;
                            });
                            _aplicarFiltros();
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: _filtroOcupacion,
                          decoration: InputDecoration(
                            labelText: 'Ocupación',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          ),
                          items: _ocupaciones.map((String ocupacion) {
                            return DropdownMenuItem<String>(
                              value: ocupacion,
                              child: Text(ocupacion),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _filtroOcupacion = newValue!;
                            });
                            _aplicarFiltros();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Lista de espacios
                Expanded(
                  child: _espaciosFiltrados.isEmpty
                      ? const Center(
                          child: Text(
                            'No se encontraron espacios',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: _espaciosFiltrados.length,
                          itemBuilder: (context, index) {
                            final espacio = _espaciosFiltrados[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(16),
                                leading: CircleAvatar(
                                  backgroundColor: _getOcupacionColor(espacio.nivelOcupacion),
                                  child: Icon(
                                    _getIconForTipo(espacio.tipo),
                                    color: Colors.white,
                                  ),
                                ),
                                title: Text(
                                  espacio.nombre,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 4),
                                    Text(
                                      espacio.tipo,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: _getOcupacionColor(espacio.nivelOcupacion).withValues(alpha: 0.2),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            _getOcupacionText(espacio.nivelOcupacion),
                                            style: TextStyle(
                                              color: _getOcupacionColor(espacio.nivelOcupacion),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Row(
                                          children: [
                                            const Icon(Icons.star, color: Colors.amber, size: 16),
                                            const SizedBox(width: 4),
                                            Text(
                                              espacio.promedioCalificacion.toStringAsFixed(1),
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetalleEspacioScreen(espacio: espacio),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }

  IconData _getIconForTipo(String tipo) {
    switch (tipo.toLowerCase()) {
      case 'biblioteca':
        return Icons.library_books;
      case 'cafetería':
        return Icons.local_cafe;
      case 'exterior':
        return Icons.park;
      case 'sala de estudio':
        return Icons.school;
      case 'comedor':
        return Icons.restaurant;
      case 'laboratorio':
        return Icons.computer;
      case 'auditorio':
        return Icons.theater_comedy;
      default:
        return Icons.place;
    }
  }
}
