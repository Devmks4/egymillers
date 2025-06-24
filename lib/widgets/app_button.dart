import 'package:flutter/material.dart';
import '../shared/styles/colors.dart';

class AppButton extends StatelessWidget {

  final String title;
  final VoidCallback onPress;
  final double height;

  const AppButton({
    super.key,
    required this.title,
    required this.onPress,
    this.height = 55,
  });


  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      color: primaryColor,
      height: height,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
