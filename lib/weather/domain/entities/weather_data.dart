class WeatherData {
  final double temperature;
  final String weatherCondition;
  final int humidity;
  final Wind wind;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int seaLevel;
  final int groundLevel;
  final int visibility;
  final int sunrise;
  final int sunset;
  final String country;
  final int timezone;
  final int id;
  final String name;

  WeatherData({
    required this.temperature,
    required this.weatherCondition,
    required this.humidity,
    required this.wind,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.groundLevel,
    required this.visibility,
    required this.sunrise,
    required this.sunset,
    required this.country,
    required this.timezone,
    required this.id,
    required this.name,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temperature: (json['main']['temp'] as num).toDouble(),
      weatherCondition: json['weather'][0]['main'].toString(),
      humidity: json['main']['humidity'] as int,
      wind: Wind(
        speed: (json['wind']['speed'] as num).toDouble(),
        direction: (json['wind']['deg'] as num).toDouble(),
      ),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      tempMin: (json['main']['temp_min'] as num).toDouble(),
      tempMax: (json['main']['temp_max'] as num).toDouble(),
      pressure: json['main']['pressure'] as int,
      seaLevel: json['main']['sea_level'] as int,
      groundLevel: json['main']['grnd_level'] as int,
      visibility: json['visibility'] as int,
      sunrise: json['sys']['sunrise'] as int,
      sunset: json['sys']['sunset'] as int,
      country: json['sys']['country'].toString(),
      timezone: json['timezone'] as int,
      id: json['id'] as int,
      name: json['name'].toString(),
    );
  }
}

class Wind {
  final double speed;
  final double direction;

  Wind({
    required this.speed,
    required this.direction,
  });
}
