import 'package:flutter/material.dart';
import 'package:netflix/application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants/strings.dart';
import 'package:netflix/domain/downloads/models/downloads.dart';
import 'package:netflix/presentation/fast%20laugh/screen_fast_laugh.dart';
import 'package:share_plus/share_plus.dart';

class VideoListItemInheritedWidget extends InheritedWidget {
  final Widget widget;
  final Downloads movieData;

  const VideoListItemInheritedWidget({
    Key? key,
    required this.widget,
    required this.movieData,
  }) : super(child: widget);

  @override
  bool updateShouldNotify(covariant VideoListItemInheritedWidget oldWidget) {
    return oldWidget.movieData != movieData;
  }

  static VideoListItemInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<VideoListItemInheritedWidget>();
  }
}

class VideoListItem extends StatelessWidget {
  final int index;
  const VideoListItem({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    final posterPath =
        VideoListItemInheritedWidget.of(context)?.movieData.posterPath;
    final videoUrl = dummyVideoUrls[index % dummyVideoUrls.length];
    return Stack(
      children: [
        FastLaughVideoPlayer(
          videoUrl: videoUrl,
          onStateChanged: (bool) {},
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // left side
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.black.withOpacity(0.5),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.volume_off,
                      color: Colors.white,
                    ),
                  ),
                ),

                // right side
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: posterPath == null
                            ? null
                            : NetworkImage('$imageAppentUrl$posterPath'),
                      ),
                    ),
                    ValueListenableBuilder(
                        valueListenable: LikedvideosidsNotifier,
                        builder: (BuildContext context,
                            Set<int> newLikedListIds, Widget? _) {
                          final _index = index;
                          if (newLikedListIds.contains(_index)) {
                            return GestureDetector(
                              onTap: () {
                                // BlocProvider.of<FastLaughBloc>(context)
                                //     .add(UnLikeVideo(id: _index));
                                LikedvideosidsNotifier.value.remove(_index);
                                LikedvideosidsNotifier.notifyListeners();
                              },
                              child: VideoActionWidgets(
                                icon: Icons.favorite,
                                title: 'liked',
                              ),
                            );
                          }
                          return GestureDetector(
                            onTap: () {
                              // BlocProvider.of<FastLaughBloc>(context)
                              //     .add(LikeVideo(id: _index));
                              LikedvideosidsNotifier.value.add(_index);
                              LikedvideosidsNotifier.notifyListeners();
                            },
                            child: VideoActionWidgets(
                              icon: Icons.emoji_emotions,
                              title: 'LOL',
                            ),
                          );
                        }),
                    VideoActionWidgets(
                      icon: Icons.add,
                      title: 'My List',
                    ),
                    GestureDetector(
                        onTap: () {
                          final movieName =
                              VideoListItemInheritedWidget.of(context)
                                  ?.movieData
                                  .posterPath;
                          if (movieName != null) {
                            Share.share(movieName);
                          }
                        },
                        child: VideoActionWidgets(
                          icon: Icons.share,
                          title: 'Share',
                        )),
                    VideoActionWidgets(
                      icon: Icons.play_arrow,
                      title: 'Play',
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class VideoActionWidgets extends StatelessWidget {
  final IconData icon;
  final String title;
  const VideoActionWidgets(
      {required this.icon, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
          Text(
            title,
            style: TextStyle(
              color: kwhiteColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
