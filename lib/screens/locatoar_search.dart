import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/bloc/weather_bloc/weather_bloc.dart';
import 'package:weatherapp/data/location_service.dart';
import 'package:weatherapp/screens/weather_page.dart';

class LocatoarSearch extends StatefulWidget {
  const LocatoarSearch({super.key});

  @override
  State<LocatoarSearch> createState() => _LocatoarSearchState();
}

class _LocatoarSearchState extends State<LocatoarSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,

      body: Stack(
        children: [
          _buildBackground(),
          FutureBuilder<Position>(
            future: LocationService.determinePosition(),
            builder: (context, snap) {
              if (snap.hasError) {
                return _buildCenteredText(
                  'Internediňiziň we GPS - iňiziň açykdygyny barlaň',
                  isError: true,
                );
              } else if (snap.hasData) {
                return FutureBuilder<String>(
                  future: LocationService.getCityNameFromPosition(snap.data!),
                  builder: (context, citySnap) {
                    if (citySnap.hasError) {
                      return _buildCenteredText(
                        'Lokasiýa tapylmady',
                        isError: false,
                      );
                    } else if (citySnap.hasData) {
                      return BlocProvider(
                        create:
                            (_) => WeatherBloc()..add(FetchWeather(snap.data!)),
                        child: WeatherPage(location: citySnap.data!),
                      );
                    } else {
                      return _buildCenteredText('Lokasiýa gözlenýär...');
                    }
                  },
                );
              } else {
                return _buildCenteredText('Lokasiýa gözlenýär...');
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCenteredText(String message, {bool isError = false}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          if (!isError) const CircularProgressIndicator(color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Stack(
      children: [
        Align(
          alignment: const AlignmentDirectional(3, -0.3),
          child: Container(
            height: 300,
            width: 300,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.deepPurple,
            ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(-3, -0.3),
          child: Container(
            height: 300,
            width: 300,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.deepPurple,
            ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(1, -1.2),
          child: Container(
            height: 300,
            width: 300,
            decoration: const BoxDecoration(color: Color(0xffFFAB40)),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: Container(color: Colors.transparent),
        ),
      ],
    );
  }
}
