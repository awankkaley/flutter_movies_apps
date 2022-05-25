
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_watchlist_event.dart';
part 'tv_watchlist_state.dart';

class TvWatchListBloc
    extends Bloc<TvWatchListEvent, TvWatchListState> {
  final GetWatchlistTv getWatchlistTv;

  TvWatchListBloc(this.getWatchlistTv)
      : super(TvWatchListEmpty()) {
    on<TvWatchListEvent>((event, emit) async {
      if (event is OnTvWatchListRequested) {
        emit(TvWatchListLoading());
        final result = await getWatchlistTv.execute();
        result.fold((failure) {
          emit(TvWatchListError(failure.message));
        }, (data) {
          emit(TvWatchListSuccess(data));
        });
      }
    });
  }
}
