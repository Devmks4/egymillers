import 'package:egymillers/shared/styles/colors.dart';
import 'package:egymillers/widgets/app_button.dart';
import 'package:egymillers/widgets/app_textfield.dart';
import 'package:egymillers/widgets/view_result.dart';
import 'package:flutter/material.dart';

class ReleaseScreen extends StatefulWidget {
  const ReleaseScreen({super.key});

  @override
  _ReleaseScreen createState() => _ReleaseScreen();
}

class _ReleaseScreen extends State<ReleaseScreen> {
  double totalAmount = 0;
  double throughAmount = 0;
  double releasePercent = 0;
  var control1 = TextEditingController(), control2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackGround,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'حساب نسبة الريليز',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 16,),
              AppTextField(
                  controller: control1,
                  onChanged: (value) {
                    totalAmount = double.parse(value);
                  },
                  labelText: 'أدخل كمية العينة الكلية',
                  validator: (value)=>null,
              ),
              AppTextField(
                controller: control2,
                onChanged: (value) {
                  throughAmount = double.parse(value);
                },
                labelText: 'أدخل الكمية النافذة من المنخل',
                validator: (value)=>null,
              ),
              Padding(
                padding: const EdgeInsets.only(top:4.0),
                child: Row(
                  spacing: 24,
                  children: [
                    Expanded(
                      child: AppButton(
                          title: "مسح",
                          onPress: () {
                            setState(() {
                              releasePercent = 0;
                              control1.text = '';
                              control2.text = '';
                            });
                          },
                      ),
                    ),
                    Expanded(
                      child: AppButton(
                        title: "حساب",
                        onPress: () {
                          setState(() {
                            if (throughAmount != 0 && totalAmount != 0) {
                              releasePercent =
                              ((throughAmount / totalAmount) * 100);
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: ViewResult(
                    measuredUnit: ' % ',
                    measuredTitle: 'نسبة الريليز ',
                    measuredValue: '${releasePercent.round()}',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
