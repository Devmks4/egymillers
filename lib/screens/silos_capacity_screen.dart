import 'package:egymillers/shared/styles/colors.dart';
import 'package:egymillers/widgets/app_textfield.dart';
import 'package:egymillers/widgets/app_widgets.dart';
import 'package:egymillers/widgets/selection_button.dart';
import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import '../widgets/view_result.dart';

class SilosCapacityScreen extends StatefulWidget {
  const SilosCapacityScreen({super.key});

  @override
  _SilosCapacityScreen createState() => _SilosCapacityScreen();
}

class _SilosCapacityScreen extends State<SilosCapacityScreen> {
  var productType = ['قمح صلب', 'قمح سوفت', 'ردة خشنة', 'ردة ناعمة', 'دقيق 72', 'دقيق 82', 'سن'];
  Map <String , int> productSWeight = {
  'قمح صلب' : 850,
  'قمح سوفت':760,
  'ردة خشنة':230,
  'ردة ناعمة':330,
  'دقيق 72':580,
  'دقيق 82':500,
  'سن':400
  };
  String dropdownvalue = 'قمح صلب';
  var control0 = TextEditingController() ,control1 = TextEditingController() ,control2 = TextEditingController() , control3 = TextEditingController() , control4 = TextEditingController() ;
  int sWeight=850;
  String t1 = 'طول الصومعة' , t2 = 'عرض الصومعة' , t3 = 'ارتفاع الصومعة', t4 = 'ارتفاع ذيل الصومعة';
  double h = 0 , w = 0 , l = 0 , t = 0;
  double capacity = 0 ;
  var siloImages = [
    'assets/images/squareSilo.jpg',
    'assets/images/MetallicSilo.jpg',
    'assets/images/MetallicSilo2.jpg',
    ];
  int selectedImageIndex = 0;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    control0.text = sWeight.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackGround,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'حساب سعة الصوامع',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              spacing: 10,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:6.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      siloImages[selectedImageIndex],
                      fit: BoxFit.contain,
                      width: 250,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: SelectionButton(
                            buttonColor: selectedImageIndex == 2 ? primaryColor : Colors.grey,
                            onPressed: (){
                              setState(() {
                                t2 = 'قطر الصومعة' ;
                                t3 = 'ارتفاع جسم الصومعة' ;
                                t1 = 'ارتفاع رأس الصومعة';
                                selectedImageIndex = 2;
                              });

                            },
                            buttonTitle: 'صومعة بهوبر سفلي',
                          )
                      ),
                      SizedBox(width: 8,),
                      Expanded(
                          child: SelectionButton(
                            buttonColor: selectedImageIndex == 1 ? primaryColor : Colors.grey,
                            onPressed: (){
                              setState(() {
                                t2 = 'قطر الصومعة' ;
                                t3 = 'ارتفاع جسم الصومعة' ;
                                t1 = 'ارتفاع رأس الصومعة';
                                selectedImageIndex = 1;
                              });

                            },
                            buttonTitle: 'صومعة معدنية',
                          )
                      ),
                      SizedBox(width: 8,),
                      Expanded(
                          child: SelectionButton(
                            buttonColor: selectedImageIndex == 0 ? primaryColor : Colors.grey,
                            onPressed: (){
                              setState(() {
                                t1 = 'طول الصومعة' ;
                                t2 = 'عرض الصومعة' ;
                                t3 = 'ارتفاع الصومعة';
                                selectedImageIndex = 0;
                              });
                            },
                            buttonTitle: 'صومعة أسمنتية',
                          )
                      ),
                    ],
                  ),
                ),
                Appspacer(),
                Row(
                  spacing: 8,
                  children: [
                    SizedBox(
                      width: 150,
                      child:AppTextField(
                          controller: control0,
                          onChanged: (String? value){
                            setState(() {
                              sWeight = int.parse(value!);
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
                                sWeight = productSWeight[dropdownvalue]!;
                                control0.text = sWeight.toString();
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
                Appspacer(),
                SizedBox(height: 6,),
                AppTextField(
                  validator: (String? value) => null,
                  controller: control1,
                  onChanged: (value){
                    l = double.parse(value);
                  },
                  labelText: t1,
                ),
                AppTextField(
                    validator: (String? value) => null,
                    controller: control2,
                    onChanged: (value){
                      w = double.parse(value);
                    },
                    labelText: t2,
                ),
                AppTextField(
                    validator: (String? value) => null,
                    controller: control3,
                    onChanged: (value){
                      h = double.parse(value);
                    },
                    labelText: t3,
                ),
              selectedImageIndex == 2
                  ? AppTextField(
                    validator: (String? value) => null,
                    controller: control4,
                    onChanged: (value){
                      t = double.parse(value);
                    },
                    labelText: t4,
                ) : SizedBox(),
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
                              capacity = 0;
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
                            capacity = 0;
                            l = double.parse(control1.text);
                            w = double.parse(control2.text);
                            h = double.parse(control3.text);
                            if (selectedImageIndex == 2)
                            {t = double.parse(control4.text);}
                            var doubleSWeight = sWeight / 1000 ;
                            setState(() {
                              if (selectedImageIndex == 0 && control1.text.isNotEmpty && control2.text.isNotEmpty && control3.text.isNotEmpty)
                              {
                                capacity = w * l * h * doubleSWeight ;
                              }
                              else if (selectedImageIndex == 1 && control1.text.isNotEmpty && control2.text.isNotEmpty && control3.text.isNotEmpty ){
                                capacity = (3.14*(w/2)*(w/2)*h*doubleSWeight) + (0.26166666)*(w)*(w)*(l)*(doubleSWeight);
                              }
                              else if (selectedImageIndex == 2 && control1.text.isNotEmpty && control2.text.isNotEmpty && control3.text.isNotEmpty && control4.text.isNotEmpty)
                              {
                                capacity = (3.14*(w/2)*(w/2)*h*doubleSWeight) + (0.26166666)*(w)*(w)*(l)*(doubleSWeight) + (0.26166666)*(w)*(w)*(t)*(doubleSWeight);
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:14.0),
                  child: ViewResult(
                    measuredTitle: 'سعة الصومعة',
                    measuredUnit: 'طن',
                    measuredValue: '${capacity.round()}',
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}