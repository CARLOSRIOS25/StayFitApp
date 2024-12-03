import 'package:clase01/main.dart';
import 'package:flutter/material.dart';
import 'package:clase01/usuario.dart';
import 'package:clase01/database_helper.dart';
import 'package:provider/provider.dart';

class ViewProfile extends StatelessWidget {
  final List<Usuario> listaUsuarios;
  final DatabaseHelper dbHelper;

  const ViewProfile({super.key, required this.listaUsuarios, required this.dbHelper,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tus Datos'),
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
          children: listaUsuarios.map((usuario) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.person, color: Colors.amber),
                        title: Text(
                          '${usuario.firstName} ${usuario.lastName}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildInfoRow(Icons.email, usuario.email),
                      _buildInfoRow(Icons.cake, usuario.age),
                      _buildInfoRow(Icons.fitness_center, usuario.weight),
                      _buildInfoRow(Icons.people, usuario.gender),
                      if (usuario.healthIssues.isNotEmpty)
                        _buildInfoRow(Icons.medical_services, usuario.healthIssues),
                      _buildInfoRow(Icons.star, usuario.objective),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}
