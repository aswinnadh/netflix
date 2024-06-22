import 'package:flutter/material.dart';

import '../../core/constants/constant.dart';
import 'main_title.dart';
import 'number_card.dart';

class MainTopTitleCard extends StatelessWidget {
  const MainTopTitleCard({
    required this.title,
    super.key,
    required this.postersList,
  });
  final String title;
  final List<String> postersList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitle(
          title: title,
        ),
        kheight,
        LimitedBox(
          maxHeight: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              10,
              (index) => NumberCard(
                index: index,
                imageUrl: postersList[index],
              ),
            ),
          ),
        )
      ],
    );
  }
}
