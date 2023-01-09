import 'package:actividad/models/model.dart';
import 'package:flutter/material.dart';

class SearchScreen extends SearchDelegate<String> {
  final List<Usuarios> usuarios;
  List<Usuarios> _filter = [];
  SearchScreen(this.usuarios);
  //SearchScreen(this.usuarios);

  // ignore: empty_constructor_bodies
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, result(''));
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _filter = usuarios.where((usuario) {
      return usuario.nombre.toLowerCase().contains(query.trim().toLowerCase());
    }).toList();
    return ListView.builder(
      itemBuilder: (_, i) {
        return ListTile(
          title: Text(
            '${_filter[i].nombre}, ${_filter[i].apellido} ',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          subtitle: Text('Nacido en ${_filter[i].fechaNacimiento} '),
        );
      },
      itemCount: _filter.length,
    );
  }

  String result(String s) {
    return '';
  }
}
