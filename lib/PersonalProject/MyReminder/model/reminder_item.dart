import 'package:myproject/PersonalProject/MyReminder/model/priority.dart';
import 'package:myproject/PersonalProject/MyReminder/model/reminder_category.dart';
import 'package:uuid/uuid.dart';

class Reminder {
  String id = const Uuid().v4();
  final String title;
  final String notes;
  final DateTime dateTime;
  final ReminderCategory category;
  final Priority priority;
  bool taskCompleted;

  Reminder({
    required this.id,
    required this.title,
    required this.notes,
    required this.dateTime,
    required this.category,
    required this.priority,
    this.taskCompleted = false,
  });
}