import 'package:actividad/models/model.dart';
import 'package:flutter/material.dart';

import '../../db/db_proyecto.dart';

class MoviesUpdateScreen extends StatefulWidget {
  final Peliculas movieID;
  const MoviesUpdateScreen({Key? key, required this.movieID}) : super(key: key);

  @override
  State<MoviesUpdateScreen> createState() => _MoviesUpdateScreenState();
}

class _MoviesUpdateScreenState extends State<MoviesUpdateScreen> {
  TextEditingController _pelicula = TextEditingController();
  TextEditingController _recaudacion = TextEditingController();
  TextEditingController _presupuesto = TextEditingController();

  DBUser? dbUsers;
  @override
  void initState() {
    setState(() {
      _pelicula.text = widget.movieID.pelicula;
      _recaudacion.text = widget.movieID.recaudacion.toString();
      _presupuesto.text = widget.movieID.presupuesto.toString();
    });
    super.initState();
    dbUsers = DBUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextFormField(
              controller: _pelicula,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(hintText: 'Nombre de pelicula'),
            ),
            TextFormField(
              controller: _recaudacion,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Recaudacion'),
            ),
            TextFormField(
              controller: _presupuesto,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Presupuesto'),
            ),
            Container(height: 16),
            SizedBox(
                width: double.infinity,
                height: 35,
                child: ElevatedButton(
                  onPressed: () {
                    dbUsers
                        ?.updatePeliculas(Peliculas(
                            id: widget.movieID.id,
                            pelicula: _pelicula.text,
                            recaudacion: int.parse(_recaudacion.text),
                            presupuesto: int.parse(_presupuesto.text)))
                        .then((value) => print('editado exitosamente: $value'));
                    Navigator.pop(context);
                  },
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
