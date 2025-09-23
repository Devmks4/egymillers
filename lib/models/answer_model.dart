class AnswerModel {

  String id;
  String questionID;
  String answer;
  String author;
  String date;

  AnswerModel({
    required this.id,
    required this.questionID,
    required this.answer,
    required this.author,
    required this.date
  });

  factory AnswerModel.fromJson(dynamic jsonData) {
    return AnswerModel(
        id: jsonData['id'],
        questionID: jsonData['question_id'],
        answer: jsonData['answer'],
        author: jsonData['author'],
        date: jsonData['date']
    );
  }
}