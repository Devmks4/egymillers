import 'package:flutter/material.dart';
import '../shared/styles/styles.dart';

class AppTextField extends StatelessWidget {

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String labelText;
  final Icon prefixIcon;
  final FormFieldValidator<String> validator;
  final bool isEnabled;

  const AppTextField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.labelText,
    this.prefixIcon = const Icon(Icons.add_circle_outline),
    required this.validator,
    this.isEnabled = true,
});

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      enabled: isEnabled,
      validator: validator,
      controller: controller,
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      decoration: textFieldDecoration(
          labelText: labelText,
          prefixIcon: prefixIcon,
      ),
    );
  }
}