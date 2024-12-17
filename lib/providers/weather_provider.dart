import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/weather_info.dart';
import '../services/weather_service.dart';


final weatherProvider = FutureProvider<WeatherInfo>((ref) async {
  final weatherService = WeatherService();
  return await weatherService.fetchWeather();
});
