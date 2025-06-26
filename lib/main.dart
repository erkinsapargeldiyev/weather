import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'bloc/weather_bloc.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<Position>(
        future: _determinePosition(),
        builder: (context, snap) {
          if (snap.hasError) {
            print('${snap.error} <<<<<<< ${snap.data}');
            return Scaffold(
              body: Center(
                child: Text('Location not found Error: ${snap.error}'),
              ),
            );
          } else if (snap.hasData) {
            return FutureBuilder<String>(
              future: getCityNameFromPosition(snap.data!),
              builder: (context, citySnap) {
                if (citySnap.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text('Error getting city name: ${citySnap.error}'),
                    ),
                  );
                } else if (citySnap.hasData) {
                  return BlocProvider<WeatherBloc>(
                    create: (_) => WeatherBloc()..add(FetchWeather(snap.data!)),
                    child: HomePage(location: citySnap.data!),
                  );
                } else {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            );
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) return Future.error('Location services disabled.');
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied)
      return Future.error('Location permissions denied');
  }
  if (permission == LocationPermission.deniedForever)
    return Future.error('Permissions denied permanently');
  return await Geolocator.getCurrentPosition();
}

Future<String> getCityNameFromPosition(Position position) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      final Placemark place = placemarks.first;

      // locality (şäher ady) ýok bolsa beýleki meýdançalary barla
      String? city = place.locality;
      if (city == null || city.isEmpty) {
        city = place.subAdministrativeArea;
      }
      if (city == null || city.isEmpty) {
        city = place.administrativeArea;
      }
      if (city == null || city.isEmpty) {
        city = place.country;
      }
      if (city == null || city.isEmpty) {
        city = 'Unknown location';
      }

      return city;
    } else {
      return 'Unknown location';
    }
  } catch (e) {
    print('Reverse geocoding failed: $e');
    return 'Unknown location';
  }
}
