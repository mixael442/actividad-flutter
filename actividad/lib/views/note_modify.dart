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
  DBUser? dbUsers;
  @override
  void initState() {
    super.initState();

    dbUsers = DBUser();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _nombre = TextEditingController();
    TextEditingController _apellido = TextEditingController();
    TextEditingController _dni = TextEditingController();
    TextEditingController _date = TextEditingController();
    TextEditingController _sueldo = TextEditingController();
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
                            sueldoMensual: int.parse(_sueldo.text)))
                        .then((value) => print('agregado exitosamente: $value'))
                        .onError(
                            (error, stackTrace) => print(error.toString()));
                  },
                  child: const Text(
                    "Actualizar",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
