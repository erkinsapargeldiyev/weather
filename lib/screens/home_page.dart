import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/bloc/weather_bloc.dart';

class HomePage extends StatefulWidget {
  final String location;

  const HomePage({super.key, required this.location});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget getWeatherIcon(int code) {
    if (code >= 200 && code < 300)
      return Image.asset('assets/1.png', height: 50, fit: BoxFit.cover);
    if (code >= 300 && code < 400)
      return Image.asset('assets/2.png', height: 50, fit: BoxFit.cover);
    if (code >= 500 && code < 600)
      return Image.asset('assets/3.png', height: 50, fit: BoxFit.cover);
    if (code >= 600 && code < 700)
      return Image.asset('assets/4.png', height: 50, fit: BoxFit.cover);
    if (code >= 700 && code < 800)
      return Image.asset('assets/5.png', height: 50, fit: BoxFit.cover);
    if (code == 800) return Image.asset('assets/6.png');
    if (code > 800 && code <= 804)
      return Image.asset('assets/7.png', height: 50, fit: BoxFit.cover);
    return Image.asset('assets/7.png');
  }

  String getDayLabel(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now).inDays;

    return DateFormat('EEEE').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 1.2 * kToolbarHeight, 20, 0),
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional(3, -0.3),
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
              alignment: AlignmentDirectional(-3, -0.3),
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
              alignment: AlignmentDirectional(1, -1.2),
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
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '🎈 ${widget.location}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Good morning',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.forecast.length,
                          itemBuilder: (context, index) {
                            final item = state.forecast[index];
                            final main = item.main;
                            final weather = item.weather.first;

                            return Card(
                              color: Colors.white.withOpacity(0.1),
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            '${getDayLabel(item.dateTime)} - ${DateFormat('dd MMM yyyy HH:mm').format(item.dateTime)}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    getWeatherIcon(weather.id),
                                    const SizedBox(height: 8),
                                    Text(
                                      '🌤️ ${weather.description}',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '🌡️ Temperaturasy: ${main.temp}°C (duýulýan: ${main.feelsLike}°C)',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '🔻 Min: ${main.tempMin}°C | 🔺 Max: ${main.tempMax}°C',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '💧 Çyglylyk: ${main.humidity}%',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '🌬️ Şemal: ${item.wind.speed} m/s, ugry: ${item.wind.deg}°',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '📊 Basyş: ${main.pressure} hPa',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else if (state is WeatherError) {
                  return const Center(
                    child: Text(
                      'Internet baglanyşygy ýok',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
