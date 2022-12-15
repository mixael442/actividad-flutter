import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../db/db_proyecto.dart';
import '../models/model.dart';

class NoteModifyScreen extends StatefulWidget {
  //const NoteModifyScreen({Key? key}) : super(key: key);
  final String userID;
  const NoteModifyScreen({super.key, required this.userID});

  @override
  State<NoteModifyScreen> createState() => _NoteModifyScreenState();
}

class _NoteModifyScreenState extends State<NoteModifyScreen> {
  // ignore: unnecessary_null_comparison
  bool get isEditing => widget.userID != null;
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
          title: Text(isEditing == null
              ? 'Creacion de Usuario'
              : 'Actualizar Usuario')),
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
            Container(height: 16),
            SizedBox(
                width: double.infinity,
                height: 35,
                child: ElevatedButton(
                  onPressed: () {
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
                    Navigator.of(context).pop();
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
