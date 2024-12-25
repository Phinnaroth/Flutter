import 'package:flutter/material.dart';
import 'package:myproject/PersonalProject/MyReminder/databases/task.dart';
import 'package:myproject/PersonalProject/MyReminder/model/reminder_item.dart';
import 'package:myproject/PersonalProject/MyReminder/widgets/reminder_form.dart';
import 'package:myproject/PersonalProject/MyReminder/widgets/reminder_list.dart';

class ReminderListScreen extends StatefulWidget {
  final List<Reminder> completedTasks;

  const ReminderListScreen({
    required this.completedTasks,
    super.key,
  });

  @override
  State<ReminderListScreen> createState() => _ReminderListScreenState();
}

class _ReminderListScreenState extends State<ReminderListScreen> {
  final List<Reminder> _taskItem = reminderTask;

  void onCreate() async {
    final newTask = await Navigator.of(context).push<Reminder>(
      MaterialPageRoute(builder: (ctx) => const NewTask()),
    );
    if (newTask != null) {
      setState(() {
        _taskItem.add(newTask);
      });
    }
  } 

  void onRemoved(Reminder reminder) {
    _taskItem.remove(reminder);  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onCreate,
        child: const Icon(Icons.add),
      ),
      body: _taskItem.isEmpty ? const Center(
        child: Text('No tasks yet'),
      ) : ReminderList(
        tasks: _taskItem, 
        onRemovedTask: onRemoved, 
        completedTasks: widget.completedTasks
      ),
    );
  }
}

