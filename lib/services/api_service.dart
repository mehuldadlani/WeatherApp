import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:weather_app/weather_model.dart';


class ApiService {
  Future<List<WeatherModel>> fetchWeather(String lat, String lon) async {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=d49ec9c1918eff5b0dd5fd8cf9efa94c';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    log(json.toString());

    final main = WeatherModelMain.fromMap(json['main']);
    final weather = WeatherModelWeather.fromMap(json['weather'][0]);

    final weatherModel = WeatherModel(
      dt: json['dt'].toString(),
      main: main,
      weather: weather,
    );
    return [weatherModel];
  }
}

