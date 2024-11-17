import 'package:flutter/material.dart';
import 'package:myproject/W6-S2/EXERCISE-3/screen/temperature.dart';
import 'package:myproject/W6-S2/EXERCISE-3/screen/welcome.dart';

class TemperatureApp extends StatefulWidget {
  const TemperatureApp({super.key});

  @override
  State<TemperatureApp> createState() {
    return _TemperatureAppState();
  }
}

class _TemperatureAppState extends State<TemperatureApp> {
  bool isClick = true;

  void switchScreen(){
    setState(() {
      isClick =! isClick;
    });
  }
  @override
  Widget build(context) {

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 227, 153, 212),
                Color.fromARGB(255, 202, 115, 130),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: isClick ? Welcome(back: switchScreen) : Temperature(),
        ),
      ),
    );
  }
}

void main() {
  runApp(const TemperatureApp());
}
