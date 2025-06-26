class Forecast {
  final String code; // Status kody (meselem, "200" gowy netijäni aňladýar)
  final int
  message; // Serwerden gelen goşmaça maglumat ýa-da kod (köplenç ulanylmaýar)
  final int cnt; // Prognosda görkezilen elementleriň sany (nesil sany)
  final List<ForecastItem>
  list; // Prognos sanawy — wagt boýunça üýtgeýän howa maglumatlary
  final City city; // Şäher barada maglumatlar

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
  final int dt; // UNIX wagty (sekundlarda, 1970-den başlap)
  final MainInfo main; // Esasy temperatura we atmosfera maglumatlary
  final List<Weather>
  weather; // Howanyň görnüşi (bölüm, ýagyn, ýagyrmaka we ş.m.)
  final Clouds clouds; // Bulutlylyk derejesi (% görnüşde)
  final Wind wind; // Şemal tizlik we ugry
  final int visibility; // Görnüşlik (metrlerde)
  final double
  pop; // Ýagyş ähtimallygy (probability of precipitation), 0.0-den 1.0 çenli
  final Sys sys; // Wagt bölümi (gündiz/gije)
  final String
  dtTxt; // Senäniň tekst görnüşindäki görnüşi (meselem "2025-06-27 15:00:00")

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

  DateTime get dateTime =>
      DateTime.parse(dtTxt); // dtTxt-den DateTime obýekti döreýär
}

class MainInfo {
  final double temp; // Asyl temperatura (°C)
  final double feelsLike; // Duýulýan temperatura (temperatura duýgusy)
  final double tempMin; // Minimum temperatura (°C)
  final double tempMax; // Maksimum temperatura (°C)
  final int pressure; // Atmosfera basyşy (hPa)
  final int seaLevel; // Deňiz derejesindäki basyş (hPa)
  final int grndLevel; // Ýer ýüzüniň derejesindäki basyş (hPa)
  final int humidity; // Çyglylyk (% görnüşde)
  final double tempKf; // Temperatura korreksiýasy (köplenç 0.0 bolup durýar)

  MainInfo({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
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
  final int id; // Howanyň kody (OpenWeatherMap kody)
  final String main; // Howanyň esasy görnüşi (meselem, "Rain", "Clear")
  final String description; // Howanyň doly düşündiriş (meselem, "light rain")
  final String icon; // Ikonka kody (grafiki alamatlar üçin)

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
  final int all; // Bulutlylygyň göterimi (% görnüşde)

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(all: json['all'] as int);
  }
}

class Wind {
  final double speed; // Şemal tizligi (m/s)
  final int deg; // Şemalyň ugrunyň burçy (derejede)
  final double gust; // Şemalym dowumy (m/s)

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
  final String pod; // Güniň wagt bölegi ("d" - gündiz, "n" - gije)

  Sys({required this.pod});

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(pod: json['pod'] as String);
  }
}

class City {
  final int id; // Şäheriň unikal ID belgisi
  final String name; // Şäheriň ady
  final Coord coord; // Şäheriň koordinatlary (lat, lon)
  final String country; // Ýurt belgisi (meselem "TM" Türkmenistan)
  final int population; // Adam sany (şäheriň ilaty)
  final int timezone; // UTC-den wagt zony tapawudy (sekundlarda)
  final int sunrise; // Gün çykýan wagty (UNIX sekundlarda, UTC)
  final int sunset; // Gün batan wagty (UNIX sekundlarda, UTC)

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
  final double lat; // Kengişlik (Latýtuda) koordinaty
  final double lon; // Uzynlyk (Longýtuda) koordinaty

  Coord({required this.lat, required this.lon});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
    );
  }
}
