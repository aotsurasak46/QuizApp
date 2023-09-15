import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/student/auth_screen.dart';
import 'package:flutter_application_1/screens/student/student_home_screen.dart';
import 'package:flutter_application_1/screens/teacher/teacher_home_screen.dart';
import 'package:flutter_application_1/services/firebase_services.dart';
import 'package:flutter_application_1/utils/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      color: Config.alabasterColor,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/quiz-logo.png",
              color: Config.earthYellowColor,
              width: 300,
            ),
            const SizedBox(
              height: 60,
            ),
            const Text(
              'Welcome to Quiz App.',
              style: TextStyle(
                  fontFamily: "promtp",
                  fontSize: 24,
                  color: Config.onyxColor,
                  decoration: TextDecoration.none),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Your Role ?",
              style: TextStyle(
                fontSize: 16,
                decoration: TextDecoration.none,
                fontFamily: Config.fontStyle,
                color: Config.onyxColor,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                        Config.earthYellowColor),
                  ),
                  onPressed: Config.toPushPage(context, TeacherHomeScreen()),
                  child: const Text(
                    'As Teacher',
                    style: TextStyle(
                        fontFamily: "prompt", color: Config.darkerToneColor),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                OutlinedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                        Config.earthYellowColor),
                  ),
                  onPressed: Config.toPushPage(context, AuthScreen()),
                  child: const Text(
                    'As Student',
                    style: TextStyle(
                        fontFamily: "prompt", color: Config.onyxColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
