import 'dart:convert';
import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;
import 'package:task_weather_manager/weather/domain/entities/weather_data.dart';
import 'package:task_weather_manager/weather/domain/repositories/weather_repository.dart';

// WeatherRepositories is a concrete implementation of WeatherRepository
// that retrieves weather data using the OpenWeatherMap API and the package.
class WeatherRepositories extends WeatherRepository {
  // API key for accessing the OpenWeatherMap API.
  static const apiKey = "7431c89360eb0206fb82aaf8e7d6aba7";

  // Override method to get the current weather based on the device's location.
  @override
  Future<WeatherData> getWeather() async {
    // Get the current device's location using Geolocator.
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Construct the URL for the OpenWeatherMap API with latitude,
    // longitude, and API key.
    final url = Uri.https(
      "api.openweathermap.org",
      "/data/2.5/weather",
      {
        "lat": position.latitude.toString(),
        "lon": position.longitude.toString(),
        "appid": apiKey,
      },
    );

    // Make an HTTP GET request to the OpenWeatherMap API.
    final response = await http.get(url);

    // Check if the response status code is 200 (OK).
    if (response.statusCode == 200) {
      // Decode the JSON response and convert it to a Map.
      final Map<String, dynamic> data =
      json.decode(response.body) as Map<String, dynamic>;

      // Convert the Map to a WeatherData object using the fromJson constructor.
      return WeatherData.fromJson(data);
    } else {
      // If the response status code is not 200, throw an exception.
      throw Exception("Failed to get weather");
    }
  }
}
