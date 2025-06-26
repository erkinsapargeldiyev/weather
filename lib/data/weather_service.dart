import 'package:dio/dio.dart';
import 'package:weatherapp/data/data.dart'; // API_KEY bu ýerde saklanýar
import 'package:weatherapp/model/forecast.dart';

class WeatherService {
  static Future<Forecast> fetchForecast(double lat, double lon) async {
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
          'lang': 'tm',
        },
      );

      if (response.statusCode == 200) {
        final forecast = Forecast.fromJson(response.data);

        // Debug üçin görkezmek
        print('Şäher: ${forecast.city.name}');
        for (var item in forecast.list) {
          print('⏰ Sene: ${item.dtTxt}');
          print('🌡️ Temp: ${item.main.temp}°C');
          print('☁️ Howa: ${item.weather.first.description}');
          print('💨 Şemal: ${item.wind.speed} m/s');
          print('------------------------');
        }

        print('<<<<<<<<<<<<<<<<<<<<<${forecast.message}');
        print('<<<<<<<<<<<<<<<<<<<<<${forecast.code}');

        return forecast;
      } else {
        throw Exception('Sorag şowsuz: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('DioException (baglanyşyk ýalňyşlygy): ${e.message}');
      throw Exception('API bilen baglanyşyk edip bolmady: ${e.message}');
    } catch (e) {
      print('Beýlekiler: $e');
      throw Exception('Maglumat almak mümkün bolmady: $e');
    }
  }
}
