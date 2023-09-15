import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/data/question.dart';
import 'package:flutter_application_1/models/quiz_question.dart';

class QuestionsService {
  final CollectionReference quizQuestionsCollection =
      FirebaseFirestore.instance.collection('quiz_questions');
  
  Future<void> addQuizQuestion(QuizQuestion question) async {
    try {
      await quizQuestionsCollection.add({
        'text': question.text,
        'answers': question.answers,
        'correctAnswer': question.correctAnswer,
        'score': question.score,
      });
    } catch (e) {
      print('Error adding quiz question: $e');
      throw e;
    }
  }

  Future<List<QuizQuestion>> getAllQuizQuestions() async {
    try {
      final querySnapshot = await quizQuestionsCollection.get();
      final List<QuizQuestion> quizQuestions = [];

      for (final doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final quizQuestion = QuizQuestion(
          data['text'] ?? '',
          List<String>.from(data['answers'] ?? []),
          data['correctAnswer'] ?? '',
          data['score'] ?? 0,
        );

        quizQuestions.add(quizQuestion);
      }

      return quizQuestions;
    } catch (e) {
      print('Error fetching quiz questions: $e');
      throw e;
    }
  }

  Future<void> loadQuestions() async {
    // Use your QuestionsService to fetch the questions.
    final questionsService = QuestionsService();
    List<QuizQuestion> fetchedQuestions =
        await questionsService.getAllQuizQuestions();
    // Assign the fetched questions to the 'questions' variable in 'questions.dart'.
    questions = fetchedQuestions;
  }
  
}
