import 'package:flutter/material.dart';
import 'package:task_weather_manager/tasks/utils/custom_exception.dart';
import 'package:task_weather_manager/weather/data/repositories/weather_repositories.dart';
import 'package:task_weather_manager/weather/domain/entities/weather_data.dart';
import 'package:task_weather_manager/weather/presentation/pages/weather_display_page.dart';

/// WeatherPage is a StatefulWidget that displays weather information.
class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

/// _WeatherPageState is the corresponding State class for WeatherPage.
class _WeatherPageState extends State<WeatherPage> {
  // Weather data retrieved from the API.
  WeatherData? _weatherData;

  @override
  void initState() {
    super.initState();
    // Fetch weather data when the widget is initialized.
    _fetchWeather();
  }

  /// _fetchWeather method retrieves weather data from the repository.
  Future<void> _fetchWeather() async {
    try {
      // Create an instance of WeatherRepositories.
      final weatherRepository = WeatherRepositories();
      // Retrieve weather data from the repository.
      final weatherData = await weatherRepository.getWeather();
      // Update the state with the retrieved weather data.
      setState(() {
        _weatherData = weatherData;
      });
    } catch (e) {
      // Handle exceptions that may occur during the weather data retrieval.
      CustomResponseException("Error fetching weather: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Center(
        child: _weatherData != null
            ? WeatherDisplayPage(weatherData: _weatherData!)
            : const CircularProgressIndicator(),
      ),
    );
  }
}
