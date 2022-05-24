import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_now_playing_event.dart';
part 'movie_now_playing_state.dart';

class MovieNowPlayingBloc
    extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  MovieNowPlayingBloc(this._getNowPlayingMovies) : super(NowPlayingEmpty()) {
    on<MovieNowPlayingEvent>((event, emit) async {
      if (event is OnMovieNowPlayingRequested) {
        emit(NowPlayingLoading());

        final result = await _getNowPlayingMovies.execute();
        result.fold((failure) {
          emit(NowPlayingError(failure.message));
        }, (data) {
          emit(NowPlayingMovieHasData(data));
        });
      }
    });
  }
}
