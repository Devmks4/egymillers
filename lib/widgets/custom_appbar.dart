import 'package:flutter/material.dart';

import '../shared/styles/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      title: Text(title),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Image.asset(
            'assets/icons/icooon2.png',
            width: 32,
            height: 32,
          ),
        ),
      ],
      leading: IconButton(
                  onPressed: ()=>Navigator.pop(context),
                  icon: Icon(Icons.arrow_back_rounded),
                ),
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}