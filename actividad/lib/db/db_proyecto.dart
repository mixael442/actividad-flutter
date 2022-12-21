// ignore: unused_import
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/model.dart';

class DBUser {
  Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), "proyecto1.db"),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE usuariost (id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT, apellido TEXT, dni INTEGER, fechanacimiento TEXT, sueldomensual INTEGER)");
    }, version: 12);
  }

  insert(Usuarios usuarios) async {
    Database database = await _openDB();
    return database.insert("usuariost", usuarios.toMap());
  }

  Future<List<Usuarios>> getUsuarios() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> queryResult =
        await database.query("usuariost");
    return queryResult.map((e) => Usuarios.fromMap(e)).toList();
  }

  Future<int> deleteUsuarios(int id) async {
    var database = await _openDB();
    return await database.delete("usuariost", where: "id = ?", whereArgs: [id]);
  }

  Future<int> deleteUsuarios1(Usuarios user) async {
    var database = await _openDB();
    return await database
        .delete("usuariost", where: "id = ?", whereArgs: [user.id]);
  }

  Future<int> updateUsuarios(Usuarios user) async {
    var database = await _openDB();
    return await database.update("usuariost", user.toMap(),
        where: "id = ?", whereArgs: [user.id]);
  }

  /*getUsuarios1() async {
    Database database = await _openDB();
    return await database.query("usuariost");
  }

  Future<List<Usuarios>> getUsuarios2() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> queryResult =
        await database.query("usuariost");
    return List.generate(
        queryResult.length,
        (index) => Usuarios(
            nombre: queryResult[index]["nombre"],
            apellido: queryResult[index]["apellido"],
            dni: queryResult[index]["dni"],
            fechaNacimiento: queryResult[index]["fechanacimiento"],
            sueldoMensual: queryResult[index]["sueldomensual"]));
  }*/

}
