import 'package:flutter/material.dart';
import 'package:task_weather_manager/weather/domain/entities/weather_data.dart';

/// WeatherDisplayPage is a StatelessWidget that displays weather information.
class WeatherDisplayPage extends StatelessWidget {
  // Weather data to be displayed on the page.
  final WeatherData weatherData;

  // Constructor to initialize the WeatherDisplayPage with weatherData.
  const WeatherDisplayPage({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Container styling with padding and decoration.
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(15),
      ),
      // Column to organize weather information vertically.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display temperature with styling.
          Text(
            'Temperature: ${weatherData.temperature}°F',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          // Display weather condition with styling.
          Text(
            'Weather Condition: ${weatherData.weatherCondition}',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          // Display humidity with styling using an icon.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.water_drop, color: Colors.white),
              const SizedBox(width: 5),
              Text(
                'Humidity: ${weatherData.humidity}%',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Display wind speed with styling using an icon.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.air, color: Colors.white),
              const SizedBox(width: 5),
              Text(
                'Wind Speed: ${weatherData.wind.speed} m/s',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Display wind direction with styling using an icon.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.arrow_forward, color: Colors.white),
              const SizedBox(width: 5),
              Text(
                'Wind Direction: ${weatherData.wind.direction}°',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
