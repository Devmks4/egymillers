import 'package:egymillers/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class MeshCamera extends StatefulWidget {
  const MeshCamera({super.key});

  @override
  State<MeshCamera> createState() => _MeshCameraState();
}

class _MeshCameraState extends State<MeshCamera> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackGround,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'عدسة الحرير بالكاميرا',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'عدسة الحرير بالكاميرا',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'انتظرونا قريبا',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
