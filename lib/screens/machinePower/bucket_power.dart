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
  var productType = ['قمح صلب', 'قمح سوفت', 'ردة خشنة', 'ردة ناعمة', 'دقيق 72', 'دقيق 82', 'سن'];
  Map <String , int> productSWeight = {
    'قمح صلب' : 850,
    'قمح سوفت':760,
    'ردة خشنة':230,
    'ردة ناعمة':330,
    'دقيق 72':580,
    'دقيق 82':500,
    'سن':400 };
  String dropdownvalue = 'قمح صلب';
  int productSpecificWeight = 850;
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
              labelText: 'سرعة عمود دوران جيربوكس المحرك',
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
                bucketGearToothNumber= double.parse(value);
              },
              labelText: 'عدد أسنان الترس',
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
                          dropdownvalue = 'قمح صلب';
                          control1.text = '850';
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
                            machineCapacity = bucketWidth * bucketHeight * bucketFillFactor * linearSpeed * productSpecificWeight * 3.6 / 10000 ;
                            motorPower = machineCapacity * bucketLength / 240 ;
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
