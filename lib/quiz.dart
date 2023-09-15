import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/question.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/student/auth_screen.dart';
import 'package:flutter_application_1/screens/teacher/questionform_screen.dart';
import 'package:flutter_application_1/screens/student/questions_screen.dart';
import 'package:flutter_application_1/screens/student/result_screen.dart';
import 'package:flutter_application_1/screens/student/student_home_screen.dart';
import 'package:flutter_application_1/screens/teacher/teacher_home_screen.dart';
import 'package:flutter_application_1/services/user_service.dart';
import 'package:flutter_application_1/utils/config.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  var _auth = FirebaseAuth.instance;
  var _activeScreen = 'home-screen';
  List<String> _selectedAnswer = [];

  void _startQuiz() {
    setState(() {
      _activeScreen = 'question-screen';
      _selectedAnswer.clear();
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

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = StudentHomeScreen(
      startQuiz: _startQuiz,
    );
    
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

    return screenWidget;
  }
}
