import 'dart:typed_data';

class Usuarios {
  int? id;
  String nombre;
  String apellido;
  int dni;
  DateTime fechaNacimiento;
  int sueldoMensual;
  int? peliculafavorita;

  Usuarios(
      {this.id,
      required this.nombre,
      required this.apellido,
      required this.dni,
      required this.fechaNacimiento,
      required this.sueldoMensual,
      this.peliculafavorita});

  factory Usuarios.fromMap(Map<String, dynamic> json) => Usuarios(
      id: json["id"],
      nombre: json["nombre"],
      apellido: json["apellido"],
      dni: json["dni"],
      fechaNacimiento: DateTime.parse(json["fechanacimiento"]),
      sueldoMensual: json["sueldomensual"],
      peliculafavorita: json["peliculafavorita"]);

  Map<String, Object?> toMap() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "dni": dni,
        "fechanacimiento":
            "${fechaNacimiento.year.toString().padLeft(4, '0')}-${fechaNacimiento.month.toString().padLeft(2, '0')}-${fechaNacimiento.day.toString().padLeft(2, '0')}",
        "sueldomensual": sueldoMensual,
        "peliculafavorita": peliculafavorita,
      };
}

class Peliculas {
  int? id;
  String pelicula;
  int presupuesto;
  int recaudacion;
  Uint8List? imagen;

  Peliculas({
    this.id,
    required this.pelicula,
    required this.presupuesto,
    required this.recaudacion,
    this.imagen,
  });

  factory Peliculas.fromMap(Map<String, dynamic> json) => Peliculas(
        id: json["id"],
        pelicula: json["pelicula"],
        presupuesto: json["presupuesto"],
        recaudacion: json["recaudacion"],
        imagen: json["imagen"],
      );

  Map<String, Object?> toMap() => {
        "id": id,
        "pelicula": pelicula,
        "presupuesto": presupuesto,
        "recaudacion": recaudacion,
        "imagen": imagen,
      };
}

class Fotos {
  int? id;
  Uint8List? foto;

  Fotos({this.id, this.foto});

  factory Fotos.fromMap(Map<String, dynamic> json) =>
      Fotos(id: json["id"], foto: json["foto"]);

  Map<String, Object?> toMap() => {"id": id, "foto": foto};
}
