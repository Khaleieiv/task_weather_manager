import 'package:flutter/material.dart';
import 'package:task_weather_manager/tasks/utils/custom_exception.dart';
import 'package:task_weather_manager/weather/data/repositories/weather_repositories.dart';
import 'package:task_weather_manager/weather/domain/entities/weather_data.dart';
import 'package:task_weather_manager/weather/presentation/pages/weather_display_page.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherData? _weatherData;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      final weatherRepository = WeatherRepositories();
      final weatherData = await weatherRepository.getWeather();
      setState(() {
        _weatherData = weatherData;
      });
    } catch (e) {
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
