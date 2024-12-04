import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../models/expense.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key, required this.onCreated});

  final Function(Expense) onCreated;

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  Category selectedCategory = Category.Leisure;

  String get title => _titleController.text;

  @override
  void dispose() {
    _titleController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void onCancel() {
    
    // Close modal
    Navigator.pop(context);
  }

  void onAdd() {
    // 1- Get the values from inputs
    String title = _titleController.text;
    double amount = double.parse(_valueController.text);

      // 2- Create the expense
      Expense expense = Expense(
          title: title,
          amount: amount,
          date: DateTime.now(),   
          category: selectedCategory,
      );
      // 3- Ask the parent to add the expense
      widget.onCreated(expense);

      // 4- Close modal
      Navigator.pop(context);
      
  }


  DateTime? selectedDate; // Nullable DateTime for selected date

  Widget buildDatePickerButton() {
    return Row(
      children: [
        Text(
          selectedDate != null
              ? DateFormat('yyyy-MM-dd').format(selectedDate!)
              : 'No date selected',
        ),
        const SizedBox(width: 5),
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(2015),
              lastDate: DateTime(2025),
            );
            if (picked != null) {
              setState(() {
                selectedDate = picked;
              });
            }
          },
        ),
        
        
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  controller: _valueController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    prefixText: '\$ ',
                    labelText: 'Amount',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              buildDatePickerButton(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            DropdownButton<Category>(
              value: selectedCategory,
              onChanged: (Category? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                }
              },
              items: Category.values.map((Category category) {
                return DropdownMenuItem<Category>(
                  value: category,
                  child: Text(category.toString().split('.').last),
                );
              }).toList(),
            ),
            const SizedBox(width: 150),
            ElevatedButton(onPressed: onCancel, child: const Text('Cancel')),
            const SizedBox(width: 10),
            ElevatedButton(onPressed: onAdd, child: const Text('Save Expense')),
          ],
          )
        ],
      ),
    );
  }
}
