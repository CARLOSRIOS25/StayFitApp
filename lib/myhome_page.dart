
// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:clase01/database_helper.dart';
import 'package:clase01/main.dart';
import 'package:clase01/mostrar_rutinas_screen.dart';
import 'package:clase01/plan_personalizado_screen.dart';
import 'package:clase01/plan_predeterminado_screen.dart';
import 'package:clase01/usuario.dart';
import 'package:clase01/view_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HelloWorldScreen extends StatefulWidget {
  const HelloWorldScreen({super.key});

  @override
  _HelloWorldScreenState createState() => _HelloWorldScreenState();
}

class _HelloWorldScreenState extends State<HelloWorldScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'StayFit & Health',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 30,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Color.fromARGB(255, 136, 93, 0)),
            onPressed: () async {
              List<Usuario> usuario = await dbHelper.getUsuarios();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ViewProfile(listaUsuarios: usuario, dbHelper: dbHelper),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6, color: Colors.black),
            onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
              },
          ),
        ],
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 5),
                GestureDetector(
                  child: Container(
                    height:99,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/logo.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PlanPersonalizadoScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage('assets/mancuerna.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Avanzado: Arma tu plan!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PlanPredeterminadoScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(20),
                      ),

                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: const DecorationImage(
                        image: AssetImage('assets/levantamiento.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Principiante: Rutina para tu primer mes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MostrarRutinasScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),

                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage('assets/rutinas.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Tus Rutinas Personalizadas',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  color: Colors.grey[200],
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        color: Colors.amber,
                        icon: const Icon(Icons.mail),
                        onPressed: () {
                          // Acción al presionar el icono de correo
                        },
                      ),
                      IconButton(
                        color: Colors.blue,
                        icon: const Icon(Icons.facebook),
                        onPressed: () {
                          // Acción al presionar el icono de Facebook
                        },
                      ),
                      IconButton(
                        color: Colors.amber,
                        icon: const Icon(Icons.g_translate),
                        onPressed: () {
                          // Acción al presionar el icono de Google
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}