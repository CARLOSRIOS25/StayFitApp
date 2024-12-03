import 'package:sqflite/sqflite.dart'; // Importa el paquete sqflite para utilizar SQLite.
import 'package:path/path.dart'; // Importa el paquete path para manejar rutas de archivos.
import 'package:clase01/usuario.dart'; // Importa el modelo Usuario.

// Declaración de la clase DatabaseHelper:
class DatabaseHelper {
  static Database? _database; // Variable estática que contendrá la referencia a la base de datos.
  static const String dbName = 'usuarios.db'; // Nombre de la base de datos.
  static const String tableUsuarios = 'usuarios'; // Nombre de la tabla de usuarios en la base de datos.
  static const String tableRutinas = 'rutinas'; // Nombre de la tabla de rutinas en la base de datos.

  // Método para obtener la instancia de la base de datos.
  Future<Database> get database async {
    // Verifica si la base de datos ya está inicializada.
    if (_database != null) return _database!;

    // Si no está inicializada, la inicializa.
    _database = await initDatabase();
    return _database!;
  }

  // Método para inicializar la base de datos.
  Future<Database> initDatabase() async {
    // Obtiene la ruta de la base de datos en el dispositivo.
    String path = join(await getDatabasesPath(), dbName);

    // Abre la base de datos (crea si no existe).
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  // Método para crear las tablas en la base de datos si no existen.
  void _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableUsuarios(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT,
        password TEXT,
        firstName TEXT,
        lastName TEXT,
        age TEXT,
        weight TEXT,
        gender TEXT, 
        healthIssues TEXT,
        objective TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableRutinas(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        dia TEXT,
        ejercicio TEXT,
        descripcion TEXT,
        intensidad TEXT,
        calorias INTEGER
      )
    ''');
  }

  // Métodos para manejar usuarios:
  Future<int> insertUsuario(Usuario usuario) async {
    final db = await database;
    return await db.insert(tableUsuarios, usuario.toMap());
  }

  Future<List<Usuario>> getUsuarios() async {
    final db = await database;
    final List<Map<String, dynamic>> usuariosMap = await db.query(tableUsuarios);

    // Convierte la lista de Mapas en una lista de objetos Usuario.
    return List.generate(usuariosMap.length, (index) {
      return Usuario.fromMap(usuariosMap[index]);
    });
  }

  // Métodos para manejar rutinas:
  Future<int> insertarRutina(Map<String, dynamic> rutina) async {
    final db = await database;
    return await db.insert(tableRutinas, rutina);
  }

  Future<List<Map<String, dynamic>>> obtenerRutinas() async {
    final db = await database;
    return await db.query(tableRutinas);
  }

  Future<int> eliminarRutina(int id) async {
    final db = await database;
    return await db.delete(tableRutinas, where: 'id = ?', whereArgs: [id]);
  }
}
