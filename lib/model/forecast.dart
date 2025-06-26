class Forecast {
  final String code;
  final int message;
  final int cnt;
  final List<ForecastItem> list;
  final City city;

  Forecast({
    required this.code,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      code: json['cod'] as String,
      message: json['message'] as int,
      cnt: json['cnt'] as int,
      list:
          (json['list'] as List).map((e) => ForecastItem.fromJson(e)).toList(),
      city: City.fromJson(json['city']),
    );
  }
}

class ForecastItem {
  final int dt;
  final MainInfo main;
  final List<Weather> weather;
  final Clouds clouds;
  final Wind wind;
  final int visibility;
  final double pop;
  final Sys sys;
  final String dtTxt;

  ForecastItem({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
  });

  factory ForecastItem.fromJson(Map<String, dynamic> json) {
    return ForecastItem(
      dt: json['dt'] as int,
      main: MainInfo.fromJson(json['main']),
      weather:
          (json['weather'] as List).map((e) => Weather.fromJson(e)).toList(),
      clouds: Clouds.fromJson(json['clouds']),
      wind: Wind.fromJson(json['wind']),
      visibility: json['visibility'] as int,
      pop: (json['pop'] as num).toDouble(),
      sys: Sys.fromJson(json['sys']),
      dtTxt: json['dt_txt'] as String,
    );
  }

  DateTime get dateTime => DateTime.parse(dtTxt);
}

class MainInfo {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int seaLevel;
  final int grndLevel;
  final int humidity;
  final double tempKf;

  MainInfo({
    required this.temp,
    required this.feelsLike, //temperatura
    required this.tempMin, //temperatura  max
    required this.tempMax, //temperatura  min
    required this.pressure, // Atmosfera basysy
    required this.seaLevel, // Deniz derejesindaki basys
    required this.grndLevel, // Deniz derejisnaki basys
    required this.humidity, //cyglylyk
    required this.tempKf, //Temperatura korreksiýasy
  });

  factory MainInfo.fromJson(Map<String, dynamic> json) {
    return MainInfo(
      temp: (json['temp'] as num).toDouble(),
      feelsLike: (json['feels_like'] as num).toDouble(),
      tempMin: (json['temp_min'] as num).toDouble(),
      tempMax: (json['temp_max'] as num).toDouble(),
      pressure: json['pressure'] as int,
      seaLevel: json['sea_level'] as int,
      grndLevel: json['grnd_level'] as int,
      humidity: json['humidity'] as int,
      tempKf: (json['temp_kf'] as num).toDouble(),
    );
  }
}

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'] as int,
      main: json['main'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );
  }
}

class Clouds {
  final int all; // gok yuzi nace goterim bulut

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(all: json['all'] as int);
  }
}

class Wind {
  final double speed; //semal ugry
  final int deg; //semal tizligi
  final double gust; // Semalym dowumi

  Wind({required this.speed, required this.deg, required this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: (json['speed'] as num).toDouble(),
      deg: json['deg'] as int,
      gust: (json['gust'] as num).toDouble(),
    );
  }
}

class Sys {
  final String pod; // Gunin wagt bolgi

  Sys({required this.pod});

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(pod: json['pod'] as String);
  }
}

class City {
  final int id;
  final String name;
  final Coord coord;
  final String country;
  final int population;
  final int timezone;
  final int sunrise;
  final int sunset;

  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] as int,
      name: json['name'] as String,
      coord: Coord.fromJson(json['coord']),
      country: json['country'] as String,
      population: json['population'] as int,
      timezone: json['timezone'] as int,
      sunrise: json['sunrise'] as int,
      sunset: json['sunset'] as int,
    );
  }
}

class Coord {
  final double lat;
  final double lon;

  Coord({required this.lat, required this.lon});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
    );
  }
}
