import 'package:flutter/material.dart';
import 'package:netflix/core/constants/constant.dart';

import '../../widgets/custom_button_widget.dart';
import '../../widgets/video_widget.dart';

class EveryonesWatchWidget extends StatelessWidget {
  final String posterPath;
  final String movieName;
  final String description;
  const EveryonesWatchWidget({
    super.key,
    required this.posterPath,
    required this.movieName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      shrinkWrap: true,
      children: [
        kheight,
        Text(
          movieName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          description,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        VideoWidget(
          url: posterPath,
        ),
        kheight20,
        kheight20,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomButtonWidget(
              icon: Icons.share,
              title: 'Share',
              iconSize: 20,
              textSize: 10,
            ),
            kwidth,
            CustomButtonWidget(
              icon: Icons.add,
              title: 'My List',
              iconSize: 20,
              textSize: 10,
            ),
            kwidth,
            CustomButtonWidget(
              icon: Icons.play_arrow,
              title: 'Play',
              iconSize: 20,
              textSize: 10,
            ),
            kwidth,
          ],
        ),
      ],
    );
  }
}
