import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/question_summary/summary_item.dart';

class QuestionSummary extends StatelessWidget {
  const QuestionSummary({required this.SummaryData, super.key});

  final List<Map<String, Object>> SummaryData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: SummaryData.map((data) {
            return Column(
              children: [
                SummaryItem(itemData: data),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
