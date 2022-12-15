import 'package:flutter/material.dart';
import '../db/db_proyecto.dart';
import '../models/model.dart';
import 'note_delete.dart';
import 'note_modify.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({Key? key}) : super(key: key);

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usuarios')),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const NoteModifyScreen(
                    userID: '',
                  )));
        },
        child: const Icon(Icons.add),
      ),

      body: ListView.separated(
        separatorBuilder: (_, __) =>
            const Divider(height: 1, color: Colors.green),
        itemBuilder: (context, i) {
          return Dismissible(
            key: const ValueKey(null),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {},
            confirmDismiss: (direction) async {
              final result = await showDialog(
                  context: context, builder: (_) => const NoteDelete());
              return result;
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
                'dsdsdsd',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              subtitle: const Text('Last edited on '),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const NoteModifyScreen(
                          userID: '',
                        )));
              },
            ),
          );
        },
        itemCount: 4,
      ),
      // ignore: dead_code
    );
  }
}
