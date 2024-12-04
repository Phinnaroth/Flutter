import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category {
  Food(Icons.lunch_dining),
  Travel(Icons.flight_takeoff),
  Leisure(Icons.movie),
  Work(Icons.work);

  final IconData icon;

  const Category(this.icon);
}

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  @override
  String toString() {
    return "Expense $title , amount $amount";
  }
}
