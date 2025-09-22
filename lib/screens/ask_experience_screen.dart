import 'package:egymillers/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class AskExperienceScreen extends StatefulWidget {
  const AskExperienceScreen({super.key});

  @override
  _AskExperienceScreen createState() => _AskExperienceScreen();
}

class _AskExperienceScreen extends State<AskExperienceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed:(){},
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: primaryColor),
                    ),
                    child: Center(
                      child: Text('السؤال',
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: primaryColor),
                  ),
                  child: Center(child: Text('عدد الإجابات',style: TextStyle(fontWeight: FontWeight.bold),)),
                ),
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: primaryColor),
                  ),
                  child: Center(child: Text('كاتب السؤال',style: TextStyle(fontWeight: FontWeight.bold),)),
                ),
              ],
            ),
           const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: false,
                itemCount: 50,
                itemBuilder: (context, index) {
                  return ListElement();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ListElement extends StatelessWidget {
  const ListElement({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: primaryColor),
                ),
                child: MaterialButton(
                  onPressed: () {},
                  child: Text('هل يمكن طحن القمح بدون ترطيبه ؟'),
                ),
              ),
            ),
            Container(
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: primaryColor),
              ),
              child: MaterialButton(
                onPressed: () {},
                child: Text('5'),
              ),
            ),
            Container(
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: primaryColor),
              ),
              child: MaterialButton(
                onPressed: () {},
                child: Text('محمد كمال'),
              ),
            ),
          ],
        ),
        SizedBox(height: 4,)
      ],
    );
  }
}
