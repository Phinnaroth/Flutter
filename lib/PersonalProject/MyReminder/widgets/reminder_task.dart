
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myproject/PersonalProject/MyReminder/model/reminder_category.dart';
import 'package:myproject/PersonalProject/MyReminder/model/reminder_item.dart';
import 'package:uuid/uuid.dart';



class NewTask extends StatefulWidget{
  const NewTask({super.key});
  

  @override
  State<StatefulWidget> createState() {
    return _NewTaskState();
  }
}

class _NewTaskState extends State<NewTask>{

  final _formKey = GlobalKey<FormState>();
  String id = const Uuid().v4();
  String _enterTitle = '';
  String _enterNote = '';
  ReminderCategory _category = ReminderCategory.education;
  // TimeOfDay time = TimeOfDay.now();

  void onAdd(){
    bool isValid = _formKey.currentState!.validate();

    if (isValid){
      _formKey.currentState!.save();

      final enterTitle = _enterTitle;
      final enterNote = _enterNote;
      final enterCategory = _category;

      Reminder newTask = Reminder(
        id: id, 
        title: enterTitle, 
        notes: enterNote, 
        dateTime: selectedDate?? DateTime.now(), 
        category: enterCategory
      );
      
      Navigator.of(context).pop(newTask);
    }
  }

  void onReset(){
    _formKey.currentState!.reset();
  }

  String? validateTitle(String? value){
    if (value == null ||
        value.isEmpty
      ){
        return 'Must be enter your title';
      }
    return null;
  }

  DateTime? selectedDate;
  void dateTimePickerWidget(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if (pickedDate != null) {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(selectedDate ?? DateTime.now()),
        ).then((pickedTime) {
          if (pickedTime != null) {
            setState(() {
              selectedDate = DateTime(
                pickedDate.year,
                pickedDate.month,
                pickedDate.day,
                pickedTime.hour,
                pickedTime.minute,
              );
            });
          }
        });
      }
    });
  }

  Widget buildDateTimePickerButton() {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            dateTimePickerWidget(context);
          },
          child: Text(
            selectedDate != null
                ? DateFormat('dd-MMM-yyyy - HH:mm').format(selectedDate!)
                : 'Pick Date-Time',
          ),
        ),
      ],
    );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child:  Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
                initialValue: _enterTitle,
                validator: validateTitle,
                onSaved: (value){
                  _enterTitle = value!;
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Notes'),
                      ),
                      initialValue: _enterNote,
                      onSaved: (newValue){
                        _enterNote = newValue!;
                      },
                    ),
                  ),
                  
                  buildDateTimePickerButton()
                    
                ],
              ),
              
              const SizedBox(height: 10),
              
              DropdownButtonFormField(
                value: _category,
                items: [
                  for (final category in ReminderCategory.values)
                    DropdownMenuItem<ReminderCategory>(
                      value: category,
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Icon(category.icon), 
                          const SizedBox(width: 10),
                          Text(category.name),                       
                        ],
                      )
                  )
                ], 
                onChanged: (value){
                  _category = value!;
                },
              ),
        
              
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onReset,
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: onAdd,
                    child: const Text('Add task'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}