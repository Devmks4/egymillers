import 'package:egymillers/shared/styles/colors.dart';
import 'package:egymillers/widgets/app_button.dart';
import 'package:egymillers/widgets/app_textfield.dart';
import 'package:egymillers/widgets/view_result.dart';
import 'package:flutter/material.dart';

class ManPerScreen extends StatefulWidget {
  const ManPerScreen({super.key});

  @override
  _ManPerScreen createState() => _ManPerScreen();
}

class _ManPerScreen extends State<ManPerScreen> {
  double firstGluten = 0, firstPerc = 0;
  double secondGluten = 0, secondPerc = 0;
  double thirdGluten = 0, thirdPerc = 0;
  double result = 0;
  var control1 = TextEditingController(),
      control2 = TextEditingController(),
      control3 = TextEditingController();
  var control4 = TextEditingController(),
      control5 = TextEditingController(),
      control6 = TextEditingController();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackGround,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'حساب يدوي للخليط ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              spacing: 16,
              children: [
                Row(
                  spacing: 24,
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: control1,
                        onChanged: (value) {
                          firstPerc = double.parse(value);
                        },
                        labelText: 'النسبة',
                        validator: (value)=>null,
                      ),
                    ),
                    Expanded(
                      child: AppTextField(
                        controller: control2,
                        onChanged: (value) {
                          firstGluten = double.parse(value);
                        },
                        labelText: 'الجلوتين',
                        validator: (value)=>null,
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 24,
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: control3,
                        onChanged: (value) {
                          secondPerc = double.parse(value);
                        },
                        labelText: 'النسبة',
                        validator: (value)=>null,
                      ),
                    ),
                    Expanded(
                      child: AppTextField(
                        controller: control4,
                        onChanged: (value) {
                          secondGluten = double.parse(value);
                        },
                        labelText: 'الجلوتين',
                        validator: (value)=>null,
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 24,
                  children: [
                      Expanded(
                        child: AppTextField(
                            controller: control5,
                            onChanged: (value) {
                                    thirdPerc = double.parse(value);
                                    },
                            labelText: 'النسبة',
                            validator: (value)=>null,
                        ),
                      ),
                      Expanded(
                        child: AppTextField(
                          controller: control6,
                          onChanged: (value) {
                           thirdGluten = double.parse(value);
                            },
                          labelText: 'الجلوتين',
                          validator: (value)=>null,
                                            ),
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    spacing: 24,
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
                                control5.text = '';
                                control6.text = '';
                                firstGluten = 0;
                                firstPerc = 0;
                                secondGluten = 0;
                                secondPerc = 0;
                                thirdGluten = 0;
                                thirdPerc = 0;
                                result = 0;
                                errorMessage = '';
                              });
                            },
                        ),
                      ),
                      Expanded(
                        child: AppButton(
                            title: "حساب",
                            onPress: () {
                              setState(() {
                                if ((firstPerc + secondPerc + thirdPerc > 100)) {
                                  errorMessage = 'مجموع نسب الخليط أكبر من المائة';
                                } else if ((firstPerc + secondPerc + thirdPerc <
                                    100)) {
                                  errorMessage = 'مجموع نسب الخليط أصغر من المائة';
                                } else {
                                  errorMessage = '';
                                  result = 0.01 *
                                      ((firstGluten * firstPerc) +
                                          (secondGluten * secondPerc) +
                                          (thirdGluten * thirdPerc));
                                }
                              });
                            },
                        ),
                      ),
                    ],
                  ),
                ),
                ViewResult(
                    flex1: 2,
                    measuredUnit: '',
                    measuredTitle: 'جلوتين الخيط يساوي',
                    measuredValue: '${double.parse((result).toStringAsFixed(1))}',
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
