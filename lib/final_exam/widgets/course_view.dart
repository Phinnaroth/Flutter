import 'package:flutter/material.dart';
import 'package:myproject/final_exam/models/student_score.dart';
import 'package:myproject/final_exam/widgets/score_form.dart';

class CourseDetails extends StatefulWidget {

  const CourseDetails({ super.key});


  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  final List<StudentScore> _studentScore = [];

  void _addScore() async{
    final newScore = await Navigator.of(context).push<StudentScore>(
      MaterialPageRoute(
        builder: (ctx) => const ScoreForm(),
      ),
    );
    if (newScore != null) {
      setState((){
        _studentScore.add(newScore);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child:  Text("No student score!"),);
    if (_studentScore.isNotEmpty){
      content = ListView(
        children: [
          for (final stuScore in _studentScore)
            StudentTile(
              studentScore: stuScore,
            ),
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("dfsfskf"),
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addScore,
        child: const Icon(Icons.add),
      ),
      body: content,
    );

    
  }
}
class StudentTile extends StatelessWidget{
  const StudentTile({super.key, required this.studentScore});
  final StudentScore studentScore;

  static var length;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(studentScore.stuName),
      trailing: Text(studentScore.score as String),
    );
  }
  
}
