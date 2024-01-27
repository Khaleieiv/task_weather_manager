import 'dart:convert';
import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;
import 'package:task_weather_manager/weather/domain/entities/weather_data.dart';
import 'package:task_weather_manager/weather/domain/repositories/weather_repository.dart';

class WeatherRepositories extends WeatherRepository {
  @override
  Future<WeatherData> getWeather() async {
    const apiKey = "7431c89360eb0206fb82aaf8e7d6aba7";
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final url = Uri.https(
      "api.openweathermap.org",
      "/data/2.5/weather",
      {
        "lat": position.latitude.toString(),
        "lon": position.longitude.toString(),
        "appid": apiKey,
      },
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          json.decode(response.body) as Map<String, dynamic>;
      return WeatherData.fromJson(data);
    } else {
      throw Exception("Failed to get weather");
    }
  }
}
