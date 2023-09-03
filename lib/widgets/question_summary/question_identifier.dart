import 'package:flutter/material.dart';

class QuestionIdentifier extends StatelessWidget {
  const QuestionIdentifier(
      {required this.questionIndex, required this.isCorrectAnswer, super.key});
  final int questionIndex;
  final bool isCorrectAnswer;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isCorrectAnswer ? Colors.green : Colors.red.shade600,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color:
                isCorrectAnswer ? Colors.green.shade900 : Colors.red.shade900,
            width: 4,
          )),
      width: 40,
      height: 40,
      alignment: Alignment.center,
      child: Text(
        (questionIndex + 1).toString(),
        style: const TextStyle(
          fontFamily: "prompt",
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
