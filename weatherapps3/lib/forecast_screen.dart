import 'package:flutter/material.dart';
import 'forecast_service.dart';

class ForecastScreen extends StatefulWidget {
  final String city;

  ForecastScreen({required this.city});

  @override
  _ForecastScreenState createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  final ForecastService _forecastService = ForecastService();
  Map<String, List<dynamic>>? _groupedForecastData;

  @override
  void initState() {
    super.initState();
    _fetchForecast();
  }

  Future<void> _fetchForecast() async {
    try {
      final data = await _forecastService.fetchForecast(widget.city);
      setState(() {
        _groupedForecastData = _groupByDays(data);
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Map<String, List<dynamic>> _groupByDays(List<dynamic> forecastList) {
    Map<String, List<dynamic>> groupedData = {};
    for (var forecast in forecastList) {
      DateTime dateTime = DateTime.parse(forecast['dt_txt']);
      String day = '${dateTime.year}-${dateTime.month}-${dateTime.day}';
      if (!groupedData.containsKey(day)) {
        groupedData[day] = [];
      }
      groupedData[day]!.add(forecast);
    }
    return groupedData;
  }

  String _getWeatherIcon(String description) {
    switch (description) {
      case 'clear sky':
        return 'assets/clear-sky.png';
      case 'few clouds':
        return 'assets/cloud.png';
      case 'scattered clouds':
        return 'assets/cloud.png';
      case 'broken clouds':
        return 'assets/cloud.png';
      case 'shower rain':
        return 'assets/showerain.png';
      case 'rain':
        return 'assets/rain.png';
      case 'thunderstorm':
        return 'assets/storm.png';
      case 'snow':
        return 'assets/snow.png';
      case 'mist':
        return 'assets/mist.png';
      default:
        return 'assets/sun.png';
    }
  }

  String _getDayOfWeek(DateTime dateTime) {
    List<String> days = [
      'Pazar',
      'Pazartesi',
      'Salı',
      'Çarşamba',
      'Perşembe',
      'Cuma',
      'Cumartesi'
    ];
    return days[dateTime.weekday % 7];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.city} - 5 Günlük Hava Durumu'),
      ),
      body: _groupedForecastData == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: _groupedForecastData!.keys.length,
                itemBuilder: (context, index) {
                  String day = _groupedForecastData!.keys.elementAt(index);
                  List<dynamic> forecasts = _groupedForecastData![day]!;
                  DateTime dateTime = DateTime.parse(forecasts[0]['dt_txt']);
                  String dayOfWeek = _getDayOfWeek(dateTime);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$dayOfWeek, ${dateTime.day}/${dateTime.month}/${dateTime.year}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 190,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: forecasts.length,
                          itemBuilder: (context, index) {
                            var forecast = forecasts[index];
                            DateTime forecastTime =
                                DateTime.parse(forecast['dt_txt']);
                            String time = '${forecastTime.hour}:00';
                            double temperature = forecast['main']['temp'];
                            String description =
                                forecast['weather'][0]['description'];
                            return Container(
                              width: 120,
                              child: Card(
                                elevation: 15,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        time,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(height: 8),
                                      Image.asset(
                                        _getWeatherIcon(description),
                                        height: 40,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '${temperature}°C',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        description,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  );
                },
              ),
            ),
    );
  }
}
