import 'package:flutter/material.dart';

import '../../widgets/app_button.dart';
import '../../widgets/app_textfield.dart';
import '../../widgets/view_result.dart';

class AshCalculationScreen extends StatefulWidget {
  const AshCalculationScreen({super.key});

  @override
  State<AshCalculationScreen> createState() => _AshCalculationScreenState();
}

class _AshCalculationScreenState extends State<AshCalculationScreen> {
  var formKey = GlobalKey<FormState>();
  var control1 = TextEditingController(),
      control2 = TextEditingController(),
      control3 = TextEditingController(),
      control4 = TextEditingController();
  double dryAsh = 0 ,
         wetAsh = 0 ;
  late double botqaWeight,
              afterBurnWeight,
              beforeBurnWeight,
              moisture = 14;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    control4.text = moisture.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          spacing: 24,
          children: [
            AppTextField(
                controller: control1,
                onChanged: (String? value){
                  setState(() {
                    beforeBurnWeight = double.parse(value!);
                  });
                },
                labelText: 'وزن عينة الدقيق بالجرام',
                validator: (String? value){
                  if (value!.isEmpty) {
                  return 'من فضلك أكتب قيمة صحيحة';
                }
                return null;
                }
            ),
            AppTextField(
              controller: control2,
              onChanged: (String value){
                afterBurnWeight= double.parse(value);
              },
              labelText: 'وزن العينة بعد الحرق بالبوتقة بالجرام',
              validator: (String? value){
                if (value!.isEmpty) {
                return 'من فضلك أكتب قيمة صحيحة';
              }
              return null;
                },
            ),
            AppTextField(
              controller: control3,
              onChanged: (String value){
                botqaWeight= double.parse(value);
              },
              labelText: 'وزن البوتقة فارغة بالجرام',
              validator: (String? value){
                if (value!.isEmpty) {
                  return 'من فضلك أكتب قيمة صحيحة';
                }
                return null;
              },
            ),
            AppTextField(
              controller: control4,
              onChanged: (String value){
                moisture= double.parse(value);
              },
              labelText: 'رطوبة العينة',
              validator: (String? value){
                if (value!.isEmpty) {
                  return 'من فضلك أكتب قيمة صحيحة';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top:14.0),
              child: Row(
                children: [
                  Expanded(
                    child:AppButton(
                      title: "مسح",
                      onPress: (){
                        setState(() {
                          control1.text = '';
                          control2.text = '';
                          control3.text = '';
                          control4.text = '14';
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child:AppButton(
                      title: "حساب",
                      onPress: (){
                        if (formKey.currentState!.validate()){
                          setState(() {
                            dryAsh = (afterBurnWeight - botqaWeight) / (beforeBurnWeight - (beforeBurnWeight * 0.01 * moisture)) ;
                            wetAsh = (afterBurnWeight - botqaWeight) / beforeBurnWeight;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:14.0,bottom: 32),
              child: Column(
                spacing: 12,
                children: [
                  ViewResult(
                    measuredTitle: 'الرماد الجاف',
                    measuredUnit: '%',
                    measuredValue: '${double.parse((dryAsh * 100).toStringAsFixed(2))}',
                  ),
                  ViewResult(
                    measuredTitle: 'الرماد الرطب',
                    measuredUnit: '%',
                    measuredValue: '${double.parse((wetAsh * 100).toStringAsFixed(2))}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
