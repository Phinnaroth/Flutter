import 'package:flutter/material.dart';
import 'package:myproject/PersonalProject/MyReminder/widgets/reminder_navigation_bar.dart';
 

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Reminder',
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          brightness: Brightness.light,
          surface: Colors.amber,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const ReminderScreen(),
    );
  }
}
