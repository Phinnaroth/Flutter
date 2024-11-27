import 'package:myproject/W7-S2/model/quiz.dart';

class Answer{
  String questionAnswer;

  Answer(this.questionAnswer);
  
  bool isCorrect(Question question) => question.goodAnswer == questionAnswer;
}

class Submission {
  final Map<Question, String> answers = {};

  int getScore(List<Question> questions) {
    int score = 0;
    answers.forEach((question, answer) {
      if (question.goodAnswer == answer) {
        score++;
      }
    });
    return score;
  }

  void addAnswer(Question question, String answer) {
    answers[question] = answer;
  }

  void removeAnswers() {
    answers.clear();
  }

  String? getAnswerFor(Question question) {
    return answers[question];
  }
}

