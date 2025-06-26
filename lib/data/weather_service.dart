import 'package:dio/dio.dart';
import 'package:weatherapp/data/data.dart'; // API_KEY bu ýerde saklanýar
import 'package:weatherapp/model/forecast.dart';

class WeatherService {
  static Future<List<ForecastItem>> fetchForecast(
    double lat,
    double lon,
  ) async {
    final dio = Dio();

    try {
      final response = await dio.get(
        'https://api.openweathermap.org/data/2.5/forecast',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': API_KEY,
          'units': 'metric',
          'lang': 'tm',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Sorag şowsuz: ${response.statusCode}');
      }

      final forecast = Forecast.fromJson(response.data);

      // Debug üçin çap etmek (islege bagly)
      for (var item in forecast.list) {
        print('Sene: ${item.dtTxt}');
        print('Temperatura: ${item.main.temp}°C');
        print('Howa: ${item.weather.first.description}');
        print('Şemal: ${item.wind.speed} m/s');
        print('----------------------');
      }

      return forecast.list;
    } catch (e) {
      print('WeatherService fetch error: $e');
      throw Exception('Maglumat almak mümkün bolmady: $e');
    }
  }
}
