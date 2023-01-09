import 'package:actividad/views/other_pages/movies_list.dart';
import 'package:actividad/views/user_search.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../db/db_proyecto.dart';
import '../models/model.dart';
import 'other_pages/camera_list.dart';
import 'other_pages/camera_screen.dart';
import 'other_pages/join_list.dart';
import 'other_pages/location_screen.dart';
import 'user_create.dart';
import 'user_update.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({Key? key}) : super(key: key);

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  List<Usuarios> users = [];
  @override
  void initState() {
    cargarUsuarios();
    super.initState();
  }

  Future calcularEdad(Usuarios date) async {
    DateTime fecha = DateTime.parse(date.fechaNacimiento.toString());
    Duration calculado = DateTime.now().difference(fecha);
    double edad = calculado.inDays / 365;

    Flushbar(
      duration: const Duration(seconds: 3),
      message: 'La edad de ${date.nombre} es de ${edad.toInt()} años cumplidos',
      backgroundColor: Colors.black,
    ).show(context);
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
          title: const Center(child: Text('Usuarios')),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    users.sort(
                      (a, b) => a.sueldoMensual.compareTo(b.sueldoMensual),
                    );
                  });
                },
                icon: const Icon(Icons.keyboard_double_arrow_down_outlined)),
            IconButton(
                onPressed: () {
                  setState(() {
                    users.sort(
                      (a, b) => b.sueldoMensual.compareTo(a.sueldoMensual),
                    );
                  });
                },
                icon: const Icon(Icons.keyboard_double_arrow_up)),
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: SearchScreen(users));
                },
                icon: const Icon(Icons.search)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(
                    MaterialPageRoute(builder: (_) => const NoteModifyScreen()))
                .then((value) {
              setState(() {
                cargarUsuarios();
              });
            });
          },
          child: const Icon(Icons.add),
        ),
        drawer: NavigationDrawer(),
        body: Scrollbar(
          child: ListView.builder(
            itemBuilder: (context, i) {
              return Dismissible(
                key: Key(users[i].toString()),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {
                  DBUser().deleteUsuarios(users[i].id!);
                  setState(() {
                    users.remove(users[i]);
                    setState(() {
                      cargarUsuarios();
                    });
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
                    '${users[i].nombre}, ${users[i].apellido}',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  subtitle: Text(
                      'Nacido en ${users[i].fechaNacimiento.year}-${users[i].fechaNacimiento.month}-${users[i].fechaNacimiento.day} '),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            calcularEdad(users[i]);
                          },
                          child: Text('Edad')),
                      const SizedBox(
                        width: 3,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            int numero =
                                int.parse(users[i].sueldoMensual.toString()) *
                                    12;

                            Flushbar(
                              duration: Duration(seconds: 3),
                              message:
                                  'El sueldo anual de ${users[i].nombre} es de $numero',
                              backgroundColor: Colors.black,
                            ).show(context);
                          },
                          child: Text('Sueldo anual')),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (_) => NoteUpdateScreen(userID: users[i])))
                        .then((value) {
                      setState(() {
                        cargarUsuarios();
                      });
                    });
                    //Navigator.pushNamed(context, '/editar',
                    //arguments: users[i].id);
                  },
                ),
              );
            },
            itemCount: users.length,
          ),
        )
        // ignore: dead_code
        );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeader(context),
              buildMenu(context),
            ],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      );
  Widget buildMenu(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.man_sharp),
              title: const Text('Usuarios'),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const NoteListScreen())),
            ),
            ListTile(
              leading: const Icon(Icons.movie_creation_outlined),
              title: const Text('Peliculas'),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const MoviesListScreen())),
            ),
            ListTile(
              leading: const Icon(Icons.join_inner),
              title: const Text('Join'),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const JoinListScreen())),
            ),
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Camara'),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const CameraScreen())),
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Galeria'),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const CameraListScreen())),
            ),
            ListTile(
              leading: const Icon(Icons.location_on_outlined),
              title: const Text('Ubicacion'),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const LocationScreen())),
            ),
          ],
        ),
      );
}
