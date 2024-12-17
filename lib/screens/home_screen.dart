import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/weather_info.dart';
import '../providers/weather_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool isLoading = false;

  Future<void> refreshWeather() async {
    setState(() {
      isLoading = true;
    });
    await ref.refresh(weatherProvider.future);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = ref.watch(weatherProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: weatherData.when(
        data: (weather) => DisplayWeather(
          weather: weather,
          onRefresh: refreshWeather,
          isLoading: isLoading,
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class DisplayWeather extends StatelessWidget {
  final WeatherInfo weather;
  final VoidCallback onRefresh;
  final bool isLoading;

  const DisplayWeather({
    super.key,
    required this.weather,
    required this.onRefresh,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Temperature: ${weather.temperature} °C"),
          Text("Feels Like: ${weather.feelsLike} °C"),
          const SizedBox(height: 20),
          isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
            onPressed: onRefresh,
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }
}
