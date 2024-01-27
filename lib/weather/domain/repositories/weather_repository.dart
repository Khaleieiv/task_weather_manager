import 'package:task_weather_manager/weather/domain/entities/weather_data.dart';

abstract class WeatherRepository {
  const WeatherRepository();

  Future<WeatherData> getWeather();
}
