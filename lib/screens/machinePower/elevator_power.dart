import 'package:flutter/material.dart';
import '../../shared/styles/colors.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_textfield.dart';
import '../../widgets/selection_button.dart';
import '../../widgets/view_result.dart';

class ElevatorPower extends StatefulWidget {
  const ElevatorPower({super.key});

  @override
  State<ElevatorPower> createState() => _ElevatorPowerState();
}

class _ElevatorPowerState extends State<ElevatorPower> {
  var formKey = GlobalKey<FormState>();
  var control1 = TextEditingController(),
      control2 = TextEditingController(),
      control3 = TextEditingController(),
      control4 = TextEditingController(),
      control5 = TextEditingController();
  double machineCapacity = 0 ,
         machinePower = 0 ,
         motorPower = 0 ;
  late double
      elevatorDiameter,
      elevatorGearBoxSpeed,
      productWeightInBucket,
      noOfBucketsInOneMeter,
      elevatorHeight;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          spacing: 12,
          children: [
            AppTextField(
              controller: control1,
              onChanged: (String value){
                elevatorDiameter= double.parse(value);
              },
              labelText: 'قطر طارة الساقية بالمتر',
              validator: (String? value){return null;},
            ),
            AppTextField(
              controller: control2,
              onChanged: (String value){
                elevatorGearBoxSpeed= double.parse(value);
              },
              labelText: 'سرعة جيربوكس المحرك',
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
                noOfBucketsInOneMeter= double.parse(value);
              },
              labelText: 'عدد القواديس في المتر الواحد',
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
                productWeightInBucket= double.parse(value);
              },
              labelText: 'وزن المنتج داخل القادوس بالجرام',
              validator: (String? value){
                if (value!.isEmpty) {
                  return 'من فضلك أكتب قيمة صحيحة';
                }
                return null;
              },
            ),
            AppTextField(
              controller: control5,
              onChanged: (String value){
                elevatorHeight= double.parse(value);
              },
              labelText: 'ارتفاع الساقية بالمتر',
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
                          control4.text = '';
                          control5.text = '';
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
                            machineCapacity = (3.14 * elevatorDiameter * elevatorGearBoxSpeed * noOfBucketsInOneMeter * productWeightInBucket * 0.001 * 0.8 * 0.9 * 3.6) / 60;
                            motorPower = ( machineCapacity * elevatorHeight ) / 160 ;
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
                    measuredTitle: 'قدرة الساقية',
                    measuredUnit: 'طن / ساعة',
                    measuredValue: '${machineCapacity.round()}',
                  ),
                  ViewResult(
                    measuredTitle: 'قدرة المحرك',
                    measuredUnit: 'كيلووات',
                    measuredValue: '${motorPower}',
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
