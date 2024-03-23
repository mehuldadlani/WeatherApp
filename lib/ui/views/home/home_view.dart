import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/weather_model.dart';

import 'home_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();

    _getlocation();
  }

  Future<void> _getlocation() async {
    await Provider.of<HomeViewModel>(context, listen: false).getLocation();
    // ignore: use_build_context_synchronously
    Provider.of<HomeViewModel>(context, listen: false).fetchWeather();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, model, child) {
        if (model.weathers.isEmpty) {
          return const Scaffold(
              backgroundColor: Color(0xffCDECFC),
              body: Center(child: CircularProgressIndicator()));
        }
        final WeatherModel weather = model.weathers[0];
        final double celsius =
            _convertKelvinToCelsius(double.parse(weather.main.temp));
        int unixTimestamp = int.parse(weather.dt);

        DateTime date =
            DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);

        String formattedDate = DateFormat.yMMMMd().format(date);

        int dayOfWeek = date.weekday;
        String dayOfWeekString = '';
        switch (dayOfWeek) {
          case 1:
            dayOfWeekString = 'Monday';
            break;
          case 2:
            dayOfWeekString = 'Tuesday';
            break;
          case 3:
            dayOfWeekString = 'Wednesday';
            break;
          case 4:
            dayOfWeekString = 'Thursday';
            break;
          case 5:
            dayOfWeekString = 'Friday';
            break;
          case 6:
            dayOfWeekString = 'Saturday';
            break;
          case 7:
            dayOfWeekString = 'Sunday';
            break;
        }

        log(DateTime.timestamp().toString());

        return Scaffold(
          backgroundColor: const Color(0xffCDECFC),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  formattedDate,
                                  style: GoogleFonts.josefinSans(
                                    textStyle: const TextStyle(
                                      fontSize: 20,
                                      color: Color(0xff474747),
                                      letterSpacing: .5,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    model.cityNameWithCountry,
                                    style: GoogleFonts.josefinSans(
                                      textStyle: const TextStyle(
                                        fontSize: 20,
                                        color: Color(0xff474747),
                                        letterSpacing: .5,
                                      ),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${celsius.toStringAsFixed(0)} °C',
                              style: GoogleFonts.josefinSans(
                                textStyle: const TextStyle(
                                  fontSize: 30,
                                  color: Color(0xff474747),
                                  letterSpacing: .5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                     
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset('assets/cloud.png'),
                            Image.asset(
                              'assets/sun.png',
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Text(
                            dayOfWeekString,
                            style: GoogleFonts.josefinSans(
                              textStyle: const TextStyle(
                                fontSize: 30,
                                color: Color(0xff474747),
                                letterSpacing: .5,
                              ),
                            ),
                          ),
                          Text(
                            weather.weather.main,
                            style: GoogleFonts.josefinSans(
                              textStyle: const TextStyle(
                                fontSize: 20,
                                color: Color(0xff474747),
                                letterSpacing: .5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    
                      Image.asset(
                        'assets/cloud3.png',
                        height: 450,
                        width: 500,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  double _convertKelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
  }
}
