import 'package:flutter/material.dart';

enum ReminderCategory {
  work('Work',Icons.work),
  fitness('Fitness', Icons.fitness_center),
  personal('Personal', Icons.person),
  shopping('Shopping',Icons.shopping_cart),
  travel('Travel', Icons.airplanemode_active),
  finance('Finance', Icons.attach_money),
  health('Health', Icons.health_and_safety),
  education('Education', Icons.school),
  family('Family', Icons.family_restroom),
  hobbies('Hobbies',  Icons.palette),
  social('Social',  Icons.group),
  maintenance('Maintenance',  Icons.build),
  birthdays('Birthdays',  Icons.cake),
  anniversaries('Anniversaries', Icons.favorite),
  miscellaneous('Miscellaneous',  Icons.category);

  final String name;
  final IconData icon;


  const ReminderCategory(this.name, this.icon);
}
