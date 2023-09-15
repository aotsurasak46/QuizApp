import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/question.dart';
import 'package:flutter_application_1/services/user_service.dart';
import 'package:flutter_application_1/utils/config.dart';
import 'package:flutter_application_1/widgets/question_summary/question_summary.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({
    super.key,
    required this.chooseAnswers,
    required this.onRestart,
  });

  final List<String> chooseAnswers;
  final void Function() onRestart;
  final _auth = FirebaseAuth.instance;

  List<Map<String, Object>> get SummaryData {
    final List<Map<String, Object>> summary = [];
    for (var i = 0; i < chooseAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].correctAnswer,
        'user_answer': chooseAnswers[i],
        'score': questions[i].score
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = SummaryData.where(
      (data) => data['user_answer'] == data['correct_answer'],
    ).length;
    final correctQuestions = SummaryData.where(
      (data) => data['user_answer'] == data['correct_answer'],
    );
    int totalScore = 0;
    correctQuestions.forEach(
      (element) {
        totalScore += int.parse(element['score'].toString());
      },
    );
    int fullScore = 0;

    SummaryData.forEach(
      (element) {
        fullScore += int.parse(element['score'].toString());
      },
    );

    UserService().updateUserStatus(
        _auth.currentUser!.uid, "Finished, Score ${totalScore}/${fullScore}.");

    return Scaffold(
      body: Container(
        color: Config.alabasterColor,
        child: SizedBox(
          width: double.infinity,
          child: Container(
            margin: const EdgeInsets.all(30),
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Column(children: [
                  const Text(
                    "คุณตอบถูกทั้งหมด",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                      fontFamily: "prompt",
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "$numCorrectQuestions ข้อจาก $numTotalQuestions ข้อ",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                      fontFamily: "prompt",
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ]),
                Text(
                  "คุณได้คะแนนทั้งหมด $totalScore จาก $fullScore",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "prompt",
                    fontSize: 18,
                    color: Config.earthYellowColor,
                  ),
                ),
                Container(
                  height: 500,
                  child: QuestionSummary(
                    SummaryData: SummaryData,
                  ),
                ),
                OutlinedButton.icon(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                        Config.earthYellowColor),
                  ),
                  onPressed: () {
                    UserService()
                        .updateUserProgress(_auth.currentUser!.uid, 0)
                        .whenComplete(() => UserService()
                            .updateUserStatus(
                                _auth.currentUser!.uid, "Not Started")
                            .then((value) => onRestart()));
                  },
                  icon: const Icon(
                    Icons.refresh,
                    color: Config.onyxColor,
                  ),
                  label: const Text(
                    "Restart Quiz",
                    style: TextStyle(
                        fontFamily: "prompt", color: Config.onyxColor),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
