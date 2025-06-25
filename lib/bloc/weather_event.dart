part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchWeather extends WeatherEvent {
  final Position position;
  FetchWeather(this.position);

  @override
  List<Object> get props => [position];
}
