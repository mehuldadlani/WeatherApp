import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/weather_model.dart';

class HomeViewModel extends ChangeNotifier {
  List<WeatherModel> weathers = [];

  late double latitude = 0.0;
  late double longitude = 0.0;

  late final String cityNameWithCountry;

  Future<void> fetchWeather() async {
    final List<WeatherModel> fetchedWeather = await ApiService().fetchWeather(latitude.toString(), longitude.toString());
    weathers = fetchedWeather;
    notifyListeners();
  }

  Future<void> getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      return;
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    
    latitude = position.latitude;
    longitude = position.longitude;

    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      String city = placemark.locality ?? 'Unknown';
      String country = placemark.country ?? 'Unknown';
      cityNameWithCountry = '$city, $country';
      log('City Name with Country: $cityNameWithCountry');
    } else {
      cityNameWithCountry = 'Unknown';
      log('City Name with Country: Unknown');
    }

    log('Latitude: $latitude, Longitude: $longitude');
  }
}
