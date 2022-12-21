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
          title: const Text('Usuarios'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const NoteModifyScreen()));
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
                    users[i].nombre,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  subtitle: Text('Nacido en ${users[i].fechaNacimiento} '),
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
