import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/quiz_question.dart';
import 'package:flutter_application_1/quiz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/services/questions_service.dart';
import 'package:flutter_application_1/utils/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  QuestionsService().loadQuestions();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: Config.fontStyle,
        ));
  }
}
