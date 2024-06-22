import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/home/home_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants/constant.dart';
import 'package:netflix/core/constants/strings.dart';
import '../widgets/background_card.dart';
import '../widgets/main_title_card.dart';
import '../widgets/main_top_title_card.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ValueListenableBuilder(
          valueListenable: scrollNotifier,
          builder: (BuildContext context, index, _) {
            return NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                final ScrollDirection direction = notification.direction;
                if (direction == ScrollDirection.reverse) {
                  scrollNotifier.value = false;
                } else if (direction == ScrollDirection.forward) {
                  scrollNotifier.value = true;
                }
                return true;
              },
              child: Stack(
                children: [
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        );
                      } else if (state.hasError) {
                        return Center(
                          child: Text('Error while getting data'),
                        );
                      }
                      // released past year
                      final _releasedPastYear =
                          state.pastYesrMovieList.map((m) {
                        return '$imageAppentUrl${m.posterPath}';
                      }).toList();
                      // trending
                      final _trending = state.trendingMovieList.map((m) {
                        return '$imageAppentUrl${m.posterPath}';
                      }).toList();
                      _trending.shuffle();

                      // tensed dramas
                      final _tenseDramas = state.tenseDramaMovieList.map((m) {
                        return '$imageAppentUrl${m.posterPath}';
                      }).toList();
                      _tenseDramas.shuffle();
                      // south indian movies
                      final _southIndianMovies =
                          state.southIndianMovieList.map((m) {
                        return '$imageAppentUrl${m.posterPath}';
                      }).toList();
                      _southIndianMovies.shuffle();

                      // top 10 tv
                      final _top10tvShow = state.trendingTvList.map((t) {
                        return '$imageAppentUrl${t.posterPath}';
                      }).toList();
                      _top10tvShow.shuffle();

                      // list view
                      return ListView(
                        children: [
                          // page1
                          BackgroundCard(),
                          kheight,
                          // page2
                          MainTitleCard(
                            title: 'Released In Past Year',
                            posterList: _releasedPastYear.sublist(0, 10),
                          ),
                          kheight,
                          MainTitleCard(
                            title: 'Trending Now',
                            posterList: _trending.sublist(0, 10),
                          ),
                          kheight,
                          MainTopTitleCard(
                            title: 'Top 10 Movies In INdia Today',
                            postersList: _top10tvShow.sublist(0, 10),
                          ),
                          kheight,
                          MainTitleCard(
                            title: 'Tense Dramas',
                            posterList: _tenseDramas.sublist(0, 10),
                          ),
                          kheight,
                          MainTitleCard(
                            title: 'South Indian Cenema',
                            posterList: _southIndianMovies.sublist(0, 10),
                          ),
                        ],
                      );
                    },
                  ),
                  scrollNotifier.value == true
                      ? AnimatedContainer(
                          duration: Duration(milliseconds: 1000),
                          width: double.infinity,
                          height: 90,
                          color: Colors.black.withOpacity(0.3),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                    "https://pbs.twimg.com/profile_images/1235992718171467776/PaX2Bz1S_400x400.jpg",
                                    width: 50,
                                    height: 50,
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
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'TV Shows',
                                    style: kHomeTitleText,
                                  ),
                                  Text(
                                    'Movies',
                                    style: kHomeTitleText,
                                  ),
                                  Text(
                                    'Categories',
                                    style: kHomeTitleText,
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      : kheight
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(kwhiteColor),
      ),
      icon: Icon(
        Icons.play_arrow,
        color: Colors.black,
      ),
      label: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Text(
          'play',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }
}
