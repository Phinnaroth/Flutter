import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myproject/PersonalProject/MyReminder/model/reminder_category.dart';
import 'package:myproject/PersonalProject/MyReminder/model/reminder_item.dart';
import 'package:myproject/PersonalProject/MyReminder/widgets/reminder_list.dart';
import 'package:uuid/uuid.dart';


class NewTask extends StatefulWidget {
  final Mode mode;
  final Reminder? reminderList;

  const NewTask({
    super.key,
    this.mode = Mode.creating,
    this.reminderList,
  });

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final _formKey = GlobalKey<FormState>();

  String id = const Uuid().v4();
  String _enterTitle = '';
  String _enterNote = '';
  ReminderCategory _category = ReminderCategory.others;
  DateTime? _selectedDate;

  //initial the old value to display on edit screeen
  @override
  void initState() {
    super.initState();

    if (widget.mode == Mode.editing && widget.reminderList != null) {
      final reminder = widget.reminderList!;
        _enterTitle = reminder.title;
        _enterNote = reminder.notes;
        _category = reminder.category;
        _selectedDate = reminder.dateTime;
      }
  }

  void onAdd() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Reminder newTask = Reminder(
        id: widget.reminderList?.id ?? id,
        title: _enterTitle,
        notes: _enterNote,
        dateTime: _selectedDate ?? DateTime.now(),
        category: _category,
      );

      Navigator.of(context).pop(newTask);
    }
  }

  void onReset() {
    _formKey.currentState!.reset();
    setState(() {
      _enterTitle = '';
      _enterNote = '';
      _category = ReminderCategory.others;
      _selectedDate = null;
    });
  }

  String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a title';
    }
    return null;
  }

  void dateTimePickerWidget(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if (pickedDate != null) {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(_selectedDate ?? DateTime.now()),
        ).then((pickedTime) {
          if (pickedTime != null) {
            setState(() {
              _selectedDate = DateTime(
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
              _selectedDate != null
                  ? DateFormat('dd-MMM-yyyy - HH:mm a').format(_selectedDate!)
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
        iconTheme: const IconThemeData(color:  Colors.white),
        title:Text(widget.mode == Mode.editing ? 'Edit the Task' : 'Add New Task', style: const TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInputCard(
                label: 'Title', 
                icon: Icons.title, 
                child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Enter title",
                  border: InputBorder.none,
                ),
                  initialValue: _enterTitle,
                  validator: validateTitle,
                  onSaved: (value) {
                    _enterTitle = value!;
                  },
                ),
              ),
              const SizedBox(height: 10),
              _buildInputCard(
                label: "Notes", 
                icon: Icons.note_add_rounded, 
                child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Optional",
                          border: InputBorder.none
                        ),
                        initialValue: _enterNote,
                        onSaved: (newValue) {
                          _enterNote = newValue!;
                        },
                      ),
              ),
              
              const SizedBox(height: 10),

              _buildInputCard(
                label: "Catogory", 
                icon: Icons.category_outlined, 
                child: DropdownButtonFormField<ReminderCategory>(
                  value: _category,
                  items: ReminderCategory.values
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                Icon(category.icon),
                                const SizedBox(width: 10),
                                Text(category.name),
                              ],
                            ),
                          ))
                      .toList(),
                  decoration: const InputDecoration.collapsed(
                    hintText: '',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _category = value!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              _buildInputCard(
                label: "Date time", 
                icon: Icons.calendar_month_rounded, 
                child: buildDateTimePickerButton()
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (widget.mode == Mode.creating)
                    TextButton(
                      onPressed: onReset,
                      child: const Text('Reset'),
                    ),
                    ElevatedButton(
                      onPressed: onAdd,
                      child: Text(widget.mode == Mode.editing ? 'Edit Task' : 'Add Task'),
                    ),
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildInputCard({required String label, required IconData icon, required Widget child}) {
    return Card(
      elevation: 6,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.amber),
                const SizedBox(width: 10),
                Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10,),
            // Add the child widget that was passed to the method
            child,
          ],
        ),
      ),
    );
  }
}