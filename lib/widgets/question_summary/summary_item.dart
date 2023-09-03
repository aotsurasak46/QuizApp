import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/question_summary/question_identifier.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem({required this.itemData, super.key});
  final Map<String, Object> itemData;
  @override
  Widget build(BuildContext context) {
    bool isCorrectAnswer = itemData['correct_answer'] as String ==
        itemData['user_answer'].toString();
    return Stack(children: [
      Container(
        height: 200,
        width: 500,
        margin: const EdgeInsets.fromLTRB(
          15,
          12,
          15,
          7,
        ),
        padding: const EdgeInsets.fromLTRB(
          5,
          12,
          5,
          2,
        ),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      itemData['question'] as String,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: const TextStyle(
                        fontFamily: "prompt",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Correct answer : ${itemData['correct_answer'] as String}",
                    style: const TextStyle(
                      fontFamily: "prompt",
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    isCorrectAnswer
                        ? "You\'re right !!!"
                        : "Your answer : ${itemData['user_answer'].toString()}",
                    style: const TextStyle(
                      fontFamily: "prompt",
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    textAlign:
                        isCorrectAnswer ? TextAlign.center : TextAlign.start,
                  ),
                  Text(
                    "Score : ${isCorrectAnswer ? itemData['score'] : 0} ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "prompt",
                      fontSize: 14,
                      color: Colors.brown.shade400,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
      Positioned(
        left: 0,
        top: -3,
        child: Container(
          padding: const EdgeInsets.all(4),
          child: QuestionIdentifier(
            questionIndex: int.parse(itemData['question_index'].toString()),
            isCorrectAnswer: isCorrectAnswer,
          ),
        ),
      )
    ]);
  }
}
