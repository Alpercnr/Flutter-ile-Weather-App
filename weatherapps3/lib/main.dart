// import 'package:flutter/material.dart';
// import 'weather_service.dart';
// import 'forecast_screen.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool _isDarkTheme = false;

//   void _toggleTheme() {
//     setState(() {
//       _isDarkTheme = !_isDarkTheme;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Hava Durumu Uygulaması',
//       theme: _isDarkTheme ? ThemeData.dark() : ThemeData.light(),
//       home: WeatherScreen(toggleTheme: _toggleTheme),
//     );
//   }
// }

// bool _isDarkTheme = false;

// class WeatherScreen extends StatefulWidget {
//   final VoidCallback toggleTheme;

//   WeatherScreen({required this.toggleTheme});

//   @override
//   _WeatherScreenState createState() => _WeatherScreenState();
// }

// class _WeatherScreenState extends State<WeatherScreen> {
//   final WeatherService _weatherService = WeatherService();
//   String _city = '';
//   Map<String, dynamic>? _weatherData;
//   final _controller = TextEditingController();

//   Future<void> _fetchWeather() async {
//     try {
//       final data = await _weatherService.fetchWeather(_city);
//       setState(() {
//         _weatherData = data;
//       });
//     } catch (e) {
//       print('Error: $e');
//       setState(() {
//         _weatherData = null;
//       });
//     }
//   }

//   String _getWeatherIcon(String description) {
//     switch (description) {
//       case 'clear sky':
//         return 'assets/clear-sky.png';
//       case 'few clouds':
//         return 'assets/cloud.png';
//       case 'scattered clouds':
//         return 'assets/cloud.png';
//       case 'broken clouds':
//         return 'assets/cloud.png';
//       case 'shower rain':
//         return 'assets/rain.png';
//       case 'rain':
//         return 'assets/rain.png';
//       case 'thunderstorm':
//         return 'assets/storm.png';
//       case 'snow':
//         return 'assets/snow.png';
//       case 'mist':
//         return 'assets/storm.png';
//       default:
//         return 'assets/sun.png';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Hava Durumu Uygulaması'),
//         actions: [
//           IconButton(
//             icon: Icon(_isDarkTheme ? Icons.brightness_7 : Icons.brightness_2),
//             onPressed: widget.toggleTheme,
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _controller,
//               decoration: InputDecoration(
//                 labelText: 'Şehir Girin',
//                 border: OutlineInputBorder(),
//               ),
//               onSubmitted: (value) {
//                 setState(() {
//                   _city = value;
//                   _weatherData = null;
//                 });
//                 _fetchWeather();
//               },
//             ),
//             SizedBox(height: 20),
//             _weatherData == null
//                 ? Container()
//                 : Column(
//                     children: [
//                       Text(
//                         '${_weatherData!['name']}',
//                         style: const TextStyle(
//                           fontSize: 28,
//                         ),
//                       ),
//                       Image.asset(
//                         _getWeatherIcon(
//                             _weatherData!['weather'][0]['description']),
//                         height: 100,
//                       ),
//                       Text(
//                         'Sıcaklık: ${_weatherData!['main']['temp']}°C',
//                         style: TextStyle(fontSize: 24),
//                       ),
//                       Text(
//                         'Hava Durumu: ${_weatherData!['weather'][0]['description']}',
//                         style: TextStyle(fontSize: 24),
//                       ),
//                     ],
//                   ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ForecastScreen(city: _city),
//                   ),
//                 );
//               },
//               child: Text('5 Günlük Hava Durumu'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'weather_service.dart';
import 'forecast_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

bool _isDarkTheme = false;

class _MyAppState extends State<MyApp> {
  bool _isDarkTheme = false;

  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hava Durumu Uygulaması',
      theme: _isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      home: WeatherScreen(toggleTheme: _toggleTheme),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  WeatherScreen({required this.toggleTheme});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  String _city = '';
  Map<String, dynamic>? _weatherData;
  final _controller = TextEditingController();

  Future<void> _fetchWeather() async {
    try {
      final data = await _weatherService.fetchWeather(_city);
      setState(() {
        _weatherData = data;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _weatherData = null;
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hava Durumu Uygulaması'),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: Icon(_isDarkTheme ? Icons.brightness_7 : Icons.brightness_2),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Şehir Girin',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _city = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _fetchWeather,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueGrey, // Yazı rengini değiştirin
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Getir'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _weatherData == null
                ? Container()
                : Column(
                    children: [
                      Text(
                        '${_weatherData!['name']}',
                        style: const TextStyle(fontSize: 24),
                      ),
                      Image.asset(
                        _getWeatherIcon(
                            _weatherData!['weather'][0]['description']),
                        height: 100,
                      ),
                      Text(
                        'Sıcaklık: ${_weatherData!['main']['temp']}°C',
                        style: const TextStyle(fontSize: 24),
                      ),
                      Text(
                        'Hava Durumu: ${_weatherData!['weather'][0]['description']}',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForecastScreen(city: _city),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueGrey, // Yazı rengini değiştirin
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('5 Günlük Hava Durumu'),
            ),
          ],
        ),
      ),
    );
  }
}
