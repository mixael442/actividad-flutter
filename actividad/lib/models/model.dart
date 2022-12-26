import 'dart:typed_data';

class Usuarios {
  int? id;
  String nombre;
  String apellido;
  int dni;
  DateTime fechaNacimiento;
  int sueldoMensual;

  Usuarios({
    this.id,
    required this.nombre,
    required this.apellido,
    required this.dni,
    required this.fechaNacimiento,
    required this.sueldoMensual,
  });

  factory Usuarios.fromMap(Map<String, dynamic> json) => Usuarios(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        dni: json["dni"],
        fechaNacimiento: DateTime.parse(json["fechanacimiento"]),
        sueldoMensual: json["sueldomensual"],
      );

  Map<String, Object?> toMap() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "dni": dni,
        "fechanacimiento":
            "${fechaNacimiento.year.toString().padLeft(4, '0')}-${fechaNacimiento.month.toString().padLeft(2, '0')}-${fechaNacimiento.day.toString().padLeft(2, '0')}",
        "sueldomensual": sueldoMensual,
      };
}

class Peliculas {
  int? id;
  String pelicula;
  int recaudacion;
  int presupuesto;
  String? imagen;

  Peliculas({
    this.id,
    required this.pelicula,
    required this.recaudacion,
    required this.presupuesto,
    this.imagen,
  });

  factory Peliculas.fromMap(Map<String, dynamic> json) => Peliculas(
        id: json["id"],
        pelicula: json["pelicula"],
        recaudacion: json["recaudacion"],
        presupuesto: json["presupuesto"],
        imagen: json["imagen"],
      );

  Map<String, Object?> toMap() => {
        "id": id,
        "pelicula": pelicula,
        "recaudacion": recaudacion,
        "presupuesto": presupuesto,
        "imagen": imagen,
      };
}
