import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';

import '../../core/constants/constant.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({required this.index, super.key, required this.imageUrl});
  final int index;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            SizedBox(
              width: 20,
              height: 200,
            ),
            Container(
              width: 130,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: kRadius20,
                image: DecorationImage(
                  image: NetworkImage(
                    imageUrl,
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: 1,
          bottom: 10,
          child: BorderedText(
            strokeColor: Colors.white,
            strokeWidth: 3.0,
            child: Text(
              '${index + 1}',
              style: TextStyle(
                fontSize: 100,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                decorationColor: Colors.white,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
