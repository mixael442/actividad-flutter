/*import 'package:actividad_emser/models/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpUsers {
  List<Usuarios> usuariosGet = [];
  Future<Usuarios?> getUsuarios() async {
    return await http
        .get(Uri.parse('http://127.0.0.1:8000/usuarios/'))
        .then((value) {
      if (value.statusCode == 200) {
        final response = Usuarios.fromJson(value.body);
        return response;
      }
      return null;
    });
  }
}*/

/*class HttpUsers {
  Future<dynamic> getJson(uri) async {
    http.Response response = await http.get(uri);
    return json.decode(response.body);
  }

  Future<Usuarios> getUsuario() {
    var uri = Uri.parse('http://127.0.0.1:8000/usuarios/');
    return getJson(uri).then((data) => Usuarios.fromMap(data));
  }
}*/
