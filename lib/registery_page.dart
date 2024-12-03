// ignore_for_file: use_build_context_synchronously, avoid_print, library_private_types_in_public_api

import 'package:clase01/database_helper.dart';
import 'package:clase01/main.dart';
import 'package:clase01/usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController healthIssuesController = TextEditingController();

  final DatabaseHelper dbHelper = DatabaseHelper();

  List<String> objectives = [
    'Ganar peso',
    'Perder peso',
    'Masa muscular',
    'Definición',
    'Volumen'
  ];
  String selectedObjective = 'Ganar peso';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrate'),
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipOval(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/logo.jpeg'),
                        fit: BoxFit.cover, 
                      ),
                    ),
                  ),
                ),
              SizedBox(
                width: 300, // Ancho deseado del campo de texto
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                  ),
                ),
              ),
              SizedBox(
                width: 300, // Ancho deseado del campo de texto
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              textFieldWithIcon(firstNameController, 'Nombre', Icons.person),
              const SizedBox(height: 20),
              textFieldWithIcon(
                  lastNameController, 'Apellidos', Icons.person_outline),
              const SizedBox(height: 20),
              textFieldWithIcon(ageController, 'Edad', Icons.calendar_today),
              const SizedBox(height: 20),
              textFieldWithIcon(weightController, 'Peso', Icons.fitness_center),
              const SizedBox(height: 20),
              textFieldWithIcon(genderController, 'Sexo', Icons.people),
              const SizedBox(height: 20),
              textFieldWithIcon(healthIssuesController, 'Problemas de Salud',
                  Icons.medical_services),
              const SizedBox(height: 20),
              
              DropdownButtonFormField(
                value: selectedObjective,
                items: objectives.map((String objective) {
                  return DropdownMenuItem(
                    value: objective,
                    child: Text(objective),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedObjective = newValue!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Objetivos',
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (firstNameController.text.isNotEmpty &&
                      lastNameController.text.isNotEmpty &&
                      ageController.text.isNotEmpty &&
                      weightController.text.isNotEmpty &&
                      genderController.text.isNotEmpty) {
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      // Aquí podrías añadir código para guardar la información adicional en Firestore o otro servicio
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    } catch (e) {
                      print('Error de registro: $e');
                    }
                    await dbHelper.insertUsuario(Usuario(
                      email: emailController.text,
                      password: passwordController.text,
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      age: ageController.text,
                      weight: weightController.text,  
                      gender: genderController.text,
                      healthIssues: healthIssuesController.text,
                      objective: selectedObjective.toString(),
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Agregado correctamente'), // Mensaje de éxito al agregar la persona
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Por favor, completa todos los campos'), // Mensaje si los campos están vacíos
                      ),
                    );
                  }
                },
                child: const Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFieldWithIcon(
      TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        width: 300, // Ancho deseado del campo de texto
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            hintText: 'Introduce tu $label',
            border: const OutlineInputBorder(),
            prefixIcon: Icon(icon),
          ),
        ),
      ),
    );
  }
}

  Widget textFieldWithIcon(
      TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: 'Introduce tu $label',
          border: const OutlineInputBorder(),
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }