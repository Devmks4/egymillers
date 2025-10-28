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

  double noOf80CmCylinders = 0 ,  noOf100CmCylinders = 0 ,  noOf125CmCylinders = 0 ,  noOf150CmCylinders = 0 ;
  double capacity = 0;
  double millingLength = 0;

  var numberOf80CmCylindersController  = TextEditingController(),
      numberOf100CmCylindersController = TextEditingController(),
      numberOf125CmCylindersController = TextEditingController(),
      numberOf150CmCylindersController = TextEditingController(),
      capacityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackGround,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text(
          'حساب طول الطحن',
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
                Text('ملحوظة هامة : الوحدة هي جنب واحد من السلندر وليس السلندر كامل ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green[600],
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  spacing: 24,
                  children: [
                    Expanded(
                      child: AppTextField(
                        validator: (String? value) => null,
                        controller: numberOf80CmCylindersController,
                        onChanged: (value) {
                          noOf80CmCylinders = double.parse(value);
                        },
                        labelText: 'العدد',
                      ),
                    ),
                    Text(
                      'عدد الوحدات طول 80 سم',
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 24,
                  children: [
                    Expanded(
                      child: AppTextField(
                        validator: (String? value) => null,
                        controller: numberOf100CmCylindersController,
                        onChanged: (value) {
                          noOf100CmCylinders = double.parse(value);
                        },
                        labelText: 'العدد',
                      ),
                    ),
                    Text(
                      'عدد الوحدات طول 100 سم',
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 24,
                  children: [
                    Expanded(
                      child: AppTextField(
                        validator: (String? value) => null,
                        controller: numberOf125CmCylindersController,
                        onChanged: (value) {
                          noOf125CmCylinders = double.parse(value);
                        },
                        labelText: 'العدد',
                      ),
                    ),
                    Text(
                      'عدد الوحدات طول 125 سم',
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 24,
                  children: [
                    Expanded(
                      child: AppTextField(
                        validator: (String? value) => null,
                        controller: numberOf150CmCylindersController,
                        onChanged: (value) {
                          noOf150CmCylinders = double.parse(value);
                        },
                        labelText: 'العدد',
                      ),
                    ),
                    Text(
                      'عدد الوحدات طول 150 سم',
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
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
                                            noOf80CmCylinders = 0;
                                            noOf100CmCylinders = 0;
                                            noOf125CmCylinders = 0;
                                            noOf150CmCylinders = 0;
                                            capacity = 0;
                                            millingLength = 0;
                                            numberOf80CmCylindersController.text = '';
                                            numberOf100CmCylindersController.text = '';
                                            numberOf125CmCylindersController.text = '';
                                            numberOf150CmCylindersController.text = '';
                                            capacityController.text = '';
                                            });
                              },
                        )
                      ),
                      Expanded(
                        child: AppButton(
                            title: "حساب",
                            onPress: () {
                              if ( noOf80CmCylinders == 0 && noOf100CmCylinders == 0 && noOf125CmCylinders == 0 && noOf150CmCylinders == 0 ){}
                              else if (capacity == 0){}
                              else
                              {setState(() {
                                millingLength =
                                     ((noOf80CmCylinders * 80 ) / (capacity))+
                                         ((noOf100CmCylinders * 100) / (capacity))+
                                             ((noOf125CmCylinders * 125) / (capacity))+
                                                 ((noOf150CmCylinders * 150) / (capacity));
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
                      measuredTitle: 'طول الطحن',
                      measuredValue: millingLength.toStringAsFixed(1),
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