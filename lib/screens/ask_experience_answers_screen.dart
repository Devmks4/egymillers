import 'package:egymillers/providers/questions_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/answer_model.dart';
import '../shared/styles/colors.dart';

class AskExperienceAnswersScreen extends StatefulWidget {
  AskExperienceAnswersScreen({
    super.key,
    required this.question,
    required this.questionID,
    required this.author,
    required this.date,
  });
  String question, author, date;
  int questionID;

  @override
  State<AskExperienceAnswersScreen> createState() =>
      _AskExperienceAnswersScreenState();
}

class _AskExperienceAnswersScreenState
    extends State<AskExperienceAnswersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
      () => Provider.of<QuestionsProvider>(
        context,
        listen: false,
      ).fetchAnswers(widget.questionID),
    );
  }

  @override
  Widget build(BuildContext context) {
    final answerProvider = Provider.of<QuestionsProvider>(context);
    return Scaffold(
      floatingActionButton:
          answerProvider.isAnswersLoading
              ? null
              : FloatingActionButton(
                shape: CircleBorder(),
                onPressed: () {
                    //_addAnswerBottomSheet(context,widget.questionID);
                    showAddAnswerDialog(context,widget.questionID);
                },
                backgroundColor: primaryColor,
                child: Icon(Icons.add, size: 32, color: Colors.white),
              ),
      backgroundColor: scaffoldBackGround,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'إجابات السؤال',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<QuestionsProvider>(
        builder: (
          BuildContext context,
          QuestionsProvider value,
          Widget? child,
        ) {
          if (value.isQuestionsLoading || value.questionData.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          return Center(
            child: Column(
              spacing: 8,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: primaryColor),
                    ),
                    child: Column(
                      spacing: 4,
                      children: [
                        Text(
                          widget.question,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(height: 1, color: primaryColor),
                        SizedBox(
                          height: 30,
                          child: Row(
                            children: [
                              Flexible(
                                child: Center(
                                  child: Text(
                                    widget.date,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                height: double.infinity,
                                color: primaryColor,
                              ),
                              Flexible(
                                child: Center(
                                  child: Text(
                                    widget.author,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: false,
                    itemCount: answerProvider.answerData.length,
                    itemBuilder: (context, index) {
                      var answer = answerProvider.answerData[index];
                      return AnswerElement(answer: answer);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class AnswerElement extends StatelessWidget {
  AnswerElement({super.key, required this.answer});
  AnswerModel answer;
  //List<MaterialColor> answersColors = [Colors.yellow , Colors.blueGrey , Colors.blue , Colors.lightBlue , Colors.deepOrange];
  @override
  Widget build(BuildContext context) {
    // var random = new Random();
    // var color = answersColors[random.nextInt(answersColors.length)];
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            //  height: 100,
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: primaryColor),
            ),
            child: Column(
              spacing: 4,
              children: [
                Text(
                  answer.answer,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(height: 1, color: primaryColor),
                SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      Flexible(
                        child: Center(
                          child: Text(
                            answer.date,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: double.infinity,
                        color: primaryColor,
                      ),
                      Flexible(
                        child: Center(
                          child: Text(
                            answer.author,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

/*void _addAnswerBottomSheet(BuildContext context, int questionID) {
  TextEditingController answerController = TextEditingController();
  TextEditingController authorController = TextEditingController();

  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: authorController,
              decoration: InputDecoration(
                labelText: 'أدخل اسمك',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: answerController,
              decoration: InputDecoration(
                labelText: 'أكتب الإجابة',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (authorController.text.isEmpty ||
                    answerController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("من فضلك أدخل جميع البيانات")),
                  );
                  return;
                }

                await Provider.of<QuestionsProvider>(
                  context,
                  listen: false,
                ).addAnswer(
                  questionID,
                  answerController.text,
                  authorController.text,
                );

                Navigator.pop(context); // ✅ close sheet after insert
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("تم إرسال الإجابة بنجاح")),
                );
              },
              child: Text('إرسال'),
            ),
          ],
        ),
      );
    },
  );
}*/

void showAddAnswerDialog(BuildContext context , int questionID) {
  final answerController = TextEditingController();
  final authorController = TextEditingController();

  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text("إضافة إجابة جديدة"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: answerController,maxLines: 4,textAlign: TextAlign.start, decoration: InputDecoration(labelText: "أكتب إجابتك")),
          TextField(controller: authorController,maxLines: 1,textAlign: TextAlign.start, decoration: InputDecoration(labelText: "أكتب اسمك")),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (answerController.text.isNotEmpty && authorController.text.isNotEmpty) {
              await Provider.of<QuestionsProvider>(
                context,
                listen: false,
              ).addAnswer(
                questionID,
                answerController.text,
                authorController.text,
              );
              Navigator.pop(ctx);
            }
          },
          child: Text("إضافة الإجابة"),
        ),
      ],
    ),
  );
}


