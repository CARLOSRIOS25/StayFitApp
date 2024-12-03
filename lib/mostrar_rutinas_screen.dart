// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:clase01/database_helper.dart';

class MostrarRutinasScreen extends StatefulWidget {
  const MostrarRutinasScreen({super.key});

  @override
  _MostrarRutinasScreenState createState() => _MostrarRutinasScreenState();
}

class _MostrarRutinasScreenState extends State<MostrarRutinasScreen> {
  Map<String, List<Map<String, dynamic>>> _rutinasPorDia = {};
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _cargarRutinas();
  }

  Future<void> _cargarRutinas() async {
    List<Map<String, dynamic>> rutinas = await _dbHelper.obtenerRutinas();
    setState(() {
      // Agrupar rutinas por día
      _rutinasPorDia = {};
      for (var rutina in rutinas) {
        final dia = rutina['dia'];
        if (!_rutinasPorDia.containsKey(dia)) {
          _rutinasPorDia[dia] = [];
        }
        _rutinasPorDia[dia]!.add(rutina);
      }
      // Ordenar los días de la semana
      _rutinasPorDia = Map.fromEntries(
        _rutinasPorDia.entries.toList()
          ..sort((a, b) {
            final diasSemana = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];
            final indexA = diasSemana.indexOf(a.key);
            final indexB = diasSemana.indexOf(b.key);
            return indexA.compareTo(indexB);
          }),
      );
    });
  }

  Future<void> _eliminarRutina(int id) async {
    await _dbHelper.eliminarRutina(id);
    _cargarRutinas(); // Recargar la lista después de eliminar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Rutinas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _cargarRutinas,
          ),
        ],
      ),
      body: _rutinasPorDia.isEmpty
          ? const Center(child: Text('No hay rutinas guardadas'))
          : ListView.builder(
              itemCount: _rutinasPorDia.length,
              itemBuilder: (context, index) {
                final dia = _rutinasPorDia.keys.toList()[index];
                final ejercicios = _rutinasPorDia[dia]!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Día: $dia',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Column(
                      children: ejercicios.map((rutina) {
                        return ListTile(
                          title: Text(rutina['ejercicio']),
                          subtitle: Text(
                              'Descripcion: ${rutina['descripcion']}, Intensidad: ${rutina['intensidad']}, Calorias: ${rutina['calorias']},'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _eliminarRutina(rutina['id']);
                            },
                          ),
                        );
                      }).toList(),
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
    );
  }
}
