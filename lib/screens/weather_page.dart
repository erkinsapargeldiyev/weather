import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/bloc/weather_bloc/weather_bloc.dart';
import 'package:weatherapp/model/forecast.dart';
import 'package:weatherapp/screens/locatoar_search.dart';

class WeatherPage extends StatelessWidget {
  final String location;

  const WeatherPage({super.key, required this.location});

  Widget getWeatherIcon(int code) {
    if (code >= 200 && code < 300) {
      return Image.asset('assets/1.png', height: 50, fit: BoxFit.cover);
    }
    if (code >= 300 && code < 400) {
      return Image.asset('assets/2.png', height: 50, fit: BoxFit.cover);
    }
    if (code >= 500 && code < 600) {
      return Image.asset('assets/3.png', height: 50, fit: BoxFit.cover);
    }
    if (code >= 600 && code < 700) {
      return Image.asset('assets/4.png', height: 50, fit: BoxFit.cover);
    }
    if (code >= 700 && code < 800) {
      return Image.asset('assets/5.png', height: 50, fit: BoxFit.cover);
    }
    if (code == 800) return Image.asset('assets/6.png');
    if (code > 800 && code <= 804) {
      return Image.asset('assets/7.png', height: 50, fit: BoxFit.cover);
    }
    return Image.asset('assets/7.png');
  }

  Map<String, List<ForecastItem>> groupForecastByDay(List<ForecastItem> items) {
    Map<String, List<ForecastItem>> grouped = {};

    for (var item in items) {
      String dayKey = DateFormat('yyyy-MM-dd').format(item.dateTime);

      if (!grouped.containsKey(dayKey)) {
        grouped[dayKey] = [];
      }

      grouped[dayKey]!.add(item);
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Duran ýeriňiz: $location',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
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
                  final groupedData = groupForecastByDay(state.forecast.list);

                  int sunriseTimeTamp = state.forecast.city.sunrise;
                  DateTime sunriseTime = DateTime.fromMicrosecondsSinceEpoch(
                    sunriseTimeTamp,
                  );
                  String formattedSunrise = DateFormat.jm().format(sunriseTime);
                  int sunsetTimeTamp = state.forecast.city.sunset;
                  DateTime sunsetTime = DateTime.fromMicrosecondsSinceEpoch(
                    sunsetTimeTamp,
                  );
                  String formattedsunset = DateFormat.jm().format(sunriseTime);

                  return ListView(
                    children:
                        groupedData.entries.map((entry) {
                          final day = entry.key;
                          final items = entry.value;
                          final readableDay = DateFormat(
                            'EEEE, dd MMMM',
                          ).format(items.first.dateTime);

                          return Card(
                            color: Colors.white10,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '📅 $readableDay',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        ' ${state.forecast.city.name}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        ' ${state.forecast.city.country}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  ...items.map((item) {
                                    final main = item.main;
                                    final weather = item.weather.first;

                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '🕒 ${DateFormat('HH:mm').format(item.dateTime)}',
                                            style: const TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              // getWeatherIcon(weather.id),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      weather.description,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
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
                                                    Text(
                                                      '📊 Deňiz derejesindäki basyş (hPa): ${main.seaLevel} hPa',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      '📊 Ýer ýüzüniň derejesindäki basyş (hPa): ${main.grndLevel} hPa',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Temperatura korreksiýasy: ${main.tempKf} ',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      '👁️ Görüş aralygy: ${item.visibility / 1000} km',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Ýagyş ähtimallyg: ${item.pop} %',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Senäniň tekst görnüşindäki görnüşi: ${item.dtTxt} ',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Yurtda gunun dogyan wagty (seu): $formattedSunrise ',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Yurtda gunun yashyan wagty: $formattedsunset ',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Güniň wagt bölegi ("d" - gündiz, "n" - gije): ${item.sys.pod} ',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Şemalyň dowumy (m/s): ${item.wind.gust} ',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Bulutlylygyň göterimi: ${item.clouds.all} %',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Ikonka kody (grafiki alamatlar üçin): ${weather.icon}',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      'howa ID: ${weather.id}',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                  );
                } else if (state is WeatherError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.errorMessage,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LocatoarSearch(),
                              ),
                            );
                          },
                          child: Text('Täzeden synanşyň'),
                        ),
                      ],
                    ),
                  );
                }
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Lokasiya tapyldy, garaşyň...',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      CircularProgressIndicator(color: Colors.white),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
