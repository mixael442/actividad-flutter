import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../db/db_proyecto.dart';
import '../models/model.dart';

class NoteModifyScreen extends StatefulWidget {
  const NoteModifyScreen({Key? key}) : super(key: key);
  //const NoteModifyScreen({super.key, required this.userID});

  @override
  State<NoteModifyScreen> createState() => _NoteModifyScreenState();
}

class _NoteModifyScreenState extends State<NoteModifyScreen> {
  Peliculas pickedMovie =
      Peliculas(pelicula: '', presupuesto: 0, recaudacion: 0);
  List<Peliculas> pelicula = [];
  DBUser? dbUsers;
  @override
  void initState() {
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

  TextEditingController _nombre = TextEditingController();
  TextEditingController _apellido = TextEditingController();
  TextEditingController _dni = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _sueldo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // ignore: unnecessary_null_comparison
          title: const Text('Creacion de Usuario')),
      body: Padding(
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
                keyboardType: TextInputType.datetime,
                onTap: () async {
                  DateTime? calendar = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1940),
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
            DropdownButton<Peliculas>(
                items: pelicula
                    .map((e) => DropdownMenuItem<Peliculas>(
                          value: e,
                          child: Text(e.pelicula),
                        ))
                    .toList(),
                hint: Text(pickedMovie.pelicula),
                onChanged: ((value) {
                  setState(() {
                    pickedMovie = value!;
                  });
                })),
            Container(height: 16),
            SizedBox(
                width: double.infinity,
                height: 35,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    dbUsers
                        ?.insert(Usuarios(
                          nombre: _nombre.text,
                          apellido: _apellido.text,
                          dni: int.parse(_dni.text),
                          fechaNacimiento: DateTime.parse(_date.text),
                          sueldoMensual: int.parse(_sueldo.text),
                          peliculafavorita: pickedMovie.id!,
                        ))
                        .then(
                            (value) => print('agregado exitosamente: $value'));
                  },
                  child: const Text(
                    "Agregar",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
