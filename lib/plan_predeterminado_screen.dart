// ignore_for_file: library_private_types_in_public_api

import 'package:clase01/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlanPredeterminadoScreen extends StatefulWidget {
  const PlanPredeterminadoScreen({super.key});

  @override
  _PlanPredeterminadoScreenState createState() => _PlanPredeterminadoScreenState();
}

class _PlanPredeterminadoScreenState extends State<PlanPredeterminadoScreen> {
  int currentWeek = 1;
  double progress = 0.0;

  void completeWeek() {
    setState(() {
      if (currentWeek < 5) {
        currentWeek++;
        progress += 0.25;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan Predeterminado'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6, color: Colors.black),
            onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
              },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            WeekWidget(
              weekNumber: currentWeek,
              message: currentWeek % 2 == 0
                  ? 'Realiza pocas repeticiones con un peso considerable para hipertrofiar el músculo.'
                  : 'Realiza altas repeticiones con poco peso para adaptación y descanso muscular.',
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: completeWeek,
                child: const Text('Completar Semana'),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 10,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Progreso: ${(progress * 100).toInt()}%',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeekWidget extends StatelessWidget {
  final int weekNumber;
  final String message;

  const WeekWidget({super.key, required this.weekNumber, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Semana $weekNumber',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              message,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
          const DayWidget(
            dayNumber: 1,
            muscleGroups: 'Pierna-Hombro',
          ),
          const DayWidget(
            dayNumber: 2,
            muscleGroups: 'Pecho-Tríceps',
          ),
          const DayWidget(
            dayNumber: 3,
            muscleGroups: 'Espalda-Bíceps',
          ),
        ],
      ),
    );
  }
}

class DayWidget extends StatelessWidget {
  final int dayNumber;
  final String muscleGroups;

  const DayWidget({super.key, required this.dayNumber, required this.muscleGroups});

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, String>>> exercisesDescription = {
      'Pierna-Hombro': [
        {'name': 'Sentadilla Libre', 'description': 'Este ejercicio trabaja los cuádriceps, los glúteos y los isquiotibiales.'},
        {'name': 'Hacka', 'description': 'El hack squat es un ejercicio de piernas que trabaja los cuádriceps y los glúteos.'},
        {'name': 'Extensiones de Cuádriceps', 'description': 'Las extensiones de cuádriceps son un ejercicio de aislamiento para el cuádriceps.'},
        {'name': 'Press Militar', 'description': 'El press militar es un ejercicio compuesto que trabaja los hombros y los tríceps.'},
        {'name': 'Elevaciones Laterales', 'description': 'Las elevaciones laterales son un ejercicio para los deltoides laterales.'},
      ],
      'Pecho-Tríceps': [
        {'name': 'Press Plano', 'description': 'El press de banca plano es un ejercicio clásico de pecho que también trabaja los tríceps y los hombros.'},
        {'name': 'Press Inclinado', 'description': 'El press de banca inclinado se enfoca más en la parte superior del pecho y los hombros.'},
        {'name': 'Aperturas en Máquina', 'description': 'Las aperturas en máquina son un ejercicio de aislamiento para el pecho.'},
        {'name': 'Fondos en Paralelas', 'description': 'Los fondos en paralelas son un ejercicio efectivo para trabajar el pecho y los tríceps.'},
        {'name': 'Extensiones de Tríceps', 'description': 'Las extensiones de tríceps son un ejercicio de aislamiento para los tríceps.'},
      ],
      'Espalda-Bíceps': [
        {'name': 'Remo con Barra', 'description': 'El remo con barra es un ejercicio compuesto que trabaja la espalda, los hombros y los brazos.'},
        {'name': 'Jalón al Pecho en Polea', 'description': 'El jalón al pecho en polea es un ejercicio para la parte superior de la espalda y los hombros.'},
        {'name': 'Pullover en Polea', 'description': 'El pullover en polea es un ejercicio para la espalda y el pecho.'},
        {'name': 'Curl de Bíceps con Barra', 'description': 'El curl de bíceps con barra es un ejercicio básico para desarrollar los bíceps.'},
        {'name': 'Curl de Bíceps con Mancuernas', 'description': 'El curl de bíceps con mancuernas es un ejercicio efectivo para aislar los bíceps.'},
      ],
    };

    List<Map<String, String>> exercises = exercisesDescription[muscleGroups]!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpansionTile(
            title: Text(
              muscleGroups,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            children: [
              for (var exercise in exercises)
                ListTile(
                  title: Text(
                    exercise['name']!,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  subtitle: Text(
                    exercise['description']!,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}