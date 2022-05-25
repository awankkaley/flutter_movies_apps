import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_on_the_air.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_now_playing_event.dart';
part 'tv_now_playing_state.dart';

class TvNowPlayingBloc
    extends Bloc<TvNowPlayingEvent, TvNowPlayingState> {
  final GetTvOnTheAir _getNowPlayingTvs;

  TvNowPlayingBloc(this._getNowPlayingTvs) : super(TvNowPlayingEmpty()) {
    on<TvNowPlayingEvent>((event, emit) async {
      if (event is OnTvNowPlayingRequested) {
        emit(TvNowPlayingLoading());

        final result = await _getNowPlayingTvs.execute();
        result.fold((failure) {
          emit(TvNowPlayingError(failure.message));
        }, (data) {
          emit(TvNowPlayingHasData(data));
        });
      }
    });
  }
}
