import 'package:flutter/material.dart';
import 'package:myproject/PersonalProject/MyReminder/widgets/reminder.dart';
import 'package:myproject/PersonalProject/MyReminder/widgets/reminder_list.dart';

void main() {
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
          seedColor: const Color.fromARGB(255, 147, 229, 250),
          brightness: Brightness.light,
          surface: const Color.fromARGB(255, 104, 165, 218),
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const ReminderScreen(),
    );
  }
}
