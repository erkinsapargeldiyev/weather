import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/data/weather_service.dart';
import 'package:weatherapp/model/forecast.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>(_onFetch);
  }

  Future<void> _onFetch(FetchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());

    try {
      final forecastList = await WeatherService.fetchForecast(
        event.position.latitude,
        event.position.longitude,
      );

      emit(WeatherLoaded(forecastList));
    } catch (e) {
      print('Bloc error: $e');
      emit(WeatherError(errorMessage: 'Ýalňyşlyk: $e'));
    }
  }
}
