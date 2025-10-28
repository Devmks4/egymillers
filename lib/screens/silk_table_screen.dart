import 'package:egymillers/widgets/app_textfield.dart';
import 'package:egymillers/widgets/selection_button.dart';
import 'package:flutter/material.dart';

import '../models/silk_table.dart';
import '../shared/styles/colors.dart';
import '../widgets/app_button.dart';
import '../widgets/app_widgets.dart';

class SilkTableScreen extends StatefulWidget {
  const SilkTableScreen({super.key});

  @override
  State<SilkTableScreen> createState() => _SilkTableScreenState();
}

class _SilkTableScreenState extends State<SilkTableScreen> {
  var txtController = TextEditingController();
  var micronValue = "0",
      holecmValue = "0",
      diameterValue = "0",
      percentageValue = "0",
      typeValue = "0" ;
  String searchValue = "" , typeTitle = "GG";
  var typeText = ['GG','XXX','سلك'];
  int typeSelected = 1;
  bool startSearch = false;
  int nearValueSelected = 0;
  List<Map <String,String>> nearValues = [];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void fetchValues(value, table) {
    var row = SilkTable.searchExact(table,'holescm',value);
    if (row != {}) {
      typeValue = row['id'].toString();
      micronValue = row['micron'].toString();
      holecmValue = row['holescm'].toString();
      diameterValue = row['diameter'].toString();
      percentageValue = row['percentage'].toString();
    } else {
      typeValue = "0";
      micronValue = "0";
      holecmValue = "0";
      diameterValue = "0";
      percentageValue = "0";
    }
    startSearch = false;
    nearValues = [];
    nearValueSelected = 0;
  }

  void fetchNearValues(value, table){
    startSearch = true;
    var row = SilkTable.searchSmart(table,'holescm',value);
    if (SilkTable.foundExact){
      typeValue = row['id'].toString();
      micronValue = row['micron'].toString();
      holecmValue = row['holescm'].toString();
      diameterValue = row['diameter'].toString();
      percentageValue = row['percentage'].toString();
    }
    else {
      nearValues = row ;
      nearValueSelected = 0 ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackGround,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'حساب مقاسات الحرير',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
              children: [
                Row(
                  spacing: 16,
                  children: [
                    AppButton(
                      title: 'بحث',
                      onPress: () {
                        setState(() {
                          if (searchValue != "") {
                            if (typeSelected == 1) {
                            //  fetchValues(searchValue, SilkTable.ggTable);
                              fetchNearValues(searchValue, SilkTable.ggTable);
                            }
                            else if (typeSelected == 2) {
                             // fetchValues(searchValue, SilkTable.xxxTable);
                              fetchNearValues(searchValue, SilkTable.xxxTable);
                            }
                            else if (typeSelected == 3) {
                              //fetchValues(searchValue, SilkTable.metalTable);
                              fetchNearValues(searchValue, SilkTable.metalTable);
                            }
                          }
                          else {
                            typeValue = "0";
                            micronValue = "0";
                            holecmValue = "0";
                            diameterValue = "0";
                            percentageValue = "0";
                          }
                        });
                      },
                    ),
                    Flexible(
                      child: AppTextField(
                        controller: txtController,
                        onChanged: (value) {
                          setState(() {
                            searchValue = value.toString();
                          });
                        },
                        labelText: 'عدد الفتحات / سم',
                        validator: (value) {

                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 40,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: SelectionButton(
                        buttonColor:
                            typeSelected == 3 ? primaryColor : Colors.grey,
                        onPressed: () {
                          setState(() {
                            if (searchValue != ""){
                              fetchValues(searchValue, SilkTable.metalTable);
                            }
                            else{
                              typeValue = "0";
                              micronValue = "0";
                              holecmValue = "0";
                              diameterValue = "0";
                              percentageValue = "0";
                            }
                            typeTitle = typeText[2];
                            typeSelected = 3;
                          });
                        },
                        buttonTitle: 'سلك',
                      ),
                    ),
                    Expanded(
                      child: SelectionButton(
                        buttonColor:
                            typeSelected == 2 ? primaryColor : Colors.grey,
                        onPressed: () {
                          setState(() {
                            if (searchValue != ""){
                              fetchValues(searchValue, SilkTable.xxxTable);
                            }
                            else{
                              typeValue = "0";
                              micronValue = "0";
                              holecmValue = "0";
                              diameterValue = "0";
                              percentageValue = "0";
                            }
                            typeSelected = 2;
                            typeTitle = typeText[1];
                          });
                        },
                        buttonTitle: 'XXX',
                      ),
                    ),
                    Expanded(
                      child: SelectionButton(
                        buttonColor:
                            typeSelected == 1 ? primaryColor : Colors.grey,
                        onPressed: () {
                          setState(() {
                            if (searchValue != ""){
                              fetchValues(searchValue, SilkTable.ggTable);
                            }
                            else{
                              typeValue = "0";
                              micronValue = "0";
                              holecmValue = "0";
                              diameterValue = "0";
                              percentageValue = "0";
                            }
                            typeSelected = 1;
                            typeTitle = typeText[0];
                          });
                        },
                        buttonTitle: 'GG',
                      ),
                    ),
                  ],
                ),
                SilkTable.foundExact == false  && SilkTable.foundNear && startSearch ?
                Column (
                  children: [
                    Text('القيمة المكتوبة غير موجودة بالجداول .. جرب القيم التالية'),
                    Row(
                      spacing: 16,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:
                        List.generate(nearValues.length, (index)
                            {
                              return SelectionButton(
                                buttonColor: nearValueSelected == index+1 ? primaryColor : Colors.grey,
                                onPressed: (){
                                  setState(() {
                                    nearValueSelected = index+1;
                                    typeValue = nearValues[index]['id'].toString();
                                    micronValue = nearValues[index]['micron'].toString();
                                    holecmValue = nearValues[index]['holescm'].toString();
                                    diameterValue = nearValues[index]['diameter'].toString();
                                    percentageValue = nearValues[index]['percentage'].toString();
                                  });
                                },
                                buttonTitle: nearValues[index]["holescm"]!.toString(),
                              );
                            }
                        ),
                    ),
                  ],
                )
                : SizedBox(),
                Appspacer(),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.green[200],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        spacing: 16,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            spacing: 16,
                            children: [
                              Text(
                                typeValue,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                micronValue,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                holecmValue,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                diameterValue,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                percentageValue,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            spacing: 16,
                            children: [
                              Text(
                                typeTitle,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'ميكرون',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'عدد الفتحات / سم',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'سمك الخيط (ميكرون)',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'كفاءة النخل (%)',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
