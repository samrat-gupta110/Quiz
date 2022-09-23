import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/src/widgets/framework.dart';
import 'Questions.dart';
import 'package:quiz/Questions.dart';
import 'quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrains = new QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scorekeeper = [];

  void checkAnswer(bool userpickedanswer)
  {
    bool correctanswer = quizBrains.getCorrectAnswer();
    setState(() {

      if(quizBrains.isFinished() == true)
        {
          Alert(
              context: context,
            title: 'Finished',
            desc: 'You\'ve reached the end of the quiz'
          ).show();
          quizBrains.reset();
          scorekeeper = [];
        }
      if(userpickedanswer == correctanswer)
    {
      scorekeeper.add(
          Icon(
            Icons.check,
            color: Colors.green,
          ));
    }
    else
    {
      scorekeeper.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ));
    }
      quizBrains.nextQuestion();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrains.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row( 
          children: scorekeeper,
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
