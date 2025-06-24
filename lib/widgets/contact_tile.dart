import 'package:flutter/material.dart';

class ContactTile extends StatelessWidget {
  // parameters
  final Icon icon;
  final String title;
  final VoidCallback onPress;
  // class constructor
  const ContactTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onPress
  });
  // main build method
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        TextButton(
          onPressed: onPress,
          child: Text(
            title,
            style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),),
        ),
      ],
    );
  }
}
