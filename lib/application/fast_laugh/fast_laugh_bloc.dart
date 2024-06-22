import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/downloads/i_download_repo.dart';
import 'package:netflix/domain/downloads/models/downloads.dart';

part 'fast_laugh_event.dart';
part 'fast_laugh_state.dart';
part 'fast_laugh_bloc.freezed.dart';

final dummyVideoUrls = [
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
];

ValueNotifier<Set<int>> LikedvideosidsNotifier = ValueNotifier({});

@injectable
class FastLaughBloc extends Bloc<FastLaughEvent, FastLaughState> {
  FastLaughBloc(IDownloadsRepo _downloadServies)
      : super(FastLaughState.initial()) {
    on<Initialize>((event, emit) async {
      // sendind loading to ui
      emit(FastLaughState(
        videoList: [],
        isLoading: true,
        isError: false,
      ));
      // get trending movies
      final _result = await _downloadServies.getDownloadsImages();
      final _state = _result.fold(
        (l) {
          return FastLaughState(
            videoList: [],
            isLoading: false,
            isError: true,
          );
        },
        (resp) => FastLaughState(
          videoList: resp,
          isLoading: false,
          isError: false,
        ),
      );
      // send to ui

      emit(_state);
    });

    on<LikeVideo>((event, emit) async {
      LikedvideosidsNotifier.value.add(event.id);
      LikedvideosidsNotifier.notifyListeners();
    });

    on<UnLikeVideo>((event, emit) async {
      LikedvideosidsNotifier.value.remove(event.id);
      LikedvideosidsNotifier.notifyListeners();
    });
  }
}
