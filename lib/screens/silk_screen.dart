import 'package:egymillers/shared/styles/colors.dart';
import 'package:egymillers/widgets/app_textfield.dart';
import 'package:flutter/material.dart';

import '../widgets/app_button.dart';
import 'mesh_threads_camera_screen.dart';

class SilkScreen extends StatefulWidget {
  const SilkScreen({super.key});

  @override
  _SilkScreenState createState() => _SilkScreenState();
}

class _SilkScreenState extends State<SilkScreen> {


  /*-----------------Variables-------------------*/
  var measureType = ["GG", "XXX", "ميكرون", "عدد الخيوط / سم"];
  String dropdownvalue = "GG";
  var txtController = TextEditingController();
  var value1 = "0",value2 = "0",value3 = "0",value4 = "0",value5 = "0" ;
  String text1 = 'XXX' , text2 = 'ميكرون' , text3 = 'عدد الخيوط / سم' ;
  var gg = ["-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","74","66","60","58","72","70","68","64","62","56","54","52","50","48","47","46","45","44","42","40","38","36","34","32","31","30","28","27","26","24","23","22","20","19","18","17","16","15","14","12"];
  var xxx = ["17","15","14.5","14","13","12.5","12","11","10.5","10","9.5","9","8.5","8","7","6","5","4","3","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-"];
  var micron = ["80","85","90","95","100","106","112","118","125","132","140","150","160","180","200","212","250","280","300","224","236","243","265","275","308","315","335","355","363","375","390","400","425","450","475","500","530","560","600","630","670","710","750","800","850","900","950","1000","1120","1180","1250","1320","1400","1600","1800"];
  var holecm = ["71.4","69","66.7","60.6","58.8","56.8","55","50.5","48.8","47.1","43.5","41.7","38.5","35.7","31.2","30","27","23.8","22.7","29","28","27.5","24.7","24","21.4","21","20.2","19.5","18.5","18","17.5","17.2","16","15.5","14.8","14","13.3","12.5","12","11.5","11","10.3","9.7","9.3","8.7","8.3","8","7.5","6.8","6.5","6","5.8","5.4","5","4.3"];
  var wire = ["60","60","60","70","70","60","70","80","80","80","90","90","100","100","120","120","120","140","140","120","120","120","140","140","160","160","160","160","180","180","180","180","200","200","205","220","220","240","240","240","260","260","280","280","300","300","300","320","350","350","400","400","450","450","500"];
  var perc = ["35","35","36","33","32","38","38","34","37","40","37","38","37","39","39","40","46","45","45","42","44","44","43","44","44","44","46","48","46","47","47","47","46","48","48","47","50","49","51","53","53","53","52","53","53","56","57","57","58","59","58","59","59","60","61"];
  var searchIndex = 0 ;
  var searchTerm = '0';
  var errorMessage = " ";
  var formKey = GlobalKey<FormState>();
  var checkValidate = 0 ;
/*---------------------------------------*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackGround,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'حساب مقاسات الحرير',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              spacing: 20,
              children: [
                Row(
                  spacing: 24,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MeshCamera(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          size: 40,
                          color: Colors.black,
                      ),
                                            ),
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
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                            alignment: Alignment.center,
                            items: measureType.map((String measureType) {
                              return DropdownMenuItem(
                                value: measureType,
                                child: Text(measureType),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                dropdownvalue = value!;
                                if (value == 'GG')
                                {
                                  text1 = 'XXX' ; text2 = 'ميكرون' ; text3 = 'عدد الخيوط / سم' ;
                                }
                                else if (value == 'XXX')
                                {
                                  text1 = 'GG' ; text2 = 'ميكرون' ; text3 = 'عدد الخيوط / سم' ;
                                }
                                else if (value == 'ميكرون')
                                {
                                  text1 = 'GG' ; text2 = 'XXX' ; text3 = 'عدد الخيوط / سم' ;
                                }
                                else
                                {
                                  text1 = 'GG' ; text2 = 'XXX' ; text3 = 'ميكرون' ;
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'نوع القياس',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Form(
                  key: formKey,
                  child: Row(
                    spacing: 24,
                    children: [
                      AppButton(
                        title: 'بحث',
                        onPress: () {
                          setState(() {
                            zeroValues();
                          });
                          if (formKey.currentState!.validate()){
                            setState(() {
                              findIndex();
                              searchButton();
                            });
                          }
                        },
                      ),
                      Expanded(
                        child: AppTextField(
                            controller: txtController,
                            onChanged: (value) {
                              searchTerm = value;
                            },
                            labelText: 'أدخل قيمة القياس',
                            validator: (String? value){
                                      checkInput();
                                      if (checkInput() == 0 || value!.isEmpty) {
                                      return 'من فضلك أكتب قيمة صحيحة';
                                      }
                                      return null;
                                      },
                          prefixIcon: Icon(Icons.search_outlined,color: primaryColor,),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.green[200],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      spacing: 16,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              value1,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              text1,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              value2,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              text2,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              value3,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              text3,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              value4,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              'سمك الخيط (ميكرون)',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              value5,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 30,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
  void searchButton (){
    switch(dropdownvalue){
      case "GG":
        {
          value1 = xxx.elementAt(searchIndex).toString();
          value2 = micron.elementAt(searchIndex).toString();
          value3 = holecm.elementAt(searchIndex).toString();
          value4 = wire.elementAt(searchIndex).toString();
          value5 = perc.elementAt(searchIndex).toString();
        }
        break;
      case "XXX":
        {
          value1 = gg.elementAt(searchIndex).toString();
          value2 = micron.elementAt(searchIndex).toString();
          value3 = holecm.elementAt(searchIndex).toString();
          value4 = wire.elementAt(searchIndex).toString();
          value5 = perc.elementAt(searchIndex).toString();
        }
        break;
      case "ميكرون":
        {
          value1 = gg.elementAt(searchIndex).toString();
          value2 = xxx.elementAt(searchIndex).toString();
          value3 = holecm.elementAt(searchIndex).toString();
          value4 = wire.elementAt(searchIndex).toString();
          value5 = perc.elementAt(searchIndex).toString();
        }
        break;
      case "عدد الخيوط / سم":
        {
          value1 = gg.elementAt(searchIndex).toString();
          value2 = xxx.elementAt(searchIndex).toString();
          value3 = micron.elementAt(searchIndex).toString();
          value4 = wire.elementAt(searchIndex).toString();
          value5 = perc.elementAt(searchIndex).toString();
        }
        break;
    }


  }
  void findIndex (){
    if (dropdownvalue == "GG") {
      if (gg.contains(searchTerm)) {
        searchIndex = gg.indexOf(searchTerm);
      } else {
        errorMessage = 'عفوا هذه القيمة غير موجودة';
      }
    }
    else if (dropdownvalue == "XXX") {
      if (xxx.contains(searchTerm)) {
        searchIndex = xxx.indexOf(searchTerm);
      } else {
        errorMessage = 'عفوا هذه القيمة غير موجودة';
      }
    }
    else if (dropdownvalue == "ميكرون") {
      if (micron.contains(searchTerm)) {
        searchIndex = micron.indexOf(searchTerm);
      } else {
        errorMessage = 'عفوا هذه القيمة غير موجودة';
      }
    }
    else
    {
      if (holecm.contains(searchTerm)) {
        searchIndex = holecm.indexOf(searchTerm);
      } else {
        errorMessage = 'عفوا هذه القيمة غير موجودة';
      }
    }
  }
  void zeroValues(){

    value1 = "0"; value2 = "0"; value3 = "0"; value4 = "0"; value5 = "0" ;
  }
  int checkInput (){
    if (dropdownvalue == "GG") {
      if (gg.contains(searchTerm)) {
        return 1;
      } else {
        return 0 ;
      }
    }
    else if (dropdownvalue == "XXX") {
      if (xxx.contains(searchTerm)) {
        return 1;
      } else {
        return 0 ;
      }
    }
    else if (dropdownvalue == "ميكرون") {
      if (micron.contains(searchTerm)) {
        return 1;
      } else {
        return 0 ;
      }
    }
    else
    {
      if (holecm.contains(searchTerm)) {
        return 1;
      } else {
        return 0 ;
      }
    }
  }
}
/* Container(
              child: Text(
                  '$errorMessage',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
const SizedBox(
height: 24,
),
*/