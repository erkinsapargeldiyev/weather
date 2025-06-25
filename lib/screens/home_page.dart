import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/bloc/weather_bloc.dart';
import 'package:weatherapp/widgets/row_custom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  Widget getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset('assets/1.png');
      case >= 300 && < 400:
        return Image.asset('assets/2.png');
      case >= 500 && < 600:
        return Image.asset('assets/3.png');
      case >= 600 && < 700:
        return Image.asset('assets/4.png');
      case >= 700 && < 800:
        return Image.asset('assets/5.png');
      case == 800:
        return Image.asset('assets/6.png');
      case > 800 && <= 804:
        return Image.asset('assets/7.png');

      default:
        return Image.asset('assets/7.png');
    }
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
        padding: EdgeInsets.fromLTRB(20, 1.2 * kToolbarHeight, 40, 0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
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
                  decoration: BoxDecoration(
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
                  decoration: BoxDecoration(color: Color(0xffFFAB40)),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                ),
              ),
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoaded) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '🎈 ${state.weather.areaName}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Good morning',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Center(
                            child: getWeatherIcon(
                              state.weather.weatherConditionCode!,
                            ),
                          ),
                          Center(
                            child: Text(
                              "${state.weather.temperature!.celsius!.round()}°C",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 55,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              state.weather.weatherMain!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Text(
                              DateFormat(
                                'EEEE dd * ',
                              ).add_jm().format(state.weather.date!),

                              style: TextStyle(
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          RowCustom(
                            imageAdress: 'assets/11.png',
                            day: 'Gün doguş',
                            time: DateFormat().add_jm().format(
                              state.weather.sunrise!,
                            ),
                            imageAdress2: 'assets/12.png',
                            time2: DateFormat(
                              'HH:mm',
                            ).format(state.weather.sunset!),
                            day2: 'Gün ýaşyş',
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Divider(color: Colors.grey),
                          ),

                          RowCustom(
                            imageAdress: 'assets/13.png',
                            day: 'Temp Max',
                            time:
                                '${state.weather.tempMax!.celsius!.round()}°C',
                            imageAdress2: 'assets/14.png',
                            time2:
                                '${state.weather.tempMin!.celsius!.round()}°C ',
                            day2: 'Temp Min',
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is WeatherError) {
                    Center(
                      child: Text(
                        'Yalnyslyk',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
