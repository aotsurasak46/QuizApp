import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, this.switchToForm, {super.key});
  final void Function() startQuiz;
  final void Function() switchToForm;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/images/quiz-logo.png",
            color: Config.mainColor2,
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
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton.icon(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Config.mainColor2)),
                onPressed: startQuiz,
                icon: const Icon(
                  Icons.arrow_right_alt,
                  color: Config.darkerToneColor,
                ),
                label: const Text(
                  'Start a Quiz.',
                  style: TextStyle(
                      fontFamily: "prompt", color: Config.darkerToneColor),
                ),
              ),
              OutlinedButton.icon(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Config.mainColor2)),
                onPressed: switchToForm,
                icon: const FaIcon(
                  FontAwesomeIcons.plus,
                  size: 16,
                  color: Config.darkerToneColor,
                ),
                label: const Text(
                  'Create Quiz.',
                  style: TextStyle(
                      fontFamily: "prompt", color: Config.darkerToneColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
