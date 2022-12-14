import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/db_proyecto.dart';
import '../models/model.dart';

class NoteUpdateScreen extends StatefulWidget {
  final Usuarios userID;
  const NoteUpdateScreen({super.key, required this.userID});

  @override
  State<NoteUpdateScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<NoteUpdateScreen> {
  void calcularEdad() {
    DateTime fecha = DateTime.parse(_date.text);
    Duration calculado = DateTime.now().difference(fecha);
    double edad = calculado.inDays / 365;

    Flushbar(
      duration: const Duration(seconds: 3),
      message:
          'La edad de ${_nombre.text} es de ${edad.toInt()} años cumplidos',
      backgroundColor: Colors.black,
    ).show(context);
  }

  int? pickedMovie = 0;
  List<Peliculas> pelicula = [];
  TextEditingController _nombre = TextEditingController();
  TextEditingController _apellido = TextEditingController();
  TextEditingController _dni = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _sueldo = TextEditingController();
  TextEditingController _calcularFecha = TextEditingController();

  DBUser? dbUsers;
  @override
  void initState() {
    setState(() {
      _nombre.text = widget.userID.nombre;
      _apellido.text = widget.userID.apellido;
      _dni.text = widget.userID.dni.toString();
      _date.text = widget.userID.fechaNacimiento.toString();
      _sueldo.text = widget.userID.sueldoMensual.toString();
      pickedMovie = widget.userID.peliculafavorita;
    });
    super.initState();
    lista();
    dbUsers = DBUser();
  }

  lista() async {
    List<Peliculas> obtener = await DBUser().getPeliculas();
    setState(() {
      pelicula = obtener;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          // ignore: unnecessary_null_comparison
          title: const Text('Actualizar Usuario')),
      body: Scrollbar(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nombre,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(hintText: 'Nombre'),
              ),
              TextFormField(
                controller: _apellido,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(hintText: 'Apellido'),
              ),
              TextFormField(
                controller: _dni,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'DNI'),
              ),
              TextField(
                  controller: _date,
                  //keyboardType: TextInputType.datetime,
                  onTap: () async {
                    DateTime? calendar = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2050));

                    if (calendar != null) {
                      _date.text = DateFormat('yyy-mm-dd').format(calendar);
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Fecha de nacimiento',
                  )),
              TextFormField(
                controller: _sueldo,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Sueldo Mensual'),
              ),
              DropdownButton(
                  items: pelicula
                      .map((e) => DropdownMenuItem<Peliculas>(
                            value: e,
                            child: Text(e.pelicula),
                          ))
                      .toList(),
                  hint: Text(pickedMovie.toString()),
                  onChanged: ((value) {
                    setState(() {
                      pickedMovie = value!.id!;
                    });
                  })),
              ButtonBar(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          double float = 0.10;
                          int numero =
                              (int.parse(_sueldo.text) * (1 + float)).round();
                          _sueldo.text = numero.toString();
                        });
                      },
                      child: const Text('%10')),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          double float = 0.15;
                          int numero =
                              (int.parse(_sueldo.text) * (1 + float)).round();
                          _sueldo.text = numero.toString();
                        });
                      },
                      child: const Text('%15')),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          double float = 0.20;
                          int numero =
                              (int.parse(_sueldo.text) * (1 + float)).round();
                          _sueldo.text = numero.toString();
                        });
                      },
                      child: const Text('%20')),
                ],
              ),
              Container(height: 16),
              SizedBox(
                  width: double.infinity,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      dbUsers
                          ?.updateUsuarios(Usuarios(
                            id: widget.userID.id,
                            nombre: _nombre.text,
                            apellido: _apellido.text,
                            dni: int.parse(_dni.text),
                            fechaNacimiento: DateTime.parse(_date.text),
                            sueldoMensual: int.parse(_sueldo.text),
                            peliculafavorita: pickedMovie,
                          ))
                          .then(
                              (value) => print('editado exitosamente: $value'));
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Actualizar",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
