part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final List<ForecastItem> forecast;

  const WeatherLoaded(this.forecast);

  @override
  List<Object?> get props => [forecast];
}

class WeatherError extends WeatherState {}
