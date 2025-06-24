import 'package:flutter/material.dart';

class SelectionButton extends StatelessWidget {

  final Color buttonColor;
  final VoidCallback onPressed;
  final String buttonTitle;

  const SelectionButton({
    super.key,
    required this.buttonColor,
    required this.onPressed,
    required this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.green,
        ),
        borderRadius: BorderRadius.circular(16),
        color: buttonColor,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: FittedBox(
          child: Text(
            buttonTitle,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
