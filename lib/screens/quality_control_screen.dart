import 'package:egymillers/screens/qualityControl/ash_calculation_screen.dart';
import 'package:egymillers/screens/qualityControl/doser_calculations_screen.dart';
import 'package:egymillers/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import '../widgets/app_widgets.dart';

class QualityControlScreen extends StatefulWidget {
  const QualityControlScreen({super.key});

  @override
  _QualityControlScreen createState() => _QualityControlScreen();
}

class _QualityControlScreen extends State<QualityControlScreen> {

  var calculationType = ['حسابات الرماد','حسابات الدوزر'];
  String dropdownvalue = 'حسابات الرماد';
  int selectedIndex=0;
  var calculationScreen = [AshCalculationScreen(),DoserCalculationsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackGround,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'قسم الجودة',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
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
                          items: calculationType.map((String measureType) {
                            return DropdownMenuItem(
                              value: measureType,
                              child: Text(measureType),
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
          ),
        ),
      ),
    );
  }
}
