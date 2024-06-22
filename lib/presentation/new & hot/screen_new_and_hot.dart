import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:netflix/application/hotandnew/hotandnew_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants/constant.dart';
import 'package:netflix/core/constants/strings.dart';
import 'package:netflix/presentation/new%20&%20hot/widgets/everyones_watch_widget.dart';
import 'package:netflix/presentation/widgets/app_bar_widget.dart';
import 'widgets/comming_soon_widget.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(85),
          child: Column(
            children: [
              AppBarWidget(
                tittle: 'New & hots',
              ),
              TabBar(
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                labelColor: kblackColor,
                labelStyle:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                indicator: BoxDecoration(
                  color: kwhiteColor,
                  borderRadius: kRadius30,
                ),
                tabs: [
                  Tab(
                    text: '🍿 Comming Soon',
                  ),
                  Tab(
                    text: "👀 Everyone's watching",
                  ),
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ComingSoonList(
              key: Key('comming_soon'),
            ),
            EveryoneIsWatchingList(
              key: Key('everyone_is_watching'),
            ),
          ],
        ),
      ),
    );
  }
}

class ComingSoonList extends StatelessWidget {
  const ComingSoonList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<HotandnewBloc>(context).add(
        const LoadDataInComingSoon(),
      );
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotandnewBloc>(context).add(
          const LoadDataInComingSoon(),
        );
      },
      child: BlocBuilder<HotandnewBloc, HotandnewState>(
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
          } else if (state.comingSoonlist.isEmpty) {
            return Center(
              child: Text('List is empty'),
            );
          } else {
            return ListView.builder(
              padding: EdgeInsets.only(top: 20),
              itemCount: state.comingSoonlist.length,
              itemBuilder: (BuildContext context, index) {
                final movie = state.comingSoonlist[index];
                if (movie.id == null) {
                  return SizedBox();
                }
                String month = '';
                String date = '';
                try {
                  final _date = DateTime.tryParse(movie.releaseDate!);
                  final formatedDate =
                      DateFormat.yMMMMd('en_US').format(_date!);
                  month = formatedDate
                      .split(' ')
                      .first
                      .substring(0, 3)
                      .toUpperCase();
                  date:
                  movie.releaseDate!.split('-')[1];
                } catch (_) {
                  month = '';
                  date = '';
                }

                return CommingSoonWidget(
                  id: movie.id.toString(),
                  month: month,
                  day: date,
                  posterPath: '$imageAppentUrl${movie.posterPath}',
                  movieName: movie.originalTitle ?? 'no title',
                  description: movie.overview ?? 'no description',
                );
              },
            );
          }
        },
      ),
    );
  }
}

class EveryoneIsWatchingList extends StatelessWidget {
  const EveryoneIsWatchingList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<HotandnewBloc>(context)
          .add(LoadDataInEveryOneIsWatching());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotandnewBloc>(context)
            .add(LoadDataInEveryOneIsWatching());
      },
      child: BlocBuilder<HotandnewBloc, HotandnewState>(
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
          } else if (state.everyOneIsWatchingList.isEmpty) {
            return Center(
              child: Text('List is empty'),
            );
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: state.everyOneIsWatchingList.length,
              itemBuilder: (BuildContext context, index) {
                final movie = state.everyOneIsWatchingList[index];
                if (movie.id == null) {
                  return SizedBox();
                }

                final tv = state.everyOneIsWatchingList[index];
                return EveryonesWatchWidget(
                  posterPath: '$imageAppentUrl${tv.posterPath}',
                  movieName: tv.originalName ?? "no name provided",
                  description: tv.overview ?? 'no description',
                );
              },
            );
          }
        },
      ),
    );
  }
}
