import 'package:flutter/material.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_textfield.dart';
import '../../widgets/view_result.dart';

class DoserCalculationsScreen extends StatefulWidget {
  const DoserCalculationsScreen({super.key});

  @override
  State<DoserCalculationsScreen> createState() => _DoserCalculationsScreenState();
}

class _DoserCalculationsScreenState extends State<DoserCalculationsScreen> {

  var formKey = GlobalKey<FormState>();

  var control1 = TextEditingController(),
      control2 = TextEditingController();

  double vitamenPerMin = 0 ;
  late double flourCapacityTonPerHour , vitamenCapacityPerTon;

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
                    flourCapacityTonPerHour = double.parse(value!);
                  });
                },
                labelText: 'قدرة الدقيق بالمطحن ( طن/ساعة)  ',
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
                vitamenCapacityPerTon= double.parse(value);
              },
              labelText: 'كمية المحسن بالجرام لكل طن دقيق',
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
                            vitamenPerMin =( flourCapacityTonPerHour * vitamenCapacityPerTon ) / 60;
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
                    measuredTitle: 'كمية المحسن',
                    measuredUnit: 'جرام / دقيقة',
                    measuredValue: '${double.parse((vitamenPerMin).toStringAsFixed(2))}',
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
