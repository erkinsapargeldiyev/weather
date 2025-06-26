import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/data/data.dart';

class LocationService {
  static Future<Position> determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return Future.error('Location services disabled.');
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied)
        return Future.error('Location permissions denied');
    }
    if (permission == LocationPermission.deniedForever)
      return Future.error('Permissions denied permanently');
    return await Geolocator.getCurrentPosition();
  }

  static Future<String> getCityNameFromPosition(Position position) async {
    try {
      final response = await Dio().get(
        'http://api.openweathermap.org/geo/1.0/reverse',
        queryParameters: {
          'lat': position.latitude,
          'lon': position.longitude,
          'limit': 1,
          'appid': API_KEY,
        },
      );

      if (response.data != null && response.data.isNotEmpty) {
        return response.data[0]['name'] ?? 'Ýerleşýän ýeriňiz';
      }
      return 'Ýerleşýän ýeriňiz';
    } catch (e) {
      print('OpenWeatherMap Geocoding error: $e');
      return '${position.latitude.toStringAsFixed(2)}, ${position.longitude.toStringAsFixed(2)}';
    }
  }
}
