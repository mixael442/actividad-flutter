// ignore: unused_import
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/model.dart';

class DBUser {
  Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'proyecto1.db'),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE usuariost (id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT, apellido TEXT, dni INTEGER, fechanacimiento TEXT, sueldomensual INTEGER)");
    }, version: 11);
  }

  Future<dynamic> insert(Usuarios usuarios) async {
    Database database = await _openDB();
    return database.insert("usuariost", usuarios.toMap());
  }

  Future<List<Usuarios>> getUsuarios() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> queryResult =
        await database.query("usuariost");
    return queryResult.map((e) => Usuarios.fromMap(e)).toList();
  }

  getUsuarios1() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> queryResult =
        await database.query("usuariost");
    return List.generate(
        queryResult.length,
        (index) => Usuarios(
            nombre: queryResult[index]['nombre'],
            apellido: queryResult[index]['apellido'],
            dni: queryResult[index]['dni'],
            fechaNacimiento: queryResult[index]['fechanacimiento'],
            sueldoMensual: queryResult[index]['sueldomensual']));
  }
}
