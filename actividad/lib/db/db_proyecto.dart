// ignore: unused_import
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/model.dart';

class DBUser {
  DBUser();
  static final DBUser intance = DBUser._init();
  static Database? _database;
  DBUser._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('proyecto1.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
    await db.execute(
        "CREATE TABLE usuariost (id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT, apellido TEXT, dni INTEGER, fechanacimiento TEXT, sueldomensual INTEGER, peliculafavorita INTEGER, FOREIGN KEY (peliculafavorita) REFERENCES peliculast(id))");
    await db.execute(
        "CREATE TABLE peliculast (id INTEGER PRIMARY KEY AUTOINCREMENT, pelicula TEXT, presupuesto INTEGER, recaudacion INTEGER, imagen BLOB)");
    await db.execute(
        "CREATE TABLE camarat (id INTEGER PRIMARY KEY AUTOINCREMENT, foto BLOB)");
    await db.execute(
        "CREATE TABLE localizaciont (id INTEGER PRIMARY KEY AUTOINCREMENT, lat TEXT, long TEXT)");
  }

  final String query = """
    SELECT u.nombre, p.pelicula
    FROM usuariost u
    INNER JOIN peliculast p ON u.peliculafavorita = p.id
""";

  Future<List<Map<String, dynamic>>> getUsuariosYPeliculas() async {
    final Database? db = await _database;
    return db!.rawQuery(query);
  }

  insert(Usuarios usuarios) async {
    Database database = await intance.database;
    return database.insert("usuariost", usuarios.toMap());
  }

  Future<List<Usuarios>> getUsuarios() async {
    Database database = await intance.database;
    final List<Map<String, dynamic>> queryResult =
        await database.query("usuariost");
    return queryResult.map((e) => Usuarios.fromMap(e)).toList();
  }

  Future<int> deleteUsuarios(int id) async {
    var database = await intance.database;
    return await database.delete("usuariost", where: "id = ?", whereArgs: [id]);
  }

  Future<int> updateUsuarios(Usuarios user) async {
    var database = await intance.database;
    return await database.update("usuariost", user.toMap(),
        where: "id = ?", whereArgs: [user.id]);
  }

  //-------Metodos CRUD Peliculas-------//

  insertPeliculas(Peliculas peliculas) async {
    Database database = await intance.database;
    return database.insert("peliculast", peliculas.toMap());
  }

  Future<List<Peliculas>> getPeliculas() async {
    Database database = await intance.database;
    final List<Map<String, dynamic>> queryResult =
        await database.query("peliculast");
    return queryResult.map((e) => Peliculas.fromMap(e)).toList();
  }

  Future<int> deletePeliculas(int id) async {
    var database = await intance.database;
    return await database
        .delete("peliculast", where: "id = ?", whereArgs: [id]);
  }

  Future<int> updatePeliculas(Peliculas movie) async {
    var database = await intance.database;
    return await database.update("peliculast", movie.toMap(),
        where: "id = ?", whereArgs: [movie.id]);
  }

  insertFotos(Fotos fotos) async {
    Database database = await intance.database;
    return database.insert("camarat", fotos.toMap());
  }

  Future<List<Fotos>> getFotos() async {
    Database database = await intance.database;
    final List<Map<String, dynamic>> queryResult =
        await database.query("camarat");
    return queryResult.map((e) => Fotos.fromMap(e)).toList();
  }

  insertLocalizacion(Localizacion localizacion) async {
    Database database = await intance.database;
    return database.insert("localizaciont", localizacion.toMap());
  }
}
