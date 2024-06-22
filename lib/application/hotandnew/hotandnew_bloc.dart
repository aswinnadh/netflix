import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/hotandnew/hot_and_new_service.dart';
import 'package:netflix/domain/hotandnew/model/hot_and_new_resp.dart';

part 'hotandnew_event.dart';
part 'hotandnew_state.dart';
part 'hotandnew_bloc.freezed.dart';

@injectable
class HotandnewBloc extends Bloc<HotandnewEvent, HotandnewState> {
  final HotAndNewService _hotAndNewService;
  HotandnewBloc(this._hotAndNewService) : super(HotandnewState.initial()) {
    /*
    get hot and new movie data
    */
    on<LoadDataInComingSoon>((event, emit) async {
      // send loading to ui
      emit(
        HotandnewState(
            comingSoonlist: [],
            everyOneIsWatchingList: [],
            isLoading: true,
            hasError: false),
      );
      // get data to ui
      final _result = await _hotAndNewService.getHotAndNewMovieData();
      // data to state
      final newState = _result.fold(
        (MainFailure failure) {
          return HotandnewState(
            comingSoonlist: [],
            everyOneIsWatchingList: [],
            isLoading: false,
            hasError: true,
          );
        },
        (HotAndNewResp resp) {
          return HotandnewState(
            comingSoonlist: resp.results,
            everyOneIsWatchingList: state.everyOneIsWatchingList,
            isLoading: false,
            hasError: false,
          );
        },
      );
      emit(newState);
    });
    /*
tv    */
    on<LoadDataInEveryOneIsWatching>((event, emit) async {
      emit(
        HotandnewState(
            comingSoonlist: [],
            everyOneIsWatchingList: [],
            isLoading: true,
            hasError: false),
      );
      // get data to ui
      final _result = await _hotAndNewService.getHotAndNewTvData();
      // data to state
      final newState = _result.fold(
        (MainFailure failure) {
          return HotandnewState(
            comingSoonlist: [],
            everyOneIsWatchingList: [],
            isLoading: false,
            hasError: true,
          );
        },
        (HotAndNewResp resp) {
          return HotandnewState(
            comingSoonlist: state.comingSoonlist,
            everyOneIsWatchingList: resp.results,
            isLoading: false,
            hasError: false,
          );
        },
      );
      emit(newState);
    });
  }
}
