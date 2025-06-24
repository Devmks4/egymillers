import 'package:egymillers/screens/manual_person_screen.dart';
import 'package:egymillers/shared/styles/colors.dart';
import 'package:egymillers/widgets/app_button.dart';
import 'package:egymillers/widgets/view_result.dart';
import 'package:flutter/material.dart';
import 'package:egymillers/widgets/app_widgets.dart';

import '../widgets/app_textfield.dart';
import '../widgets/selection_button.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({super.key});

  @override
  _PersonScreenState createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {

  // Variables //
  bool isWheat = false;
  bool isTwo = true;
  double firstGluten = 0, secondGluten = 0, thirdGluten = 0, reqGluten = 0;
  double firstPerc = 0, secondPerc = 0, thirdPerc = 0, resGluten = 0;

  var control1 = TextEditingController(),
      control2 = TextEditingController(),
      control3 = TextEditingController(),
      control4 = TextEditingController();
  var formKey = GlobalKey<FormState>();

  // Variables //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackGround,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'حسابات مربع بيرسون',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                spacing: 8,
                children: [
                  Row(
                    spacing: 24,
                    children: [
                      Expanded(
                        child: SelectionButton(
                          buttonColor: !isWheat ? primaryColor : Colors.grey,
                          onPressed: (){
                            setState(() {
                              isWheat = false;
                            });
                          },
                          buttonTitle: 'دقيق',
                        )
                      ),
                      Expanded(
                        child: SelectionButton(
                          buttonColor: isWheat ? primaryColor : Colors.grey,
                          onPressed: (){
                            setState(() {
                              isWheat = true;
                            });
                          },
                          buttonTitle: 'قمح',
                        )
                      ),
                    ],
                  ),
                  Appspacer(),
                  Row(
                    spacing: 24,
                    children: [
                      Expanded(
                        child: SelectionButton(
                          buttonColor: !isTwo ? primaryColor : Colors.grey,
                          onPressed: (){
                            setState(() {
                              isTwo = false;
                            });
                          },
                          buttonTitle: 'ثلاثة أنواع',
                        )
                      ),
                      Expanded(
                        child: SelectionButton(
                          buttonColor: isTwo ? primaryColor : Colors.grey,
                          onPressed: (){
                            setState(() {
                              isTwo = true;
                            });
                          },
                          buttonTitle: 'نوعين',
                        )
                      ),
                    ],
                  ),
                  Appspacer(),
                  AppTextField(
                    validator: (String? value) {
                      if (value == '0' || value!.isEmpty) {
                        return 'من فضلك أكتب قيمة صحيحة';
                      }
                      return null;
                    },
                    controller: control1,
                    onChanged: (value){
                            firstGluten = double.parse(value);
                    },
                    labelText: 'جلوتين النوع الأول',
                  ),
                  AppTextField(
                    validator: (String? value) {
                      if (value == '0' || value!.isEmpty) {
                        return 'من فضلك أكتب قيمة صحيحة';
                      }
                      return null;
                    },
                    controller: control2,
                    onChanged: (value){
                      secondGluten = double.parse(value);
                    },
                    labelText: 'جلوتين النوع الثاني',
                  ),
                  AppTextField(
                    isEnabled : isTwo ? false : true,
                    validator: (String? value) {
                      if (isTwo) {
                        return null;
                      } else if (value == '0' || value!.isEmpty) {
                        return 'من فضلك أكتب قيمة صحيحة';
                      }
                      return null;
                    },
                    controller: control3,
                    onChanged: (value){
                      thirdGluten = double.parse(value);
                    },
                    labelText: 'جلوتين النوع الثالث',
                  ),
                  AppTextField(
                    validator: (String? value) {
                      if (!isWheat) {
                        if (value == '0' || value!.isEmpty) {
                          return 'من فضلك أكتب قيمة صحيحة';
                        } else if (reqGluten > firstGluten &&
                            reqGluten > secondGluten &&
                            reqGluten > thirdGluten) {
                          return 'قيمة الجلوتين المطلوبة أكبر من جميع القيم الموجودة';
                        } else if (reqGluten < firstGluten &&
                            reqGluten < secondGluten &&
                            reqGluten < thirdGluten &&
                            !isTwo) {
                          return 'قيمة الجلوتين المطلوبة أصغر من جميع القيم الموجودة';
                        } else if (reqGluten < firstGluten &&
                            reqGluten < secondGluten &&
                            isTwo) {
                          return 'قيمة الجلوتين المطلوبة أصغر من جميع القيم الموجودة';
                        }
                      } else {
                        if (value == '0' || value!.isEmpty) {
                          return 'من فضلك أكتب قيمة صحيحة';
                        } else if (reqGluten - 1 > firstGluten &&
                            reqGluten - 1 > secondGluten &&
                            reqGluten - 1 > thirdGluten) {
                          return 'قيمة الجلوتين المطلوبة أكبر من جميع القيم الموجودة';
                        } else if (reqGluten - 1 < firstGluten &&
                            reqGluten - 1 < secondGluten &&
                            reqGluten - 1 < thirdGluten &&
                            !isTwo) {
                          return 'قيمة الجلوتين المطلوبة أصغر من جميع القيم الموجودة';
                        } else if (reqGluten - 1 < firstGluten &&
                            reqGluten - 1 < secondGluten &&
                            isTwo) {
                          return 'قيمة الجلوتين المطلوبة أصغر من جميع القيم الموجودة';
                        }
                      }
                      return null;
                    },
                    controller: control4,
                    onChanged: (value){
                      reqGluten = double.parse(value);
                    },
                    labelText: 'الجلوتين المطلوب',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      spacing: 16,
                      children: [
                        Expanded(
                          child: AppButton(
                              title: "مسح",
                              onPress: () {
                                setState(() {
                                  control1.text = '';
                                  control2.text = '';
                                  control3.text = '';
                                  control4.text = '';
                                });
                              },
                          ),
                        ),
                        Expanded(
                          child: AppButton(
                              title: "يدوي",
                              onPress: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ManPerScreen(),
                                  ),
                                );
                              },
                          ),
                        ),
                        Expanded(
                          child: AppButton(
                              title: "حساب",
                              onPress: () {
                                setState(() {
                                  firstPerc = 0;
                                  secondPerc = 0;
                                  thirdPerc = 0;
                                  resGluten = 0;
                                });
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    if (isTwo) {
                                      calcTwoTypes();
                                    }
                                    else
                                    {
                                      calcThreeTypes();
                                    }
                                  });
                                }
                              },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        ViewResult(
                          flex1: 2,
                          measuredUnit: '%',
                          measuredTitle: 'نسبة النوع الأول',
                          measuredValue: '${(firstPerc * 100).round()}',
                        ),
                        ViewResult(
                          flex1: 2,
                          measuredUnit: '%',
                          measuredTitle: 'نسبة النوع الثاني',
                          measuredValue: '${(secondPerc * 100).round()}',
                        ),
                        SizedBox(
                          height: isTwo ? 0 : 40,
                          child: ViewResult(
                            flex1: 2,
                            measuredUnit: '%',
                            measuredTitle: 'نسبة النوع الثالث',
                            measuredValue: '${(thirdPerc * 100).round()}',
                          ),
                        ),
                        ViewResult(
                          flex1: 2,
                          measuredUnit: '',
                          measuredTitle: 'الجلوتين الفعلي للخليط',
                          measuredValue: '$resGluten',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  calcTwoTypes() {
    if (!isWheat) {
      var diff1 = (reqGluten - firstGluten).abs();
      var diff2 = (reqGluten - secondGluten).abs();
      firstPerc = diff2 / (diff1 + diff2);
      secondPerc = diff1 / (diff1 + diff2);
      resGluten = ((firstPerc * firstGluten) + (secondPerc * secondGluten));
    }
    else {
      var diff1 = (reqGluten - 1 - firstGluten).abs();
      var diff2 = (reqGluten - 1 - secondGluten).abs();
      firstPerc = diff2 / (diff1 + diff2);
      secondPerc = diff1 / (diff1 + diff2);
      resGluten = ((firstPerc * firstGluten) + (secondPerc * secondGluten) + 1);
    }
  }
  calcThreeTypes() {
    if (!isWheat) {
      if (reqGluten > ((firstGluten + secondGluten + thirdGluten)/3)){
        var diff1 = (reqGluten - firstGluten).abs();
        var diff2 = (reqGluten - secondGluten).abs();
        var diff3 = (reqGluten - thirdGluten).abs();
        var diffSum = diff3 + diff2 + diff1 + diff3 ;
        firstPerc = diff3 / diffSum ;
        secondPerc = diff3 / diffSum ;
        thirdPerc = ( diff1 + diff2 )/ diffSum ;
        resGluten = ((firstPerc * firstGluten) + (secondGluten * secondPerc) + (thirdGluten * thirdPerc));
      }
      else if
      (reqGluten <= ((firstGluten + secondGluten + thirdGluten)/3)){
        var diff1 = (reqGluten - firstGluten).abs();
        var diff2 = (reqGluten - secondGluten).abs();
        var diff3 = (reqGluten - thirdGluten).abs();
        var diffSum = diff3 + diff2 + diff1 + diff1 ;
        firstPerc = (diff3+diff2) / diffSum ;
        secondPerc = diff1 / diffSum ;
        thirdPerc =  diff1 / diffSum ;
        resGluten = ((firstPerc * firstGluten) + (secondGluten * secondPerc) + (thirdGluten * thirdPerc));
      }
    }
    if (isWheat) {
      if ((reqGluten-1) > ((firstGluten + secondGluten + thirdGluten)/3)){
        var diff1 = (reqGluten -1- firstGluten).abs();
        var diff2 = (reqGluten -1- secondGluten).abs();
        var diff3 = (reqGluten -1- thirdGluten).abs();
        var diffSum = diff3 + diff2 + diff1 + diff3 ;
        firstPerc = diff3 / diffSum ;
        secondPerc = diff3 / diffSum ;
        thirdPerc = ( diff1 + diff2 )/ diffSum ;
        resGluten = ((firstPerc * firstGluten) + (secondGluten * secondPerc) + (thirdGluten * thirdPerc)+1);
      }
      else if
      ((reqGluten-1) <= ((firstGluten + secondGluten + thirdGluten)/3)){
        var diff1 = (reqGluten -1- firstGluten).abs();
        var diff2 = (reqGluten -1- secondGluten).abs();
        var diff3 = (reqGluten -1- thirdGluten).abs();
        var diffSum = diff3 + diff2 + diff1 + diff1 ;
        firstPerc = (diff3+diff2) / diffSum ;
        secondPerc = diff1 / diffSum ;
        thirdPerc =  diff1 / diffSum ;
        resGluten = ((firstPerc * firstGluten) + (secondGluten * secondPerc) + (thirdGluten * thirdPerc)+1);
      }
    }
  }
}
