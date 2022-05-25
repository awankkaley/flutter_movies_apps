import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:ditonton/presentation/bloc/tv_watchlist/tv_watchlist_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_watchlist_status_event.dart';
part 'tv_watchlist_status_state.dart';

class TvWatchListStatusBloc
    extends Bloc<TvWatchListStatusEvent, TvWatchListStatusState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  final TvWatchListBloc tvWatchListBloc;
  final GetWatchListTvStatus getWatchListStatus;
  final SaveTvWatchlist saveWatchlist;
  final RemoveTvWatchlist removeWatchlist;

  TvWatchListStatusBloc(this.tvWatchListBloc, this.getWatchListStatus,
      this.saveWatchlist, this.removeWatchlist)
      : super(TvWatchListStatusEmpty()) {
    on<TvWatchListStatusEvent>((event, emit) async {
      if (event is OnTvWatchListStatusAdded) {
        final isAdded = await saveWatchlist.execute(event.movieDetail);

        isAdded.fold(
          (failure) async {
            emit(TvWatchListStatusError(failure.message));
          },
          (successMessage) async {
            emit(TvWatchListStatusSuccess(watchlistAddSuccessMessage));
            add(OnTvWatchListStatusFavorited(event.movieDetail));
            tvWatchListBloc.add(OnTvWatchListRequested());
          },
        );
      } else if (event is OnTvWatchListStatusRemoved) {
        final isRemove = await removeWatchlist.execute(event.movieDetail);
        isRemove.fold(
          (failure) async {
            emit(TvWatchListStatusError(failure.message));
          },
          (successMessage) async {
            emit(TvWatchListStatusSuccess(watchlistRemoveSuccessMessage));
            add(OnTvWatchListStatusFavorited(event.movieDetail));
            tvWatchListBloc.add(OnTvWatchListRequested());
          },
        );
      } else if (event is OnTvWatchListStatusFavorited) {
        final isFavorited =
            await getWatchListStatus.execute(event.movieDetail.id);
        emit(WatchlistStatusLoaded(isFavorited));
      }
    });
  }
}
