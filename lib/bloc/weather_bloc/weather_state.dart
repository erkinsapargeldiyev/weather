// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Forecast forecast;

  const WeatherLoaded(this.forecast);

  @override
  List<Object?> get props => [];
}

class WeatherError extends WeatherState {
  final String errorMessage;
  const WeatherError({required this.errorMessage});
}
