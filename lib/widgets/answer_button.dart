import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/config.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.answerText,
    required this.onTap,
  });

  final String answerText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            minimumSize: Size(500, 50),
            backgroundColor: Config.earthYellowColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(90),
            )),
        child: Text(
          answerText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Prompt",
            fontSize: 15,
            color: Config.onyxColor,
          ),
        ),
      ),
    );
  }
}
