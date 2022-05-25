
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchListBloc
    extends Bloc<MovieWatchListEvent, MovieWatchListState> {
  final GetWatchlistMovies getWatchlistTv;

  MovieWatchListBloc(this.getWatchlistTv)
      : super(MovieWatchListEmpty()) {
    on<MovieWatchListEvent>((event, emit) async {
      if (event is OnMovieWatchListRequested) {
        emit(MovieWatchListLoading());
        final result = await getWatchlistTv.execute();
        result.fold((failure) {
          emit(MovieWatchListError(failure.message));
        }, (data) {
          emit(MovieWatchListSuccess(data));
        });
      }
    });
  }
}
