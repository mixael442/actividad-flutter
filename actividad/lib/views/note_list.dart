import 'package:actividad/views/note_search.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import '../db/db_proyecto.dart';
import '../models/model.dart';
import 'note_modify.dart';
import 'note_update.dart';

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
