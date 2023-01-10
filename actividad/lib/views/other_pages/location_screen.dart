import 'package:actividad/models/model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../db/db_proyecto.dart';
import '../user_list.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  DBUser? dbUsers;
  @override
  void initState() {
    super.initState();
    dbUsers = DBUser();
  }

  String mensaje = 'Current Location of the user';
  String lat = '';
  String long = '';
  Future<void> openMap(String lat, String long) async {
    String googleURL =
        'https://www.google.com.ar/maps/search/?api=1&query=$lat,$long';
    await canLaunchUrlString(googleURL)
        ? await launchUrlString(googleURL)
        : throw 'Could not launch $googleURL';
  }

  /*localizacion() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.altitude.toString();

      setState(() {
        mensaje = 'Latitud: $lat,  Longitud: $long';
      });
    });
  }*/

  Future obtenerLocalizacion() async {
    bool servidor = await Geolocator.isLocationServiceEnabled();
    if (!servidor) {
      return Future.error('Localizacion esta desactivado');
    }

    LocationPermission permiso = await Geolocator.checkPermission();
    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
      if (permiso == LocationPermission.denied) {
        return Future.error('Permiso denegado');
      }
    }

    if (permiso == LocationPermission.deniedForever) {
      return Future.error('Permiso permanentemente denegado');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawer(),
      appBar: AppBar(title: const Text('Tu ubicacion')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(mensaje),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                obtenerLocalizacion().then((value) {
                  lat = '${value.latitude}';
                  long = '${value.longitude}';

                  setState(() {
                    mensaje = 'Latitude: $lat, Longitude $long';
                  });
                  //localizacion();
                  if (lat != null && long != null) {
                    dbUsers!
                        .insertLocalizacion(Localizacion(lat: lat, long: long));
                  }
                });
              },
              child: const Text('Tu Localizacion'),
            ),
            ElevatedButton(
                onPressed: () {
                  openMap(lat, long);
                },
                child: const Text('Observar ubicacion'))
          ],
        ),
      ),
    );
  }
}
