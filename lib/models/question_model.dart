class QuestionModel {

  String id;
  String question;
  String author;
  String date;

  QuestionModel({
    required this.id,
    required this.question,
    required this.author,
    required this.date
  });

  factory QuestionModel.fromJson(dynamic jsonData) {
    return QuestionModel(
        id: jsonData['id'],
        question: jsonData['question'],
        author: jsonData['author'],
        date: jsonData['date']
    );
  }
}