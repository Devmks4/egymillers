import 'package:flutter/material.dart';

import '../../shared/styles/colors.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_textfield.dart';
import '../../widgets/selection_button.dart';
import '../../widgets/view_result.dart';

class ConveyorPower extends StatefulWidget {
  const ConveyorPower({super.key});

  @override
  State<ConveyorPower> createState() => _ConveyorPowerState();
}

class _ConveyorPowerState extends State<ConveyorPower> {
  var formKey = GlobalKey<FormState>();
  var productType = [
    'قمح صلب',
    'قمح سوفت',
    'ردة خشنة',
    'ردة ناعمة',
    'دقيق 72',
    'دقيق 82',
    'سن'
  ];
  Map <String, int> productSWeight = {
    'قمح صلب': 850,
    'قمح سوفت': 760,
    'ردة خشنة': 230,
    'ردة ناعمة': 330,
    'دقيق 72': 580,
    'دقيق 82': 500,
    'سن': 400};
  String dropdownvalue = 'قمح صلب';
  int productSpecificWeight = 850;
  var control1 = TextEditingController(),
      control2 = TextEditingController(),
      control3 = TextEditingController(),
      control4 = TextEditingController(),
      control5 = TextEditingController();

  double machineCapacity = 0,
         machinePower = 0,
         motorPower = 0;

  late double
      conveyorDiameter,
      conveyorStep,
      conveyorMotorGearBoxSpeed,
      conveyorTypeFactor = 0.45,
      conveyorLength;
  int conveyorType = 0;
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
            Row(
              spacing: 8,
              children: [
                SizedBox(
                  width: 150,
                  child:AppTextField(
                      controller: control1,
                      onChanged: (String? value){
                        setState(() {
                          productSpecificWeight = int.parse(value!);
                        });
                      },
                      labelText: 'الوزن النوعي',
                      validator: (String? value){return null;}
                  ) ,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        color: scaffoldBackGround,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: DropdownButton(
                        isExpanded: true,
                        underline: SizedBox(),
                        value: dropdownvalue,
                        icon: Icon(Icons.keyboard_arrow_down,color: primaryColor,),
                        iconSize: 32,
                        borderRadius: BorderRadius.circular(10),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        alignment: Alignment.center,
                        items: productType.map((String measureType) {
                          return DropdownMenuItem(
                            value: measureType,
                            child: Text(measureType),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownvalue = value!;
                            productSpecificWeight = productSWeight[dropdownvalue]!;
                            control1.text = productSpecificWeight.toString();
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Text(
                  'نوع المنتج',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              spacing: 8,
              children: [
                Expanded(
                    child: SelectionButton(
                      buttonColor: conveyorType == 3 ? primaryColor : Colors.grey,
                      onPressed: (){
                        setState(() {
                          conveyorTypeFactor = 0.17;
                          conveyorType = 3;
                        });
                      },
                      buttonTitle: 'بريمة مخلفات',
                    )
                ),
                Expanded(
                    child: SelectionButton(
                      buttonColor: conveyorType == 2 ? primaryColor : Colors.grey,
                      onPressed: (){
                        setState(() {
                          conveyorTypeFactor = 0.9;
                          conveyorType = 2;
                        });
                      },
                      buttonTitle: 'بريمة أنبوبية',
                    )
                ),
                Expanded(
                    child: SelectionButton(
                      buttonColor: conveyorType == 1 ? primaryColor : Colors.grey,
                      onPressed: (){
                        setState(() {
                          conveyorTypeFactor = 0.45;
                          conveyorType = 1;
                        });
                      },
                      buttonTitle: 'بريمة عادية',
                    )
                ),
              ],
            ),
            AppTextField(
              controller: control2,
              onChanged: (String value){
                conveyorDiameter= double.parse(value);
              },
              labelText: 'قطر البريمة بالسنتيمتر',
              validator: (String? value){return null;},
            ),
            AppTextField(
              controller: control3,
              onChanged: (String value){
                conveyorStep= double.parse(value);
              },
              labelText: 'خطوة البريمة بالسنتيمتر',
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
                conveyorMotorGearBoxSpeed= double.parse(value);
              },
              labelText: 'سرعة دوران جيربوكس المحرك',
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
                conveyorLength= double.parse(value);
              },
              labelText: 'طول البريمة بالمتر',
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
                          dropdownvalue = 'قمح صلب';
                          control1.text = '850';
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

                          var area = 3.14 * (( 0.01 * conveyorDiameter * 0.01 * conveyorDiameter ) / 4 );
                          setState(() {
                            machineCapacity = area * 0.01 * conveyorStep * conveyorMotorGearBoxSpeed * conveyorTypeFactor * productSpecificWeight * 0.06 ;
                            motorPower = machineCapacity * conveyorLength / 110 ;
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
                    measuredTitle: 'قدرة البريمة',
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
