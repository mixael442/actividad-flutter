import 'dart:io';
import 'dart:typed_data';

import 'package:actividad/models/model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../db/db_proyecto.dart';
import '../user_list.dart';
import 'camera_list.dart';
import 'movies_list.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  DBUser? dbUsers;
  File? foto;
  Uint8List? bytes;
  final pick = ImagePicker();
  @override
  void initState() {
    super.initState();
    dbUsers = DBUser();
  }

  Future<dynamic> sacarFoto() async {
    var fotoCapturada = await pick.pickImage(source: ImageSource.camera);
    setState(() {
      foto = File(fotoCapturada!.path);
      bytes = foto!.readAsBytesSync();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavigationDrawer(),
        appBar:
            AppBar(backgroundColor: Colors.black, title: const Text('Camara')),
        body: Scaffold(
          appBar: AppBar(
              // ignore: unnecessary_null_comparison
              title: const Text('Creacion de Pelicula')),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                IconButton(
                    color: Colors.blueGrey,
                    onPressed: () {
                      sacarFoto();
                    },
                    icon: const Icon(Icons.camera_alt_outlined)),
                SizedBox(
                  height: 250,
                  child: foto == null
                      ? const Text('Sacar una fotografia')
                      : Image.file(foto!),
                ),
                SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: ElevatedButton(
                      onPressed: () {
                        if (foto != null) {
                          dbUsers?.insertFotos(Fotos(foto: bytes));
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (_) => const CameraListScreen()));
                        } else {
                          return;
                        }
                      },
                      child: const Text(
                        "Agregar",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
