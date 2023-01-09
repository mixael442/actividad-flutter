import 'package:flutter/material.dart';

import '../../db/db_proyecto.dart';
import '../../models/model.dart';
import '../user_list.dart';

class CameraListScreen extends StatefulWidget {
  const CameraListScreen({Key? key}) : super(key: key);

  @override
  State<CameraListScreen> createState() => _CameraListScreenState();
}

class _CameraListScreenState extends State<CameraListScreen> {
  List<Fotos> fotos = [];
  @override
  void initState() {
    super.initState();
    cargarFotos();
  }

  Future cargarFotos() async {
    List<Fotos> fotosP = await DBUser().getFotos();
    setState(() {
      fotos = fotosP;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        title: const Text('Galeria'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: GridView.builder(
            itemCount: fotos.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, i) {
              return Image(
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                  image: MemoryImage(fotos[i].foto!));
            }),
      ),
    );
  }
}
