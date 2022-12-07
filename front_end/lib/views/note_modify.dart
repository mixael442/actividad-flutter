import 'package:flutter/material.dart';

class NoteModifyScreen extends StatelessWidget {
  //const NoteModifyScreen({Key? key}) : super(key: key);
  final String userID;
  // ignore: unnecessary_null_comparison
  bool get isEditing => userID != null;

  const NoteModifyScreen({super.key, required this.userID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // ignore: unnecessary_null_comparison
          title: Text(isEditing == null
              ? 'Creacion de Usuario'
              : 'Actualizar Usuario')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(hintText: 'Note title'),
            ),
            Container(height: 8),
            const TextField(
              decoration: InputDecoration(hintText: 'Note content'),
            ),
            Container(height: 16),
            SizedBox(
                width: double.infinity,
                height: 35,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 20.0),
                    backgroundColor: Colors.deepPurpleAccent,
                    shape: const StadiumBorder(),
                  ),
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
