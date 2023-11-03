import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather Info App'),
        ),
        body: WeatherList(),
      ),
    );
  }
}

class WeatherList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: weatherData.length,
      itemBuilder: (context, index) {
        return WeatherCard(data: weatherData[index]);
      },
    );
  }
}

class WeatherCard extends StatelessWidget {
  final Map<String, dynamic> data;

  WeatherCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        title: Text(data['city']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Temperature: ${data['temperature']}°C'),
            Text('Condition: ${data['condition']}'),
            Text('Humidity: ${data['humidity']}%'),
            Text('Wind Speed: ${data['windSpeed']} km/h'),
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> weatherData = [
  {
    "city": "New York",
    "temperature": 20,
    "condition": "Clear",
    "humidity": 60,
    "windSpeed": 5.5,
  },
  {
    "city": "Los Angeles",
    "temperature": 25,
    "condition": "Sunny",
    "humidity": 50,
    "windSpeed": 6.8,
  },
  {
    "city": "London",
    "temperature": 15,
    "condition": "Partly Cloudy",
    "humidity": 70,
    "windSpeed": 4.2,
  },
  {
    "city": "Tokyo",
    "temperature": 28,
    "condition": "Rainy",
    "humidity": 75,
    "windSpeed": 8.0,
  },
  {
    "city": "Sydney",
    "temperature": 22,
    "condition": "Cloudy",
    "humidity": 55,
    "windSpeed": 7.3,
  }
];
