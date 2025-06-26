import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/bloc/weather_bloc.dart';
import 'package:weatherapp/data/location_service.dart';
import 'package:weatherapp/screens/locatoar_search.dart';
import 'package:weatherapp/screens/weather_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position>(
      future: LocationService.determinePosition(),
      builder: (context, snap) {
        if (snap.hasError) {
          print('${snap.error} <<<<<<< ${snap.data}');
          return LocatoarSearch(
            searchIndicator: false,
            title: 'GPS - iňiziň açykdygyny barlaň',
          );
        } else if (snap.hasData) {
          print('No locaion');
          return FutureBuilder<String>(
            future: LocationService.getCityNameFromPosition(snap.data!),
            builder: (context, citySnap) {
              if (citySnap.hasError) {
                return LocatoarSearch(
                  searchIndicator: false,
                  title: 'Lokasiya tapylmady',
                );
              } else if (citySnap.hasData) {
                print('<<<<<<<< <<<< ${snap.data}');
                return BlocProvider<WeatherBloc>(
                  create: (_) => WeatherBloc()..add(FetchWeather(snap.data!)),
                  child: WeatherPage(location: citySnap.data!),
                );
              } else {
                return LocatoarSearch(
                  searchIndicator: true,
                  title: 'Lokasiya tapylmday',
                );
              }
            },
          );
        } else {
          print('Location <<<< ${snap.data}');

          return LocatoarSearch(
            searchIndicator: true,
            title: 'Lokasiya gozlenilyar...',
          );
        }
      },
    );
  }
}
