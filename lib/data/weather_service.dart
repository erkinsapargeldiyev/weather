import 'package:dio/dio.dart';
import 'package:weatherapp/data/data.dart'; // API_KEY bu ýerde saklanýar
import 'package:weatherapp/model/forecast.dart';

class WeatherService {
  static Future fetchForecast(double lat, double lon) async {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    try {
      final response = await dio.get(
        'https://api.openweathermap.org/data/2.5/forecast',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': API_KEY,
          'units': 'metric',
        },
      );
      final forecast = Forecast.fromJson(response.data);

      if (response.statusCode == 200) {
        // Debug üçin görkezmek
        print('Şäher: ${forecast.city.name}');
        for (var item in forecast.list) {
          print('🌡️ Tempture: ${item.main.temp}°C');
        }

        print('<<<<<<<<<<<<<<<<<<<<< Forecast code:${forecast.code}');

        return forecast;
      } else {
        print('<<<<<<<<<<<<<<<<<<<<<<<<<<Message:${forecast.message}');
        return forecast.message;
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      throw 'Maglumat alyp bolmady';
    }
  }
}
