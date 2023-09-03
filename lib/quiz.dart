import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/question.dart';
import 'package:flutter_application_1/screens/questionform_screen.dart';
import 'package:flutter_application_1/screens/questions_screen.dart';
import 'package:flutter_application_1/screens/result_screen.dart';
import 'package:flutter_application_1/screens/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  var _activeScreen = 'start-screen';
  List<String> _selectedAnswer = [];

  void _switchScreen() {
    setState(() {
      _activeScreen = 'question-screen';
    });
  }

  void _chooseAnswer(String answer) {
    _selectedAnswer.add(answer);
    if (_selectedAnswer.length == questions.length) {
      setState(() {
        _activeScreen = "result-screen";
      });
    }
  }

  void _restartQuiz() {
    setState(() {
      _activeScreen = 'start-screen';
      _selectedAnswer.clear();
    });
  }

  void _createQuiz() {
    setState(() {
      _activeScreen = 'questionform-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = StartScreen(_switchScreen, _createQuiz);

    if (_activeScreen == 'question-screen') {
      screenWidget = QuestionScreen(
        onSelectedAnswer: _chooseAnswer,
      );
    }

    if (_activeScreen == 'result-screen') {
      screenWidget = ResultScreen(
        chooseAnswers: _selectedAnswer,
        onRestart: () {
          _restartQuiz();
        },
      );
    }

    if (_activeScreen == 'questionform-screen') {
      screenWidget = QuestionFormScreen(
        onSubmitForm: _restartQuiz,
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: screenWidget,
      ),
    );
  }
}
