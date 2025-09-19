import 'package:flutter/material.dart';

import '../../shared/styles/colors.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_textfield.dart';
import '../../widgets/selection_button.dart';
import '../../widgets/view_result.dart';

class BucketPower extends StatefulWidget {
  const BucketPower({super.key});

  @override
  State<BucketPower> createState() => _BucketPowerState();
}

class _BucketPowerState extends State<BucketPower> {
  var formKey = GlobalKey<FormState>();
  int productSpecificWeight = 750;
  var control1 = TextEditingController(),
      control2 = TextEditingController(),
      control3 = TextEditingController(),
      control4 = TextEditingController(),
      control5 = TextEditingController(),
      control6 = TextEditingController(),
      control7 = TextEditingController();
  double machineCapacity = 0 ,
         machinePower = 0 ,
         motorPower = 0 ;
  late double bucketWidth,
              bucketHeight,
              bucketMotorGearboxShaftSpeed,
              bucketFillFactor = 0.7,
              bucketGearToothNumber,
              bucketLength,
              bucketSliderStep;
  bool isTruck = true;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    control1.text = productSpecificWeight.toString();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          spacing: 12,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:6.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  'assets/images/info/bucket.jpg',
                  fit: BoxFit.contain,
                  height: 150,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            AppTextField(
                controller: control1,
                onChanged: (String? value){
                  setState(() {
                    productSpecificWeight = int.parse(value!);
                  });
                },
                labelText: 'الوزن النوعي كجم / م3',
                validator: (String? value){return null;}
            ),
            Row(
              spacing: 24,
              children: [
                Expanded(
                    child: SelectionButton(
                      buttonColor: !isTruck ? primaryColor : Colors.grey,
                      onPressed: (){
                        setState(() {
                          isTruck = false;
                          bucketFillFactor = 0.9;
                        });
                      },
                      buttonTitle: 'كاتينة نقل',
                    )
                ),
                Expanded(
                    child: SelectionButton(
                      buttonColor: isTruck ? primaryColor : Colors.grey,
                      onPressed: (){
                        setState(() {
                          isTruck = true;
                          bucketFillFactor = 0.7;
                        });
                      },
                      buttonTitle: 'كاتينة نقرة',
                    )
                ),
              ],
            ),
            AppTextField(
              controller: control2,
              onChanged: (String value){
                bucketWidth= double.parse(value);
              },
              labelText: 'عرض حوض الكاتينة بالسنتيمتر',
              validator: (String? value){return null;},
            ),
            AppTextField(
              controller: control3,
              onChanged: (String value){
                bucketHeight= double.parse(value);
              },
              labelText: 'ارتفاع حوض الكاتينة بالسنتيمتر',
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
                bucketMotorGearboxShaftSpeed= double.parse(value);
              },
              labelText: 'سرعة دوران ترس الجرار',
              validator: (String? value){
                if (value!.isEmpty) {
                  return 'من فضلك أكتب قيمة صحيحة';
                }
                return null;
              },
            ),
            Text(
              'لمعرفة سرعة دوران ترس الجرار .. 1- في حالة تركيب جير بوكس الموتور مباشرة على عمود ترس الجرار تكون السرعة هي سرعة جيربوكس الموتور .. 2- أما في حالة الربط بينهم بسيور أو جنزير فتكون السرعة تساوي سرعة جيربوكس الموتور مضروبة في قطر طنبورة جيربوكس الموتور و مقسومة على قطر طنبورة عمود ترس الجرار',
              textAlign: TextAlign.center,style: TextStyle(color: Colors.red[600]
            ),
            ),
            AppTextField(
              controller: control5,
              onChanged: (String value){
                bucketGearToothNumber= double.parse(value);
              },
              labelText: 'عدد أسنان ترس الجرار',
              validator: (String? value){
                if (value!.isEmpty) {
                  return 'من فضلك أكتب قيمة صحيحة';
                }
                return null;
              },
            ),
            AppTextField(
              controller: control6,
              onChanged: (String value){
                bucketSliderStep= double.parse(value);
              },
              labelText: 'خطوة الجرار بالسنتيمتر',
              validator: (String? value){
                if (value!.isEmpty) {
                  return 'من فضلك أكتب قيمة صحيحة';
                }
                return null;
              },
            ),
            AppTextField(
              controller: control7,
              onChanged: (String value){
                bucketLength= double.parse(value);
              },
              labelText: 'طول الكاتينة بالمتر',
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
                          control1.text = '750';
                          control2.text = '';
                          control3.text = '';
                          control4.text = '';
                          control5.text = '';
                          control6.text = '';
                          control7.text = '';
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
                          var linearSpeed = bucketGearToothNumber * bucketMotorGearboxShaftSpeed * bucketSliderStep / 6000 ;
                          setState(() {
                            machineCapacity = 0.01 * bucketWidth * 0.01 * bucketHeight * bucketFillFactor * linearSpeed * productSpecificWeight * 3.6 ;
                            motorPower = machineCapacity * bucketLength / 240 ;
                            if (motorPower <= 0.55 ) { motorPower = 0.55;}
                            else if (motorPower > 0.55 && motorPower <= 0.75) { motorPower = 0.75;}
                            else if (motorPower > 0.75 && motorPower <= 1.1) { motorPower = 1.1;}
                            else if (motorPower > 1.1 && motorPower <= 1.5) { motorPower = 1.5;}
                            else if (motorPower > 1.5 && motorPower <= 2.2) { motorPower = 2.2;}
                            else if (motorPower > 2.2 && motorPower <= 3) { motorPower = 3;}
                            else if (motorPower > 3 && motorPower <= 4) { motorPower = 4;}
                            else if (motorPower > 4 && motorPower <= 5.5) { motorPower = 5.5;}
                            else if (motorPower > 5.5 && motorPower <= 7.5) { motorPower = 7.5;}
                            else if (motorPower > 7.5 && motorPower <= 11) { motorPower = 11;}
                            else if (motorPower > 11 && motorPower <= 15) { motorPower = 15;}
                            else if (motorPower > 15 && motorPower <= 18.5) { motorPower = 18.5;}
                            else if (motorPower > 18.5 && motorPower <= 22) { motorPower = 22;}
                            else if (motorPower > 22 && motorPower <= 30) { motorPower = 30;}
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
                    measuredTitle: 'قدرة الكاتينة',
                    measuredUnit: 'طن / ساعة',
                    measuredValue: '${machineCapacity.round()}',
                  ),
                  ViewResult(
                    measuredTitle: 'قدرة المحرك',
                    measuredUnit: 'كيلووات',
                    measuredValue: '${motorPower.round()}',
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
