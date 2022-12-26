import 'package:actividad/models/model.dart';
import 'package:actividad/views/other_pages/join_list.dart';
import 'package:actividad/views/other_pages/movies_list.dart';
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
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: const [
          NoteListScreen(),
          MoviesListScreen(),
          JoinListScreen()
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.blueAccent,
        child: TabBar(
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
    );
  }
}
