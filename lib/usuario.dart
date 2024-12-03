class Usuario {
  final int? id; // Id de la persona, puede ser nulo.
  final String email;
  final String password;
  final String firstName; // Nombre de la persona.
  final String lastName; // Apellidos de la persona.
  final String age;
  final String weight;
  final String gender;
  final String healthIssues;
  final String objective; 

  // Constructor de la clase Persona.
  Usuario({
    this.id, // El id puede ser nulo.
    required this.email,
    required this.password,
    required this.firstName, // El nombre es obligatorio.
    required this.lastName, // Los apellidos son obligatorios.
    required this.age,
    required this.weight, 
    required this.gender,
    required this.healthIssues, 
    required this.objective,
  });

  // Constructor de fábrica para crear una Persona desde un Map.
  factory Usuario.fromMap(Map<String, dynamic> json) {
    return Usuario(
      id: json["id"], // Asigna el id desde el mapa.
      email: json["email"],
      password: json["password"],
      firstName: json["firstName"], // Asigna el nombre desde el mapa.
      lastName: json["lastName"], // Asigna los apellidos desde el mapa.
      age: json["age"],
      weight: json["weight"],
      gender: json["gender"],
      healthIssues: json["healthIssues"],
      objective: json["objective"]
    );
  }

  // Método para convertir un usuario a un Map.
  Map<String, dynamic> toMap() {
    return {
      if (id != null) "id": id, // Si el id no es nulo, añade el id al mapa.
      "email": email,
      "password": password,
      "firstName": firstName, // Añade el nombre al mapa.
      "lastName": lastName,
      "age": age, 
      "weight": weight,
      "gender": gender,
      "healthIssues": healthIssues,
      "objective": objective
    };
  }
}
