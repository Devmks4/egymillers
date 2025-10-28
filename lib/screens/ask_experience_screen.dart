import 'package:egymillers/providers/questions_provider.dart';
import 'package:egymillers/screens/ask_experience_answers_screen.dart';
import 'package:egymillers/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/question_model.dart';

class AskExperienceScreen extends StatefulWidget {
   AskExperienceScreen({super.key});

  @override
  _AskExperienceScreen createState() => _AskExperienceScreen();
}

class _AskExperienceScreen extends State<AskExperienceScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(()=> Provider.of<QuestionsProvider>(context, listen: false).fetchQuestions());
  }

  @override
  Widget build(BuildContext context) {

    final questionProvider = Provider.of<QuestionsProvider>(context);

    return Scaffold(
      floatingActionButton: questionProvider.isQuestionsLoading? null :
        FloatingActionButton(
              shape: CircleBorder(),
              onPressed:(){
                 // _addQuestionBottomSheet(context);
                questionProvider.canAddQuestion = true;
                showAddQuestionDialog(context);
              },
              backgroundColor: primaryColor,
              child: Icon(
                Icons.add,
                size: 32,
                color: Colors.white,
              ),
            ),
      backgroundColor: scaffoldBackGround,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('إسأل خبير', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Consumer<QuestionsProvider>(
        builder: (BuildContext context, QuestionsProvider value, Widget? child) {
          if (value.isQuestionsLoading || value.questionData.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: primaryColor),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Center(child: Text('التاريخ',
                          style: TextStyle(fontWeight: FontWeight.bold),)),
                      ),
                      Container(
                        width: 1,
                        height: double.infinity,
                        color: primaryColor,
                      ),
                      SizedBox(
                        width: 100,
                        child: Center(child: Text('كاتب السؤال',
                          style: TextStyle(fontWeight: FontWeight.bold),)),
                      ),
                      Container(
                        width: 1,
                        height: double.infinity,
                        color: primaryColor,
                      ),
                      Expanded(
                        child: Center(
                          child: Text('السؤال',
                            style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: false,
                    itemCount: questionProvider.questionData.length,
                    itemBuilder: (context, index) {
                      var question = questionProvider.questionData[index];
                      return QuestionElement(question: question);
                    },
                  ),
                )
              ],
            ),
          );
        }
        )
    );
  }
}

class QuestionElement extends StatelessWidget{
  QuestionElement({super.key , required this.question});
  QuestionModel question;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AskExperienceAnswersScreen(question: question.question, questionID: int.parse(question.id), author: question.author, date: question.date,)
              ),
            );
          },
          child: Container(
                  height: 90,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: primaryColor),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Center(
                                  child: Text(
                                    question.date,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                              ),
                            ),
                            Container(
                              width: 1,
                              height: double.infinity,
                              color: primaryColor,
                            ),
                            SizedBox(
                              width: 100,
                              child: Center(
                                  child: Text(
                                    question.author,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                              ),
                            ),
                            Container(
                              width: 1,
                              height: double.infinity,
                              color: primaryColor,
                            ),
                            Expanded(
                              child: Center(
                                child: Text(question.question,
                                  maxLines: 3,              // restrict to 1 line
                                  overflow: TextOverflow.ellipsis, // show "..." if overflow
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),


                  ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

/*void _addQuestionBottomSheet(BuildContext context) {
  TextEditingController questionController = TextEditingController();
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
              controller: questionController,
              decoration: InputDecoration(
                labelText: 'أكتب السؤال',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (authorController.text.isEmpty ||
                    questionController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("من فضلك أدخل جميع البيانات")),
                  );
                  return;
                }

                await Provider.of<QuestionsProvider>(context, listen: false)
                    .addQuestion(
                  questionController.text,
                  authorController.text,
                );

                Navigator.pop(context); // ✅ close sheet after insert
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("تم إرسال السؤال بنجاح")),
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

void showAddQuestionDialog(BuildContext context) {
  final questionController = TextEditingController();
  final authorController = TextEditingController();

  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text("إضافة سؤال جديد"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: questionController,maxLines: 4,textAlign: TextAlign.start, decoration: InputDecoration(labelText: "أكتب سؤالك")),
          TextField(controller: authorController,maxLines: 1,textAlign: TextAlign.start, decoration: InputDecoration(labelText: "أكتب اسمك")),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (questionController.text.isNotEmpty && authorController.text.isNotEmpty) {
              await Provider.of<QuestionsProvider>(context, listen: false)
                  .addQuestion(questionController.text, authorController.text);
              Navigator.pop(ctx);
            }
          },
          child: Text("إضافة السؤال"),
        ),
      ],
    ),
  );
}

