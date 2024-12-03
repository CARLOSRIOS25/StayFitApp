// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, avoid_print

import 'package:clase01/myhome_page.dart';
import 'package:clase01/registery_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() async {
  // Inicializa Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCoIR8lSraCPfMNTs27kyxGrMLjLmCZt_M",
      authDomain: "fir-9cb0e.firebaseapp.com",
      projectId: "fir-9cb0e",
      storageBucket: "fir-9cb0e.appspot.com",
      messagingSenderId: "1012654011903",
      appId: "1:1012654011903:android:7f0778acf3b7cb6015a3c",
      measurementId: "G-measurement-id",
    ),
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STAYFIT APP',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).isDarkMode
          ? ThemeData.dark().copyWith(
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.amber,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.amber),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
            )
          : ThemeData.light().copyWith(
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.amber,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.amber),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
              ),
            ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController emailController =
      TextEditingController(); // Controlador para el campo de correo
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key}); // Controlador para el campo de contraseña

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sing Up'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6, color: Colors.black),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Container(
            width: viewportConstraints.maxWidth,
            height: viewportConstraints.maxHeight,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.black.withOpacity(0.7),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
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
                    const SizedBox(height: 50), // Espacio en blanco
                    Center(
                      child: SizedBox(
                        width: 300,
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'Correo electrónico',
                            labelStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: SizedBox(
                        width: 300, // Ancho deseado del campo de texto
                        child: TextField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Contraseña',
                            labelStyle: TextStyle(
                              // Change label color
                              fontSize: 18,
                              color: Colors.white, // Change label font size
                            ),
                          ),
                          style: const TextStyle(
                            // This makes the input text black
                            color: Colors.white,
                          ),
                          obscureText:
                              true, // Para ocultar el texto en el campo de contraseña
                          textAlign: TextAlign.center, // Centra el texto
                        ),
                      ),
                    ),
                    const SizedBox(height: 30), // Espacio en blanco
                    // Botón para iniciar sesión
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          // Intenta iniciar sesión con Firebase
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          // Inicio de sesión exitoso, navega a la página de "Hola Mundo"
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HelloWorldScreen(),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Correo electrónico o contraseña incorrectos',
                              ),
                            ),
                          );
                          print(
                              'Error de inicio de sesión: $e'); // Imprime el error en la consola
                        }
                      },
                      child: const Text(
                          'Iniciar Sesión'), // Texto del botón de inicio de sesión
                    ),
                    const SizedBox(height: 8), // Espacio en blanco
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Registrarse',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ), // Texto del botón de registro
                    ),
                  ],
                ),
              ),
            ));
      }),
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
