import 'package:flutter/material.dart';
import 'package:quiz_app/quiz_brian.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: QuizScreen(),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool pickedAnswer) {
    bool answer = quizBrain.getQuestionAnswer();
    setState(() {
      if (answer == pickedAnswer) {
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        scoreKeeper.add(Icon(
          Icons.clear,
          color: Colors.red,
        ));
      }

      //check if user has reached the end of the questions
      if (quizBrain.quizEnded()) {
        //show completed dialog
        showAlertDialog();
      }

      quizBrain.nextQuestion();
    });
  }

  //create an alert dialog
  void showAlertDialog() {
    var alertStyle = AlertStyle(
        animationType: AnimationType.fromBottom,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        animationDuration: Duration(milliseconds: 500));
    Alert(
        style: alertStyle,
        context: context,
        type: AlertType.info,
        title: "Quiz Completed",
        desc: "Congratulations you've completed the quiz",
        buttons: [
          DialogButton(
            child: Text(
              "Reset",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            color: Colors.green,
            onPressed: () {
              setState(() {
                //close dialog
                Navigator.pop(context);
                //reset questions
                quizBrain.resetProgress();
                //clear score icons
                scoreKeeper.clear();
              });
            },
          )
        ]).show();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Text(
                  quizBrain.getQuestionText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: FlatButton(
              onPressed: () {
                checkAnswer(true);
              },
              child: Text("True",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              color: Colors.green,
            ),
          )),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: FlatButton(
              onPressed: () {
                checkAnswer(false);
              },
              child: Text(
                "Flase",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              color: Colors.red,
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: scoreKeeper,
            ),
          )
        ],
      ),
    );
  }
}
