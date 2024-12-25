import 'package:flutter/material.dart';
import 'package:myproject/final_exam/models/course.dart';
import 'package:myproject/final_exam/models/student_score.dart';
import 'package:myproject/final_exam/widgets/course_view.dart';

class CourseView extends StatefulWidget {
  
  const CourseView({ super.key});

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  late final List<Course> _courseItem = course;
  late final List<Course> course;
  late final List<StudentScore> stuScore;
  void _addScore() async {
    final newscore = Navigator.of(context).push<CourseDetails>(
      MaterialPageRoute(
        builder: (ctx) => const CourseDetails()
      )
    );
    if (newscore != null){
      setState(() {
        _courseItem.add(newscore as Course);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Score App', style: TextStyle(color: Colors.pink),),
      ),
      body: _courseItem.isEmpty ? const Center(
        child: Text('No Course'),
      ) : ListView.builder(
        itemCount: _courseItem.length,
        itemBuilder: (ctx, index) =>  Card(
                color: Colors.white,
                elevation: 6,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
        child: CourseTile(
            course: course[index], 
            studentScore: stuScore[index],
          ),
        )
        )
        );

  }
}
class CourseTile extends StatelessWidget{
  const CourseTile({super.key, required this.course, this.onTap, required this.studentScore});
  final Course course;
  final StudentScore studentScore;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        course.name,
      ),
      subtitle: _getSubtitle(),
    );
  }
  Widget _getSubtitle(){
    return _getSubtitle();
  }
  String? _subTitle(){
    if (studentScore == StudentTile.length){
      return '${StudentTile.length} scores';
    } else {
      return null;
    }

    
  }

}