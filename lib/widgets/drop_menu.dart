import 'package:flutter/material.dart';

import '../shared/styles/colors.dart';

class AppDropMenu extends StatefulWidget {

  final List<String?> menuList;
  String dropdownvalue;
  ValueChanged<String?>? onChanged;

  AppDropMenu({super.key ,required this.menuList ,required this.dropdownvalue , required this.onChanged});

  @override
  State<AppDropMenu> createState() => _AppDropMenuState();
}

class _AppDropMenuState extends State<AppDropMenu> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        color: scaffoldBackGround,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: DropdownButton(
          isExpanded: true,
          underline: SizedBox(),
          value: widget.dropdownvalue,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: primaryColor,
          ),
          iconSize: 32,
          borderRadius: BorderRadius.circular(10),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
          alignment: Alignment.center,
          items:
          widget.menuList.map((String? measureType) {
            return DropdownMenuItem(
              value: measureType,
              child: Text(measureType!),
            );
          }).toList(),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
