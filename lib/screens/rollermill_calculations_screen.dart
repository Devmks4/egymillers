import 'package:egymillers/shared/styles/colors.dart';
import 'package:egymillers/widgets/app_button.dart';
import 'package:egymillers/widgets/view_result.dart';
import 'package:flutter/material.dart';

import '../widgets/app_textfield.dart';

class RollermillCalculationsScreen extends StatefulWidget {
  const RollermillCalculationsScreen({super.key});

  @override
  State<RollermillCalculationsScreen> createState() => _RollermillCalculationsScreenState();
}

class _RollermillCalculationsScreenState extends State<RollermillCalculationsScreen> {
  double numberOfCylinders = 0;
  double lengthOfCylinder = 0;
  double capacity = 0;
  double millingArea = 0;
  var numberOfCylindersController = TextEditingController(),
      lengthOfCylinderController = TextEditingController(),
      capacityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackGround,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text(
          'حساب مسطح الطحن',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              spacing: 16,
              children: [
                SizedBox(height: 16,),
                AppTextField(
                  validator: (String? value) => null,
                  controller: numberOfCylindersController,
                  onChanged: (value) {
                    numberOfCylinders = double.parse(value);
                  },
                  labelText: 'أدخل عدد السلندرات',
                ),
                AppTextField(
                  validator: (String? value) => null,
                  controller: lengthOfCylinderController,
                  onChanged: (value) {
                    lengthOfCylinder = double.parse(value);
                  },
                  labelText: 'أدخل طول السلندر بالميلليمتر',
                ),
                AppTextField(
                  validator: (String? value) => null,
                  controller: capacityController,
                  onChanged: (value) {
                    capacity = double.parse(value);
                  },
                  labelText: 'أدخل قدرة المطحن بالطن /اليوم',
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
                                            numberOfCylinders = 0;
                                            lengthOfCylinder = 0;
                                            capacity = 0;
                                            millingArea = 0;
                                            numberOfCylindersController.text = '';
                                            lengthOfCylinderController.text = '';
                                            capacityController.text = '';
                                            });
                              },
                        )
                      ),
                      Expanded(
                        child: AppButton(
                            title: "حساب",
                            onPress: () {
                              if (numberOfCylinders != 0 && lengthOfCylinder != 0 && capacity != 0)
                              {setState(() {
                                millingArea =
                                ((2 * numberOfCylinders * lengthOfCylinder) / (10 * capacity));
                              });
                              }
                            },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:4.0),
                  child: ViewResult(
                      flex2: 2,
                      measuredUnit: 'مم/100 كجم/اليوم',
                      measuredTitle: 'مسطح الطحن',
                      measuredValue: '${millingArea.round()}',
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}