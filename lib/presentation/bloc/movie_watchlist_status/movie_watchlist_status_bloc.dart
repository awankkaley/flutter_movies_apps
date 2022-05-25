import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_watchlist_status_event.dart';
part 'movie_watchlist_status_state.dart';

class MovieWatchListStatusBloc
    extends Bloc<MovieWatchListStatusEvent, MovieWatchListStatusState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  final MovieWatchListBloc tvWatchListBloc;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieWatchListStatusBloc(this.tvWatchListBloc, this.getWatchListStatus,
      this.saveWatchlist, this.removeWatchlist)
      : super(MovieWatchListStatusEmpty()) {
    on<MovieWatchListStatusEvent>((event, emit) async {
      if (event is OnMovieWatchListStatusAdded) {
        final isAdded = await saveWatchlist.execute(event.movieDetail);

        isAdded.fold(
              (failure) async {
            emit(MovieWatchListStatusError(failure.message));
          },
              (successMessage) async {
            emit(MovieWatchListStatusSuccess(watchlistAddSuccessMessage));
            add(OnMovieWatchListStatusFavorited(event.movieDetail));
            tvWatchListBloc.add(OnMovieWatchListRequested());
          },
        );
      } else if (event is OnMovieWatchListStatusRemoved) {
        final isRemove = await removeWatchlist.execute(event.movieDetail);
        isRemove.fold(
              (failure) async {
            emit(MovieWatchListStatusError(failure.message));
          },
              (successMessage) async {
            emit(MovieWatchListStatusSuccess(watchlistRemoveSuccessMessage));
            add(OnMovieWatchListStatusFavorited(event.movieDetail));
            tvWatchListBloc.add(OnMovieWatchListRequested());
          },
        );
      } else if (event is OnMovieWatchListStatusFavorited) {
        final isFavorited =
        await getWatchListStatus.execute(event.movieDetail.id);
        emit(WatchlistStatusLoaded(isFavorited));
      }
    });
  }
}
