import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
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
            return Scaffold(body: Center(child: Text('Error: ${snap.error}')));
          } else if (snap.hasData) {
            return BlocProvider<WeatherBloc>(
              create: (_) => WeatherBloc()..add(FetchWeather(snap.data!)),
              child: const HomePage(),
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

// Location helper (values same as original)
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
