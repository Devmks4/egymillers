import 'package:egymillers/shared/styles/colors.dart';
import 'package:egymillers/widgets/app_button.dart';
import 'package:egymillers/widgets/view_result.dart';
import 'package:flutter/material.dart';

import '../widgets/app_textfield.dart';

class PlansifterCalculationScreen extends StatefulWidget {
  const PlansifterCalculationScreen({super.key});

  @override
  State<PlansifterCalculationScreen> createState() => _PlansifterCalculationScreenState();
}

class _PlansifterCalculationScreenState extends State<PlansifterCalculationScreen> {
  double numberOfPlansiters = 0;
  double numberOfSections = 0;
  double numberOfSims = 0;
  double areaOfSim = 0.23;
  double capacity = 0;
  double plansiftingArea = 0;
  var numberOfPlansitersController = TextEditingController(),
      numberOfSectionsController = TextEditingController(),
      numberOfSimsController = TextEditingController(),
      areaOfSimController = TextEditingController(),
      capacityController = TextEditingController();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    areaOfSimController.text = '0.23';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackGround,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text(
          'حساب مسطح النخل',
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
                SizedBox(height: 16),
                AppTextField(
                  controller: numberOfPlansitersController,
                  onChanged: (value){
                    numberOfPlansiters = double.parse(value);
                  },
                  labelText: 'أدخل عدد المناخل',
                  validator: (String? value)=>null,
                ),
                AppTextField(
                  controller: numberOfSectionsController,
                  onChanged: (value) {
                    numberOfSections = double.parse(value);
                  },
                  labelText: 'أدخل عدد أقسام المنخل',
                  validator: (String? value){
                    return null;
                  },
                ),
                AppTextField(
                  controller: numberOfSimsController,
                  onChanged: (value) {
                    numberOfSims = double.parse(value);
                  },
                  labelText: 'أدخل عدد الشرائح لكل قسم',
                  validator: (String? value){
                    return null;
                  },
                ),
                AppTextField(
                  controller: areaOfSimController,
                  onChanged: (value) {
                    areaOfSim = double.parse(value);
                  },
                  labelText: 'أدخل مساحة الشريحة',
                  validator: (String? value){
                    return null;
                  },
                ),
                AppTextField(
                  controller: capacityController,
                  onChanged: (value) {
                    capacity = double.parse(value);
                  },
                  labelText: 'أدخل قدرة المطحن بالطن ساعة',
                  validator: (String? value){
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    spacing: 24,
                    children: [
                      Expanded(
                        child: AppButton(
                          title: "مسح",
                          onPress: () {
                            setState(() {
                              numberOfPlansiters = 0;
                              numberOfSections = 0;
                              numberOfSims = 0;
                              areaOfSim = 0.23;
                              capacity = 0;
                              plansiftingArea = 0;
                              numberOfPlansitersController.text = '';
                              numberOfSectionsController.text = '';
                              numberOfSimsController.text = '';
                              areaOfSimController.text = '0.23';
                              capacityController.text = '';
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: AppButton(
                          title: "حساب",
                          onPress: () {
                            if (numberOfPlansiters != 0 && numberOfSections != 0 && capacity != 0 && numberOfSims != 0 && areaOfSim != 0)
                            {setState(() {
                              plansiftingArea =
                              ((numberOfPlansiters * numberOfSections * numberOfSims * areaOfSim) / (capacity));
                            });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: ViewResult(
                      flex2: 2,
                      measuredUnit: 'مم/100 كجم/اليوم',
                      measuredTitle: 'مسطح النخل',
                      measuredValue: plansiftingArea.toStringAsFixed(3),
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