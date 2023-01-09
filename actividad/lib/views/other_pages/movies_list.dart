import 'dart:convert';

import 'package:actividad/models/model.dart';
import 'package:flutter/material.dart';

import '../../db/db_proyecto.dart';
import '../user_list.dart';
import 'movies_create.dart';
import 'movies_update.dart';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({Key? key}) : super(key: key);

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  List<Peliculas> movies = [];
  @override
  void initState() {
    cargarPeliculas();
    super.initState();
  }

  Future cargarPeliculas() async {
    List<Peliculas> moviesP = await DBUser().getPeliculas();
    setState(() {
      movies = moviesP;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavigationDrawer(),
        appBar: AppBar(
          title: const Center(child: Text('Peliculas')),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (_) => const MoviesModifyScreen()))
                .then((value) {
              setState(() {
                cargarPeliculas();
              });
            });
          },
          child: const Icon(Icons.add),
        ),
        body: Scrollbar(
          child: ListView.builder(
            itemBuilder: (context, i) {
              return Dismissible(
                key: Key(movies[i].toString()),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {
                  DBUser().deletePeliculas(movies[i].id!);
                  setState(() {
                    movies.remove(movies[i]);
                    cargarPeliculas();
                  });
                },
                background: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.only(left: 16),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                ),
                child: ListTile(
                  title: Text(
                    movies[i].pelicula,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  subtitle: Text(' Presupuesto: ${movies[i].presupuesto} '),
                  leading: movies[i].imagen != null
                      ? Image(image: MemoryImage(movies[i].imagen!))
                      : null,
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (_) =>
                                MoviesUpdateScreen(movieID: movies[i])))
                        .then((value) {
                      setState(() {
                        cargarPeliculas();
                      });
                    });
                    //Navigator.pushNamed(context, '/editar',
                    //arguments: users[i].id);
                  },
                ),
              );
            },
            itemCount: movies.length,
          ),
        ));
  }
}
