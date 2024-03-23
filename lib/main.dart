import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/ui/views/home/home_view.dart';
import 'package:weather_app/ui/views/home/home_viewmodel.dart';

void main(){
 runApp(ChangeNotifierProvider(create: (context) => HomeViewModel(),
  child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
     home: HomeView(),
    );
  }
}
