import 'dart:convert';
import 'package:egymillers/models/question_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/answer_model.dart';

class QuestionsProvider with ChangeNotifier {
  List<QuestionModel> _questionsData = [];
  List<AnswerModel> _answersData = [];
  bool _isQuestionsLoading = false;
  bool _isAnswersLoading = false;
  List<QuestionModel> get questionData => _questionsData;
  List<AnswerModel> get answerData => _answersData;
  bool get isQuestionsLoading => _isQuestionsLoading;
  bool get isAnswersLoading => _isAnswersLoading;


  Future<void> fetchQuestions() async {
    _isQuestionsLoading = true;
    notifyListeners();

    try {
      final http.Response response = await http.get(Uri.parse('http://egymillers.atwebpages.com/view_questions.php'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _questionsData = data.map((json) => QuestionModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load users");
      }
    } catch (e) {
      print("Error: $e");
    }
    _isQuestionsLoading = false;
    notifyListeners();
  }

  Future<void> addQuestion(String question, String author) async {
    final url = Uri.parse('http://egymillers.atwebpages.com/add_question.php');

    try {
      final response = await http.post(
        url,
        body: {
          'question': question,
          'author': author,
        },
      );

      if (response.statusCode == 200) {

        await fetchQuestions(); // refresh after insert
      } else {

      }
    } catch (e) {

    }

    notifyListeners();
  }

  Future<void> fetchAnswers(int questionID) async {
    _isAnswersLoading = true;
    notifyListeners();
    try {
      final http.Response response = await http.get(Uri.parse('http://egymillers.atwebpages.com/view_answers.php?questionID=$questionID'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _answersData = data.map((json) => AnswerModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load users");
      }
    } catch (e) {
      print("Error: $e");
    }
    _isAnswersLoading = false;
    notifyListeners();
  }

  Future<void> addAnswer (int questionID, String answer,String author) async {
    final url = Uri.parse('http://egymillers.atwebpages.com/add_answer.php');

    try {
      final response = await http.post(
        url,
        body: {
          'questionID': questionID.toString(),
          'answer': answer,
          'author': author,
        },
      );

      if (response.statusCode == 200) {

        await fetchAnswers(questionID); // refresh after insert
      } else {

      }
    } catch (e) {

    }

    notifyListeners();

  }
}