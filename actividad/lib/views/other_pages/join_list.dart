import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../db/db_proyecto.dart';
import '../../models/model.dart';

class JoinListScreen extends StatefulWidget {
  const JoinListScreen({Key? key}) : super(key: key);

  @override
  State<JoinListScreen> createState() => _JoinListScreenState();
}

class _JoinListScreenState extends State<JoinListScreen> {
  List<Usuarios> users = [];
  DBUser? dbUsers;
  @override
  void initState() {
    cargarUsuarios();
    super.initState();
    dbUsers = DBUser();
  }

  Future cargarUsuarios() async {
    List<Usuarios> usersP = await DBUser().getUsuarios();
    setState(() {
      users = usersP;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Usuarios y sus Peliculas'),
        ),
        body: Scrollbar(
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: dbUsers!.getUsuariosYPeliculas(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final Map<String, dynamic> usuario = snapshot.data![index];
                    return ListTile(
                      title: Text(
                          'usuario: ${usuario['nombre']},   Pelicula favorita: ${usuario['pelicula']}',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor)),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }
}
