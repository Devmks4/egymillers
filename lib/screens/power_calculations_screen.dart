import 'package:egymillers/screens/machinePower/conveyor_power.dart';
import 'package:egymillers/shared/styles/colors.dart';
import 'package:egymillers/widgets/app_textfield.dart';
import 'package:egymillers/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'machinePower/bucket_power.dart';
import 'machinePower/elevator_power.dart';

class PowerCalculationsScreen extends StatefulWidget {
  const PowerCalculationsScreen({super.key});

  @override
  _PowerCalculationsScreen createState() => _PowerCalculationsScreen();
}

class _PowerCalculationsScreen extends State<PowerCalculationsScreen> {

  var machineType = ['الكاتينة','البريمة', 'الساقية'];
  String dropdownvalue = 'الكاتينة';
  int selectedIndex=0;
  var machineScreen = [BucketPower(),ConveyorPower(),ElevatorPower()];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackGround,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'قدرات المعدات',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                Text('تم استخدام قوانين الحسابات من كتاب             م/ أبو زيد حمزة جزاه الله كل خير',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.green[600],
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                      ),
                ),
                Appspacer(),
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
                            items: machineType.map((String measureType) {
                              return DropdownMenuItem(
                                value: measureType,
                                child: Text(measureType),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                dropdownvalue = value!;
                                selectedIndex = machineType.indexOf(dropdownvalue);
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'أختر نوع المعدة',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Appspacer(),
                machineScreen[selectedIndex],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
