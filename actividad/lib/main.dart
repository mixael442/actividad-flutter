import 'package:actividad/models/model.dart';
import 'package:actividad/views/note_list.dart';
import 'package:actividad/views/note_modify.dart';
import 'package:actividad/views/note_update.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NoteListScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('HomeScreen'),
      ),
    );
  }
}
