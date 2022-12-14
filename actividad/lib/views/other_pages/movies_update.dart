import 'dart:io';

import 'package:actividad/models/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../db/db_proyecto.dart';

class MoviesUpdateScreen extends StatefulWidget {
  final Peliculas movieID;
  const MoviesUpdateScreen({Key? key, required this.movieID}) : super(key: key);

  @override
  State<MoviesUpdateScreen> createState() => _MoviesUpdateScreenState();
}

class _MoviesUpdateScreenState extends State<MoviesUpdateScreen> {
  TextEditingController _pelicula = TextEditingController();
  TextEditingController _presupuesto = TextEditingController();
  TextEditingController _recaudacion = TextEditingController();

  DBUser? dbUsers;

  File? imagen;
  Uint8List? image;
  Uint8List? bytes;
  final pick = ImagePicker();

  Future<dynamic> elegirImagen() async {
    var imagenElegida = await pick.pickImage(source: ImageSource.gallery);
    setState(() {
      imagen = File(imagenElegida!.path);
      bytes = imagen!.readAsBytesSync();
    });
  }

  @override
  void initState() {
    setState(() {
      _pelicula.text = widget.movieID.pelicula;
      _presupuesto.text = widget.movieID.presupuesto.toString();
      _recaudacion.text = widget.movieID.recaudacion.toString();
      this.image = widget.movieID.imagen;
    });
    super.initState();
    dbUsers = DBUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextFormField(
              controller: _pelicula,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(hintText: 'Nombre de pelicula'),
            ),
            TextFormField(
              controller: _presupuesto,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Presupuesto'),
            ),
            TextFormField(
              controller: _recaudacion,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Recaudacion'),
            ),
            IconButton(
                color: Colors.blueGrey,
                onPressed: () {
                  image = null;
                  elegirImagen();
                },
                icon: const Icon(Icons.image)),
            SizedBox(
              height: 250,
              child: image != null
                  ? Image.memory(image!)
                  : imagen == null
                      ? const Text('No Selecciono Una Imagen')
                      : Image.file(imagen!),

              /*imagen == null
                  ? const Text('No Selecciono Una Imagen')
                  : Image.file(imagen!),*/
            ),
            Container(height: 16),
            SizedBox(
                width: double.infinity,
                height: 35,
                child: ElevatedButton(
                  onPressed: () {
                    dbUsers
                        ?.updatePeliculas(Peliculas(
                            id: widget.movieID.id,
                            pelicula: _pelicula.text,
                            recaudacion: int.parse(_recaudacion.text),
                            presupuesto: int.parse(_presupuesto.text),
                            imagen: bytes))
                        .then((value) => print('editado exitosamente: $value'));
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
    );
  }
}
