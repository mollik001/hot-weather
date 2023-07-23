import 'package:flutter/material.dart';
import 'package:hot_weather/service/api_service.dart';

void main() {
  runApp(const MyAppWeather());
}

class MyAppWeather extends StatelessWidget {
  const MyAppWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WeatherScreenPage(),
    );
  }
}

class WeatherScreenPage extends StatefulWidget {
  const WeatherScreenPage({Key? key}) : super(key: key);

  @override
  _WeatherScreenPageState createState() => _WeatherScreenPageState();
}

class _WeatherScreenPageState extends State<WeatherScreenPage> {
  String temperature = '';
  String weatherCondition = '';
  String Lkey = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    Map<String, String> weatherData =
        await ApiService.fetchWeatherDataFromApi(_searchController);
    setState(() {
      temperature = weatherData['temperature']!;
      weatherCondition = weatherData['weatherCondition']!;
    });
  }

  String _getWeatherIcon(String weatherCondition) {
    switch (weatherCondition) {
      case 'Sunny':
        return 'lib/icons/sunny.png';
      case 'Cloudy':
        return 'lib/icons/cloudy.png';
      case 'Partly Cloudy':
        return 'lib/icons/partly-cloudy.png';
      case 'Rainy':
        return 'lib/icons/rainy.png';
      case 'Snowy':
        return 'lib/icons/snowy.png';
      case 'Thunderstorm':
        return 'lib/icons/thunderstorm.png';
      case 'Foggy':
        return 'lib/icons/foggy.png';
      case 'Windy':
        return 'lib/icons/windy.png';
      case 'Hazy':
        return 'lib/icons/hazy.png';
      default:
        return 'lib/icons/weather.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sunny or NOT'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Current Weather',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            weatherCondition.isNotEmpty
                ? Image.asset(
                    _getWeatherIcon(weatherCondition),
                    width: 80,
                    height: 80,
                    color: Color.fromARGB(255, 30, 105, 167),
                  )
                : SizedBox.shrink(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.thermostat,
                  size: 60,
                ),
                Text(
                  '$temperature°C',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              weatherCondition,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search City',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                fetchWeatherData();
              },
              child: const Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
