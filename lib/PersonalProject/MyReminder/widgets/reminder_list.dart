import 'package:flutter/material.dart';
import 'package:myproject/PersonalProject/MyReminder/data/sample_task.dart';
import 'package:myproject/PersonalProject/MyReminder/model/reminder_item.dart';
import 'package:myproject/PersonalProject/MyReminder/widgets/reminder_task.dart';

class ReminderListScreen extends StatefulWidget {
  const ReminderListScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No tasks yet'));

    void checkBoxChanged(bool? value, int index) {
      setState(() {
        _taskItem[index].taskCompleted = value ?? false;
      });
    }

    if (_taskItem.isNotEmpty) {
      content = ListView.builder(
        itemCount: _taskItem.length,
        itemBuilder: (ctx, index) => ReminderTile(
          reminderItem: _taskItem[index],
          taskCompleted: _taskItem[index].taskCompleted,
          onChanged: (value) {
            checkBoxChanged(value, index);
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminder', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onCreate,
        child: const Icon(Icons.add),
      ),
      body: content,
    );
  }
}

class ReminderTile extends StatelessWidget {
  final Reminder reminderItem;
  final bool taskCompleted;
  final ValueChanged<bool?> onChanged;

  const ReminderTile({
    required this.reminderItem,
    required this.taskCompleted,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          reminderItem.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(reminderItem.notes),
        leading: SizedBox(
          width: 30,
          height: 30,
          child: Icon(reminderItem.category.icon),
        ),
        trailing: Checkbox(
          value: taskCompleted,
          onChanged: onChanged,
        ),
        onTap: () {
          
        },
      ),
    );
  }
}