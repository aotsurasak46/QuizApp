import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/question.dart';
import 'package:flutter_application_1/utils/config.dart';
import 'package:flutter_application_1/widgets/answer_button.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({
    super.key,
    required this.onSelectedAnswer,
  });

  final void Function(String) onSelectedAnswer;
  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int currentQuestionIndex = 0;
  int totalScore = 0;
  void answerQuestion(String selectedAnswer) {
    widget.onSelectedAnswer(selectedAnswer);
    setState(() {
      currentQuestionIndex += 1;
    });
  }

  @override
  Widget build(context) {
    final currentQuestion = questions[currentQuestionIndex];
    final progress = currentQuestionIndex / questions.length;
    return Container(
      color: Config.alabasterColor,
      child: SizedBox(
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    color: Config.earthYellowColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "${currentQuestionIndex + 1}",
                  style: const TextStyle(
                    fontFamily: "Prompt",
                    fontSize: 50,
                    color: Config.onyxColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                currentQuestion.text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: "Prompt",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ...currentQuestion.shuffledAnswers.map((answer) {
                return Column(
                  children: [
                    AnswerButton(
                      onTap: () {
                        answerQuestion(answer);
                      },
                      answerText: answer,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                );
              }),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${currentQuestionIndex + 1}/${questions.length}",
                style: const TextStyle(
                    fontFamily: "prompt",
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              LinearProgressIndicator(
                minHeight: 15,
                borderRadius: BorderRadius.circular(20),
                value: progress,
                backgroundColor: Config.onyxColor,
                color: Config.earthYellowColor,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "ข้อนี้มีคะแนน ${currentQuestion.score} คะแนน",
                style: TextStyle(
                  fontFamily: "prompt",
                  fontSize: 24,
                  color: Config.earthYellowColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
