import 'package:flutter/material.dart';
import 'package:netflix/core/constants/constant.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.tittle});
  final String tittle;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        kwidth,
        Text(
          tittle,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(
          Icons.cast,
          color: Colors.white,
          size: 30,
        ),
        kwidth,
        Container(
          width: 30,
          height: 30,
          color: Colors.blue,
        ),
        kwidth,
      ],
    );
  }
}
