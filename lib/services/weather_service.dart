import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_info.dart';

class WeatherService {
  final Dio _dio = Dio();

  final String apiKey = "90dbb8eb2d778c0bf83f5ac9231e0079";
  final String city = "Matugama";

  Future<WeatherInfo> fetchWeather() async {
    final String url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

    try {
      final response = await _dio.get(url);
      print("Response data: ${response.data}");

      return WeatherInfo.fromJson(response.data);
    } catch (e) {
      print("Error fetching weather data: $e");
      throw Exception("Failed to fetch weather data: $e");
    }
  }
}
