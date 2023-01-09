import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:actividad/models/model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../db/db_proyecto.dart';

class MoviesModifyScreen extends StatefulWidget {
  const MoviesModifyScreen({Key? key}) : super(key: key);

  @override
  State<MoviesModifyScreen> createState() => _MoviesModifyScreenState();
}

class _MoviesModifyScreenState extends State<MoviesModifyScreen> {
  DBUser? dbUsers;
  File? imagen;
  Uint8List? bytes;
  final pick = ImagePicker();
  @override
  void initState() {
    super.initState();
    dbUsers = DBUser();
  }

  Future<dynamic> elegirImagen() async {
    var imagenElegida = await pick.pickImage(source: ImageSource.gallery);
    setState(() {
      imagen = File(imagenElegida!.path);
      bytes = imagen!.readAsBytesSync();
    });
  }

  TextEditingController pelicula = TextEditingController();
  TextEditingController recaudacion = TextEditingController();
  TextEditingController presupuesto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // ignore: unnecessary_null_comparison
          title: const Text('Creacion de Pelicula')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextFormField(
              controller: pelicula,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(hintText: 'Nombre de pelicula'),
            ),
            TextFormField(
              controller: recaudacion,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Recaudacion'),
            ),
            TextFormField(
              controller: presupuesto,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Presupuesto'),
            ),
            IconButton(
                color: Colors.blueGrey,
                onPressed: () {
                  elegirImagen();
                },
                icon: const Icon(Icons.image)),
            SizedBox(
              height: 250,
              child: imagen == null
                  ? const Text('No Selecciono Una Imagen')
                  : Image.file(imagen!),
            ),
            SizedBox(
                width: double.infinity,
                height: 35,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    dbUsers?.insertPeliculas(Peliculas(
                        pelicula: pelicula.text,
                        recaudacion: int.parse(recaudacion.text),
                        presupuesto: int.parse(presupuesto.text),
                        imagen: bytes));
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
