// To parse this JSON data, do
//
//     final usuarios = usuariosFromMap(jsonString);

import 'dart:convert';

class Usuarios {
  int id;
  String nombre;
  String apellido;
  String? dni;
  DateTime fechaCreacion;
  DateTime fechaNacimiento;
  String sueldoMensual;
  int? hobby;
  int? peliculaFavorita;

  Usuarios({
    required this.id,
    required this.nombre,
    required this.apellido,
    this.dni,
    required this.fechaCreacion,
    required this.fechaNacimiento,
    required this.sueldoMensual,
    this.hobby,
    this.peliculaFavorita,
  });

  factory Usuarios.fromJson(String str) => Usuarios.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usuarios.fromMap(Map<String, dynamic> json) => Usuarios(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        dni: json["dni"],
        fechaCreacion: DateTime.parse(json["fecha_creacion"]),
        fechaNacimiento: DateTime.parse(json["fecha_nacimiento"]),
        sueldoMensual: json["sueldo_mensual"],
        hobby: json["hobby"],
        peliculaFavorita: json["pelicula_favorita"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "dni": dni,
        "fecha_creacion": fechaCreacion.toIso8601String(),
        "fecha_nacimiento":
            "${fechaNacimiento.year.toString().padLeft(4, '0')}-${fechaNacimiento.month.toString().padLeft(2, '0')}-${fechaNacimiento.day.toString().padLeft(2, '0')}",
        "sueldo_mensual": sueldoMensual,
        "hobby": hobby,
        "pelicula_favorita": peliculaFavorita,
      };
}
