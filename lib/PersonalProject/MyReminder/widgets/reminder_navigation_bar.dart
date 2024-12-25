import 'package:flutter/material.dart';
import 'package:myproject/PersonalProject/MyReminder/widgets/completed.dart';
import 'package:myproject/PersonalProject/MyReminder/widgets/reminder.dart';
import 'package:myproject/PersonalProject/MyReminder/model/reminder_item.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  int _selectedIndex = 0;
  final List<Reminder> _completedTasks = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      ReminderListScreen(
        completedTasks: _completedTasks,
      ),
      CompletedScreen(
        completedTasks: _completedTasks
      ),
    ];

    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt_rounded),
            label: 'Completed',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
