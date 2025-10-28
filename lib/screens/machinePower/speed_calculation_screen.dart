import 'package:flutter/material.dart';
import '../../shared/styles/colors.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_textfield.dart';
import '../../widgets/app_widgets.dart';
import '../../widgets/selection_button.dart';
import '../../widgets/view_result.dart';

class SpeedCalculationScreen extends StatefulWidget {
  const SpeedCalculationScreen({super.key});

  @override
  State<SpeedCalculationScreen> createState() => _SpeedCalculationScreenState();
}

class _SpeedCalculationScreenState extends State<SpeedCalculationScreen> {
  var formKey = GlobalKey<FormState>();
  var calculationType = [
    'الجيربوكس',
    'الطنابير',
    ];
    String dropdownvalue = 'الجيربوكس';
    int selectedIndex=0;
    var calculationScreen = [GearBoxSpeedCalculation(),TanabeerSpeedCalculation()];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(

      spacing: 12,
         children: [
           Row(
             spacing: 24,
             children: [
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
                         fontSize: 16,
                         fontWeight: FontWeight.bold,
                         color: primaryColor,
                       ),
                       alignment: Alignment.center,
                       items: calculationType.map((String calculationType) {
                         return DropdownMenuItem(
                           value: calculationType,
                           child: Text(calculationType),
                         );
                       }).toList(),
                       onChanged: (String? value) {
                         setState(() {
                           dropdownvalue = value!;
                           selectedIndex = calculationType.indexOf(dropdownvalue);
                         });
                       },
                     ),
                   ),
                 ),
               ),
               Text(
                 'أختر نوع الحساب',
                 style: TextStyle(
                   fontSize: 20,
                   fontWeight: FontWeight.bold,
                 ),
               ),
             ],
           ),
           Appspacer(),
           calculationScreen[selectedIndex],
         ],
    );
  }
}
/*  GearBox Speed Calculation Screen */
class GearBoxSpeedCalculation extends StatefulWidget {
  const GearBoxSpeedCalculation({super.key});

  @override
  State<GearBoxSpeedCalculation> createState() => _GearBoxSpeedCalculationState();
}

class _GearBoxSpeedCalculationState extends State<GearBoxSpeedCalculation> {
  var formKey = GlobalKey<FormState>();
  double motorSpeed = 0 , ratio = 13 ,gearBoxSpeed = 0 ;
  var motorSpeedController = TextEditingController() , ratioController = TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    ratioController.text = '13';
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
              controller: motorSpeedController,
              onChanged: (String value){
                motorSpeed= double.parse(value);
              },
              labelText: 'سرعة المحرك',
              validator: (String? value){return null;},
            ),
            AppTextField(
              controller: ratioController,
              onChanged: (String value){
                ratio= double.parse(value);
              },
              labelText: 'نسبة تحويل الجيربوكس',
              validator: (String? value){return null;},
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
                          motorSpeedController.text = '';
                          ratioController.text = '13';
                          motorSpeed = 0;
                          ratio = 13;
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
                            gearBoxSpeed = motorSpeed / ratio ;
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
                    measuredTitle: 'سرعة الجيربوكس',
                    measuredUnit: 'لفة / دقيقة',
                    measuredValue: '${gearBoxSpeed.round()}',
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

/*  Tanabeer Speed Calculation Screen */

class TanabeerSpeedCalculation extends StatefulWidget {
  const TanabeerSpeedCalculation({super.key});

  @override
  State<TanabeerSpeedCalculation> createState() => _TanabeerSpeedCalculationState();
}

class _TanabeerSpeedCalculationState extends State<TanabeerSpeedCalculation> {

  var formKey = GlobalKey<FormState>();
  double var1 = 0 , var2 = 0 ,var3 = 0 , required = 0;
  var var1Controller = TextEditingController() , var2Controller = TextEditingController() , var3Controller = TextEditingController();
  List<String> calculationType = [
    'قطر طنبورة القائد بالسنتيمتر',
    'قطر طنبورة المنقاد بالسنتيمتر',
    'سرعة طنبورة القائد لفة/دقيقة',
    'سرعة طنبورة المنقاد لفة/دقيقة',
  ];
  List<String> labels = [
    'قطر طنبورة القائد',
    'قطر طنبورة المنقاد',
    'سرعة طنبورة القائد',
    'سرعة طنبورة المنقاد',
  ];
  String label1 = '',label2 = '',label3 = '',label4 = '';
  var units =['سم' , 'لفة / دقيقة'];
  String dropdownvalue = 'قطر طنبورة القائد';
  int selectedIndex=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    label1 = calculationType[1];
    label2 = calculationType[2];
    label3 = calculationType[3];
    label4 = labels[0];
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
              spacing: 24,
              children: [
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
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        alignment: Alignment.center,
                        items: labels.map((String measureType) {
                          return DropdownMenuItem(
                            value: measureType,
                            child: Text(measureType),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownvalue = value!;
                            selectedIndex = labels.indexOf(dropdownvalue);
                            if (selectedIndex == 0){
                              label1 = calculationType[1];
                              label2 = calculationType[2];
                              label3 = calculationType[3];
                              label4 = labels[0];
                            }
                            else if (selectedIndex == 1){
                              label1 = calculationType[0];
                              label2 = calculationType[2];
                              label3 = calculationType[3];
                              label4 = labels[1];
                            }
                            else if (selectedIndex == 2){
                              label1 = calculationType[0];
                              label2 = calculationType[1];
                              label3 = calculationType[3];
                              label4 = labels[2];
                            }
                            else if (selectedIndex == 3){
                              label1 = calculationType[0];
                              label2 = calculationType[1];
                              label3 = calculationType[2];
                              label4 = labels[3];
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Text(
                  'المطلوب حسابه',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            AppTextField(
              controller: var1Controller,
              onChanged: (String value){
                var1= double.parse(value);
              },
              labelText: label1,
              validator: (String? value){return null;},
            ),
            AppTextField(
              controller: var2Controller,
              onChanged: (String value){
                var2= double.parse(value);
              },
              labelText: label2,
              validator: (String? value){return null;},
            ),
            AppTextField(
              controller: var3Controller,
              onChanged: (String value){
                var3= double.parse(value);
              },
              labelText: label3,
              validator: (String? value){return null;},
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
                          var1Controller.text = '';
                          var2Controller.text = '';
                          var3Controller.text = '';
                          var1 = 0;
                          var2 = 0;
                          var3 = 0;
                          required = 0;
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
                            if (selectedIndex == 0)
                              {
                                required = var1 * var3 / var2 ;
                              }
                            else if (selectedIndex == 1)
                              {
                                required = var1 * var2 / var3 ;
                              }
                            else if (selectedIndex == 2)
                              {
                                required = var2 * var3 / var1 ;
                              }
                            else if (selectedIndex == 3)
                              {
                                required = var1 * var3 / var2 ;
                              }
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
                    measuredTitle: label4,
                    measuredUnit: selectedIndex == 0 || selectedIndex == 1 ? units[0] : units[1],
                    measuredValue: required.toStringAsFixed(1),
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

