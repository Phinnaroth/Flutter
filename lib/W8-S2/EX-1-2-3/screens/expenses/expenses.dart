import 'package:flutter/material.dart';
import 'expenses_form.dart';
import 'expenses_list.dart';
import '../../models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.Work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.Leisure,
    ),
  ];

  void onExpenseRemoved(Expense expense) {
    setState(() {

      Expense removedExpense = expense;

      _registeredExpenses.remove(expense);
    

    // Clear snack bar if needed
      clearSnackBars();

      // Display a snack bar 
    showSnackBar(
        duration: const Duration(seconds: 3),
        onAction: () {
          setState(() {
            _registeredExpenses.add(removedExpense);
          });
        },
      );
    });
  }

  void onExpenseCreated(Expense newExpense) {
    setState(() {
      _registeredExpenses.add(newExpense);
    });
  }

  void onAddPressed() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => ExpenseForm(onCreated: onExpenseCreated),
    );
  }
  void clearSnackBars() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  void showSnackBar({
    required Duration duration,
    required VoidCallback 
    onAction,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Expense Deleted"),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: onAction,
        ),
      ),
    );
  }

  @override
Widget build(BuildContext context) {
  Widget bodyContent;

  if (_registeredExpenses.isEmpty) {
    bodyContent = const Center(
      child: Text(
        'No expenses found. Start adding some!',
      ),
    );
  } else {
    bodyContent = ExpensesList(expenses: _registeredExpenses, onExpenseRemoved: onExpenseRemoved);
  }

  return Scaffold(
    backgroundColor: Colors.blue[100],
    appBar: AppBar(
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: onAddPressed,
        )
      ],
      backgroundColor: Colors.blue[700],
      title: const Text('Ronan-The-Best Expenses App'),
    ),
    body: bodyContent,
  );
}
}