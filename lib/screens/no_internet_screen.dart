import 'package:flutter/material.dart';

import '../shared/styles/colors.dart';

class NoInternetScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackGround,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'بنك المعلومات',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Text(
          'لا يوجد اتصال بالانترنت',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
