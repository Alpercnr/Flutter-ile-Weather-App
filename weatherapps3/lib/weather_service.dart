import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey =
      'e20cf475559be69c03f5bc1f1a8ec294'; // OpenWeatherMap API anahtarınızı buraya ekleyin
  final String apiUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final response =
        await http.get(Uri.parse('$apiUrl?q=$city&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
