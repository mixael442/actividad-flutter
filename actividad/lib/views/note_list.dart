import 'package:actividad/views/note_search.dart';
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

class _NoteListScreenState extends State<NoteListScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  List<Usuarios> users = [];
  @override
  void initState() {
    cargarUsuarios();
    super.initState();
    controller = TabController(length: 3, vsync: this);
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
                  showSearch(context: context, delegate: SearchScreen(users));
                },
                icon: const Icon(Icons.search))
          ],
          bottom: TabBar(
            tabs: const [
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.videocam),
              ),
              Tab(
                icon: Icon(Icons.join_inner_rounded),
              ),
            ],
            controller: controller,
          ),
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
                  setState(() {
                    DBUser().deleteUsuarios(users[i].id!);
                    users.remove(users[i]);
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
