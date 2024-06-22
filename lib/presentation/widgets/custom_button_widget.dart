import 'package:flutter/material.dart';

import '../../core/colors/colors.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    required this.icon,
    required this.title,
    this.iconSize = 25,
    this.textSize = 15,
    super.key,
  });
  final IconData icon;
  final String title;
  final double iconSize;
  final double textSize;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: kwhiteColor,
          size: iconSize,
        ),
        Text(
          title,
          style: TextStyle(
            color: kwhiteColor,
            fontSize: textSize,
          ),
        ),
      ],
    );
  }
}
