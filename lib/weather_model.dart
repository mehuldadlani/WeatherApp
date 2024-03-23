// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WeatherModel {
  final String dt;
  final WeatherModelMain main;
  final WeatherModelWeather weather;
  WeatherModel({
    required this.dt,
    required this.main,
    required this.weather,
  });

  WeatherModel copyWith({
    String? dt,
    WeatherModelMain? main,
    WeatherModelWeather? weather,
  }) {
    return WeatherModel(
      dt: dt ?? this.dt,
      main: main ?? this.main,
      weather: weather ?? this.weather,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dt': dt,
      'main': main.toMap(),
      'weather': weather.toMap(),
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      dt: map['dt'].toString(),
      main: WeatherModelMain.fromMap(map['main'] as Map<String,dynamic>),
      weather: WeatherModelWeather.fromMap(map['weather'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) => WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'WeatherModel(dt: $dt, main: $main, weather: $weather)';

  @override
  bool operator ==(covariant WeatherModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.dt == dt &&
      other.main == main &&
      other.weather == weather;
  }

  @override
  int get hashCode => dt.hashCode ^ main.hashCode ^ weather.hashCode;
}

class WeatherModelMain {
  final String temp;
  WeatherModelMain({
    required this.temp,
  });


  WeatherModelMain copyWith({
    String? temp,
  }) {
    return WeatherModelMain(
      temp: temp ?? this.temp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'temp': temp,
    };
  }

  factory WeatherModelMain.fromMap(Map<String, dynamic> map) {
    return WeatherModelMain(
      temp: map['temp'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModelMain.fromJson(String source) => WeatherModelMain.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'WeatherModelMain(temp: $temp)';

  @override
  bool operator ==(covariant WeatherModelMain other) {
    if (identical(this, other)) return true;
  
    return 
      other.temp == temp;
  }

  @override
  int get hashCode => temp.hashCode;
}

class WeatherModelWeather {
  final String main;
  WeatherModelWeather({
    required this.main,
  });

  WeatherModelWeather copyWith({
    String? main,
  }) {
    return WeatherModelWeather(
      main: main ?? this.main,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'main': main,
    };
  }

  factory WeatherModelWeather.fromMap(Map<String, dynamic> map) {
    return WeatherModelWeather(
      main: map['main'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModelWeather.fromJson(String source) => WeatherModelWeather.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'WeatherModelWeather(main: $main)';

  @override
  bool operator ==(covariant WeatherModelWeather other) {
    if (identical(this, other)) return true;
  
    return 
      other.main == main;
  }

  @override
  int get hashCode => main.hashCode;
}
