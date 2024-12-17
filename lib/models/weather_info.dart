class WeatherInfo {
  final double temperature;
  final double feelsLike;
  final String description;

  WeatherInfo({
    required this.temperature,
    required this.feelsLike,
    required this.description,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      temperature: json['main']['temp'],
      feelsLike: json['main']['feels_like'],
      description: json['weather'][0]['description'],
    );
  }
}
