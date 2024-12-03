// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:clase01/main.dart';
import 'package:clase01/mostrar_rutinas_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clase01/database_helper.dart'; // Importa DatabaseHelper

class PlanPersonalizadoScreen extends StatefulWidget {
  const PlanPersonalizadoScreen({super.key});

  @override
  _PlanPersonalizadoScreenState createState() =>
      _PlanPersonalizadoScreenState();
}

class _PlanPersonalizadoScreenState extends State<PlanPersonalizadoScreen> {
  List<String> musculos = [
    'Pierna (femorales)',
    'Pierna (cuádriceps)',
    'Espalda (baja)',
    'Espalda (alta)',
    'Pecho (bajo)',
    'Pecho (medio)',
    'Pecho (alto)',
    'Hombro',
    'Glúteos',
    'Pantorrilla',
  ];

  String selectedMusculo = 'Pierna (femorales)';

  Map<String, List<Map<String, dynamic>>> ejerciciosPorMusculo = {
    'Pierna (femorales)': [
      {
        'nombre': 'Peso muerto rumano',
        'recomendacion': 'Fortalece los isquiotibiales',
        'intensidad': 'Moderada',
        'calorias_por_serie': 80
      },
      {
        'nombre': 'Prensa',
        'recomendacion': 'Trabaja los cuádriceps',
        'intensidad': 'Alta',
        'calorias_por_serie': 100
      },
      {
        'nombre': 'Curl de piernas',
        'recomendacion': 'Aísla los isquiotibiales',
        'intensidad': 'Moderada',
        'calorias_por_serie': 70
      },
      {
        'nombre': 'Extensiones de piernas',
        'recomendacion': 'Aísla los cuádriceps',
        'intensidad': 'Moderada',
        'calorias_por_serie': 60
      },
      {
        'nombre': 'Zancadas',
        'recomendacion': 'Trabajo unilateral de cuádriceps',
        'intensidad': 'Alta',
        'calorias_por_serie': 90
      },
      {
        'nombre': 'Elevación de talones de pie',
        'recomendacion': 'Trabajo de los gemelos',
        'intensidad': 'Alta',
        'calorias_por_serie': 50
      },
    ],
    'Pierna (cuádriceps)': [
      {
        'nombre': 'Sentadillas',
        'recomendacion': 'Ejercicio compuesto para cuádriceps',
        'intensidad': 'Alta',
        'calorias_por_serie': 100
      },
      {
        'nombre': 'Prensa de pierna',
        'recomendacion': 'Trabaja los cuádriceps y glúteos',
        'intensidad': 'Alta',
        'calorias_por_serie': 90
      },
      {
        'nombre': 'Extensiones de pierna',
        'recomendacion': 'Aísla los cuádriceps',
        'intensidad': 'Moderada',
        'calorias_por_serie': 60
      },
    ],
    'Espalda (baja)': [
      {
        'nombre': 'Peso muerto',
        'recomendacion': 'Fortalece la parte baja de la espalda',
        'intensidad': 'Alta',
        'calorias_por_serie': 110
      },
      {
        'nombre': 'Hiperextensiones',
        'recomendacion': 'Trabaja los erectores espinales',
        'intensidad': 'Moderada',
        'calorias_por_serie': 70
      },
    ],
    'Espalda (alta)': [
      {
        'nombre': 'Remo con barra',
        'recomendacion': 'Desarrolla la musculatura de la espalda alta',
        'intensidad': 'Alta',
        'calorias_por_serie': 90
      },
      {
        'nombre': 'Pull-ups',
        'recomendacion': 'Ejercicio compuesto para la espalda alta',
        'intensidad': 'Alta',
        'calorias_por_serie': 100
      },
      {
        'nombre': 'Face pulls',
        'recomendacion': 'Trabaja los trapecios y los deltoides posteriores',
        'intensidad': 'Moderada',
        'calorias_por_serie': 60
      },
    ],
    'Pecho (bajo)': [
      {
        'nombre': 'Press de banca declinado',
        'recomendacion': 'Enfocado en la parte baja del pecho',
        'intensidad': 'Alta',
        'calorias_por_serie': 100
      },
      {
        'nombre': 'Fondos',
        'recomendacion': 'Trabaja la parte baja del pecho y los tríceps',
        'intensidad': 'Alta',
        'calorias_por_serie': 90
      },
    ],
    'Pecho (medio)': [
      {
        'nombre': 'Press de banca',
        'recomendacion': 'Ejercicio principal para el pecho',
        'intensidad': 'Alta',
        'calorias_por_serie': 100
      },
      {
        'nombre': 'Aperturas con mancuernas',
        'recomendacion': 'Aísla los músculos del pecho',
        'intensidad': 'Moderada',
        'calorias_por_serie': 60
      },
    ],
    'Pecho (alto)': [
      {
        'nombre': 'Press de banca inclinado',
        'recomendacion': 'Enfocado en la parte alta del pecho',
        'intensidad': 'Alta',
        'calorias_por_serie': 90
      },
      {
        'nombre': 'Aperturas con mancuernas en banco inclinado',
        'recomendacion': 'Aísla la parte alta del pecho',
        'intensidad': 'Moderada',
        'calorias_por_serie': 60
      },
    ],
    'Hombro': [
      {
        'nombre': 'Press militar',
        'recomendacion': 'Desarrolla la fuerza del hombro',
        'intensidad': 'Alta',
        'calorias_por_serie': 80
      },
      {
        'nombre': 'Elevaciones laterales',
        'recomendacion': 'Aísla los deltoides laterales',
        'intensidad': 'Moderada',
        'calorias_por_serie': 50
      },
      {
        'nombre': 'Elevaciones frontales',
        'recomendacion': 'Aísla los deltoides frontales',
        'intensidad': 'Moderada',
        'calorias_por_serie': 50
      },
    ],
    'Glúteos': [
      {
        'nombre': 'Hip thrust',
        'recomendacion': 'Fortalece los glúteos',
        'intensidad': 'Alta',
        'calorias_por_serie': 90
      },
      {
        'nombre': 'Sentadillas búlgaras',
        'recomendacion': 'Trabajo unilateral de glúteos',
        'intensidad': 'Alta',
        'calorias_por_serie': 80
      },
      {
        'nombre': 'Patada de glúteo',
        'recomendacion': 'Aísla los glúteos',
        'intensidad': 'Moderada',
        'calorias_por_serie': 60
      },
    ],
    'Pantorrilla': [
      {
        'nombre': 'Elevación de talones de pie',
        'recomendacion': 'Trabajo de los gemelos',
        'intensidad': 'Alta',
        'calorias_por_serie': 50
      },
      {
        'nombre': 'Elevación de talones sentado',
        'recomendacion': 'Aísla los gemelos',
        'intensidad': 'Moderada',
        'calorias_por_serie': 40
      },
    ],
  };

  Map<String, List<String>> ejerciciosSeleccionados = {
    'Lunes': [],
    'Martes': [],
    'Miércoles': [],
    'Jueves': [],
    'Viernes': [],
    'Sábado': [],
    'Domingo': [],
  };

  String selectedDay = 'Lunes';
  int totalCalorias = 0;

  void _addEjercicio(String nombre, int calorias) {
    setState(() {
      ejerciciosSeleccionados[selectedDay] ??= [];
      ejerciciosSeleccionados[selectedDay]!.add(nombre);
      totalCalorias += calorias;
    });
  }

  void _removeEjercicio(String nombre, int calorias) {
    setState(() {
      ejerciciosSeleccionados[selectedDay]?.remove(nombre);
      totalCalorias -= calorias;
    });
  }

  // Método para guardar la rutina en la base de datos
  void _guardarRutina() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    for (var dia in ejerciciosSeleccionados.keys) {
      for (var ejercicio in ejerciciosSeleccionados[dia]!) {
        final ejercicioData = ejerciciosPorMusculo.values
            .expand((ejercicios) => ejercicios)
            .firstWhere((e) => e['nombre'] == ejercicio);
        await dbHelper.insertarRutina({
          'dia': dia,
          'ejercicio': ejercicio,
          'descripcion': ejercicioData['recomendacion'],
          'intensidad': ejercicioData['intensidad'],
          'calorias': ejercicioData['calorias_por_serie'] * 4,
        });
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Rutina guardada con éxito')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arma tu Plan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6, color: Colors.black),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Arma tu rutina a tu gusto',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Selecciona un día de la semana:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedDay,
              onChanged: (newValue) {
                setState(() {
                  selectedDay = newValue!;
                });
              },
              items: [
                'Lunes',
                'Martes',
                'Miércoles',
                'Jueves',
                'Viernes',
                'Sábado',
                'Domingo'
              ].map((day) {
                return DropdownMenuItem<String>(
                  value: day,
                  child: Text(day),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Selecciona un músculo:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedMusculo,
              onChanged: (newValue) {
                setState(() {
                  selectedMusculo = newValue!;
                });
              },
              items: musculos.map((musculo) {
                return DropdownMenuItem<String>(
                  value: musculo,
                  child: Text(musculo),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Text(
              'Ejercicios para $selectedMusculo:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: ejerciciosPorMusculo[selectedMusculo]!.length,
                itemBuilder: (context, index) {
                  final ejercicio =
                      ejerciciosPorMusculo[selectedMusculo]![index];
                  return ListTile(
                    title: Text(ejercicio['nombre']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Recomendación: ${ejercicio['recomendacion']}'),
                        Text('Intensidad: ${ejercicio['intensidad']}'),
                        Text(
                            'Calorías totales en 4 series: ${ejercicio['calorias_por_serie']! * 4} kcal'),
                        const SizedBox(height: 10),
                      ],
                    ),
                    onTap: () {
                      _addEjercicio(ejercicio['nombre'],
                          (ejercicio['calorias_por_serie']! * 4) as int);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Ejercicios seleccionados para $selectedDay:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: ejerciciosSeleccionados[selectedDay]?.length ?? 0,
                itemBuilder: (context, index) {
                  final nombreEjercicio =
                      ejerciciosSeleccionados[selectedDay]![index];
                  final ejercicio = ejerciciosPorMusculo[selectedMusculo]!
                      .firstWhere((e) => e['nombre'] == nombreEjercicio,
                          orElse: () => {'calorias_por_serie': 0});
                  final caloriasEjercicio =
                      ejercicio['calorias_por_serie']! * 4;
                  return ListTile(
                    title: Text(nombreEjercicio),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _removeEjercicio(nombreEjercicio, caloriasEjercicio);
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Total de calorías: $totalCalorias kcal',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceEvenly, // Alinea los botones equitativamente en el espacio disponible
              children: [
                ElevatedButton(
                  onPressed: () {
                    _guardarRutina();
                    _limpiarEjercicios();
                  },
                  child: const Text('Guardar Rutina'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MostrarRutinasScreen(),
                      ),
                    );
                  },
                  child: const Text('Mostrar Rutinas'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _limpiarEjercicios() {
    setState(() {
      ejerciciosSeleccionados = {
        'Lunes': [],
        'Martes': [],
        'Miércoles': [],
        'Jueves': [],
        'Viernes': [],
        'Sábado': [],
        'Domingo': [],
      };
      totalCalorias = 0;
    });
  }
}
