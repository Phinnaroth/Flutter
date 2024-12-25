import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myproject/final_exam/models/student_score.dart';

class ScoreForm extends StatefulWidget {
  const ScoreForm({super.key});

  @override
  State<ScoreForm> createState() => _ScoreFormState();
}

class _ScoreFormState extends State<ScoreForm> {
  final _formKey = GlobalKey<FormState>();
  String _enteredName = '';
  double _enterScore = 0;


  void _saveItem() {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();

      final newItem = StudentScore(
        stuName: _enteredName, 
        score: _enterScore
      );

      Navigator.of(context).pop(newItem);
    }
  }
  String? validateScore(double? scores) {
    if (scores! > 100) {
      return 'Must be a score between 0 and 100.';
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              initialValue: _enteredName,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Student Name'),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Score',
                    ),
                    initialValue: _enterScore.toString(),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    // validator: validateScore,
                    onSaved: (value){
                      _enterScore = double.parse(value!);
                    },
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
              const SizedBox(width: 10),
              ElevatedButton(onPressed: _saveItem, child: const Text('Save Expense')),
            ],
            )
        )
      );
  }
}
