import 'package:flutter/material.dart';

class ViewResult extends StatelessWidget {

  final String measuredUnit;
  final String measuredTitle;
  final String measuredValue;
  final int flex1;
  final int flex2;

  const ViewResult({
    super.key,
    required this.measuredUnit,
    required this.measuredTitle,
    required this.measuredValue,
    this.flex1 = 1,
    this.flex2 = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.green[200],
        borderRadius: BorderRadius.circular(10),
      ),

      child: Row(
        children: [
          Expanded(
            flex: flex2,
            child:Text( measuredUnit,textAlign: TextAlign.center, style: TextStyle(color: Colors.black54,fontSize: 18),),
          ),
          SizedBox(
            width: 8,
          ),
          Text(measuredValue,textAlign: TextAlign.center, style: TextStyle(color: Colors.teal,fontSize: 20),),
          SizedBox(
            width: 8,
          ),
          Expanded(
            flex: flex1,
            child:Text(measuredTitle,textAlign: TextAlign.center ,style: TextStyle(color: Colors.black54,fontSize: 18),),
          ),
        ],
      ),
    );
  }
}
