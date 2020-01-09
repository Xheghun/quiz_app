import 'package:quiz_app/question.dart';

class QuizBrain {
  int _questionNumber = 0;
  List<Question> _questions = [
    Question(questionText: "Flutter is an open source project", answer: true),
    Question(
        questionText:
            "Java is the official language for building flutter applications",
        answer: false),
    Question(questionText: "iOS isn\'t supported by flutter ", answer: false),
  ];

  String getQuestionText() {
    return _questions[_questionNumber].questionText;
  }

  bool getQuestionAnswer() {
    return _questions[_questionNumber].answer;
  }

  void nextQuestion() {
    if (_questionNumber < _questions.length - 1) {
      _questionNumber++;
    }
  }

  bool quizEnded() {
    if (_questionNumber == _questions.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void resetProgress() {
    _questionNumber = 0;
  }
}
