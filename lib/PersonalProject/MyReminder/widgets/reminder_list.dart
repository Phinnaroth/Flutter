import 'package:flutter/material.dart';
import 'package:myproject/PersonalProject/MyReminder/model/priority.dart';
import 'package:myproject/PersonalProject/MyReminder/model/reminder_item.dart';
import 'package:myproject/PersonalProject/MyReminder/widgets/reminder_tile.dart';
import 'package:myproject/PersonalProject/MyReminder/widgets/reminder_form.dart';

enum Mode {
  creating,
  editing,
}
class ReminderList extends StatefulWidget {
  const ReminderList({
    super.key,
    required this.tasks,
    required this.onRemovedTask,
    required this.completedTasks,
  });

  final List<Reminder> tasks;
  final List<Reminder> completedTasks;
  final Function(Reminder) onRemovedTask;

  @override
  _ReminderListState createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {

  List<Reminder> getSortTasks(){
    widget.tasks.sort((a, b){
      if (a.priority == Priority.high && b.priority != Priority.high){
        return -1; //high priority on top
      }else if(a.priority != Priority.high && b.priority == Priority.high){
        return 1;
      }else{
        return 0; //equal priority
      }
    });
    return widget.tasks;
  }
  
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      widget.tasks[index].taskCompleted = value ?? false;

      if (widget.tasks[index].taskCompleted) {
        Reminder completedTask = widget.tasks.removeAt(index);
        widget.completedTasks.add(completedTask);
      }
    });
  }

  void _editTask(Reminder item, int index) async {
    final updatedTask = await Navigator.of(context).push<Reminder>(
      MaterialPageRoute(
        builder: (ctx) => NewTask(
          mode: Mode.editing,
          reminderList: item,
        ),
      ),
    );

    if (updatedTask != null) {
      setState(() {
        int taskIndex = widget.tasks.indexWhere((task) => task.id == updatedTask.id);
        if (taskIndex != -1) {
          widget.tasks[taskIndex] = updatedTask;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Reminder> sortedTasks = getSortTasks();
    return widget.tasks.isNotEmpty
        ? ListView.builder(
            itemCount: widget.tasks.length,
            itemBuilder: (ctx, index) => Dismissible(
              background: Container(
                color: Colors.red,
                child: const Icon(Icons.delete, color: Colors.white,),
                padding: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.centerLeft,
              ),
              key: UniqueKey(),
              confirmDismiss: (direction) async{
                return _showDeleteConfirmationDialog(context);
              },
              onDismissed: (direction) {
                setState(() {
                  widget.tasks.removeAt(index);
                });
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Task deleted'),
                    duration: Duration(seconds: 3)
                  ),
                );
              },
              child: Card(
                color: Colors.white,
                elevation: 6,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                child: ReminderTile(
                  reminderItem: sortedTasks[index],
                  taskCompleted: sortedTasks[index].taskCompleted,
                  onChanged: (value) {
                    checkBoxChanged(value, index);
                  },
                  onTap: () => _editTask(widget.tasks[index], index),
                ),
              ),
            ),
          )
        : const Center(
            child: Text('No tasks yet'),
          );
  }

  Future<bool?> _showDeleteConfirmationDialog(BuildContext context){
    return showDialog<bool>(
      context: context, 
      builder: (BuildContext content){
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Delete Reminders task'),
          content: const Text('Are you sure, you want to delete this task'),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pop(false);
              }, 
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pop(true);
              }, 
              child: const Text("Delete", style: TextStyle(color: Colors.redAccent),),
            )
          ],
        );
      }
    );
  }
}