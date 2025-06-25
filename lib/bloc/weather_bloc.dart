import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/data/data.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final wf = WeatherFactory(API_KEY, language: Language.ENGLISH);

  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>(_onFetch);
  }

  Future<void> _onFetch(FetchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weather = await wf.currentWeatherByLocation(
        event.position.latitude,
        event.position.longitude,
      );

      if (event.position.timestamp != null) {
        DateTime localTime = event.position.timestamp!.toLocal();
        print('Your time: $localTime');
      } else {
        print('No Timestamp');
      }
      print('Latitude: ${event.position.latitude}');
      print('Longitude: ${event.position.longitude}');
      print('Howanyň ýagdaýy: ${weather.weatherDescription}');
      emit(WeatherLoaded(weather));
    } catch (_) {
      emit(WeatherError());
    }
  }
}
