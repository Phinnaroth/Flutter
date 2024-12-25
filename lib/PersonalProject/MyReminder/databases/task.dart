import 'package:myproject/PersonalProject/MyReminder/model/reminder_category.dart';
import 'package:myproject/PersonalProject/MyReminder/model/reminder_item.dart';


final reminderTask = [
  Reminder(
    id: '', 
    title: 'Mathematics', 
    notes: 'Do matrics for 20 exercises', 
    dateTime: DateTime.now(), 
    category: ReminderCategory.education
  ),
  Reminder(
    id: '', 
    title: 'Meeting', 
    notes: 'Online meeting talk about the course work', 
    dateTime: DateTime.now(), 
    category: ReminderCategory.personal
  )
];