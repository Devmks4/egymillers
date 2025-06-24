import 'package:egymillers/widgets/view_result.dart';
import 'package:flutter/material.dart';
import 'package:egymillers/shared/styles/colors.dart';
import '../widgets/app_button.dart';
import '../widgets/app_textfield.dart';

class WaterAddScreen extends StatefulWidget {
  const WaterAddScreen({super.key});

  @override
  State<WaterAddScreen> createState() => _WaterAddScreenState();
}

class _WaterAddScreenState extends State<WaterAddScreen> {
  double rawWheatMoisture = 0;
  double b1RequiredMoisture = 0;
  double capacity = 0;
  double addedWater = 0;
  var rawWheatController = TextEditingController(),
      b1controller = TextEditingController(),
      capacityController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackGround,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text(
          'حساب مياه الترطيب',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                spacing: 20,
                children: [
                  SizedBox(height: 16,),
                  AppTextField(
                    validator: (String? value) => null,
                    controller: rawWheatController,
                    onChanged: (value) {
                      rawWheatMoisture = double.parse(value);
                    },
                    labelText: 'أدخل رطوبة القمح الابتدائية',
                  ),
                  AppTextField(
                    validator: (String? value) {
                      if (value == '100' ) {
                        return 'من فضلك أكتب قيمة صحيحة';
                      }
                      return null;
                    },
                    controller: b1controller,
                    onChanged: (value) {
                      b1RequiredMoisture = double.parse(value);
                    },
                    labelText: 'أدخل رطوبة القمح لل B1',
                  ),
                  AppTextField(
                    validator: (String? value) => null,
                    controller: capacityController,
                    onChanged: (value) {
                      capacity = double.parse(value);
                    },
                    labelText: 'أدخل قدرة خط الترطيب بالطن /ساعة',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:6.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: AppButton(
                             title: 'مسح',
                             onPress: () {
                               setState(() {
                                 addedWater = 0;
                                 rawWheatController.text = '';
                                 b1controller.text = '';
                                 capacityController.text = '';
                               });
                             },
                            ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: AppButton(
                          title: 'حساب',
                          onPress: () {
                            setState(() {
                                  if (formKey.currentState!.validate()) {
                                    addedWater =
                                    (((b1RequiredMoisture - rawWheatMoisture) * capacity * 1000) /
                                        (100 - b1RequiredMoisture));
                                  }
                            });
                          },
                        ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:6.0),
                    child: ViewResult(
                        flex1: 2,
                        measuredUnit: 'لتر / ساعة',
                        measuredTitle: 'كمية المياه المطلوبة',
                        measuredValue: '${addedWater.round()}',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:6.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset(
                        'assets/images/info/dampeningLaw.png',
                        fit: BoxFit.contain,
                      ),
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
}
