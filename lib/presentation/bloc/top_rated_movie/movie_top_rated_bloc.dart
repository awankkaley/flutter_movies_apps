
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_top_rated_event.dart';
part 'movie_top_rated_state.dart';

class MovieTopRatedBloc
    extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final GetTopRatedMovies _getTopRatedMovies;

  MovieTopRatedBloc(this._getTopRatedMovies) : super(TopRatedEmpty()) {
    on<MovieTopRatedEvent>((event, emit) async {
      if (event is OnTopRatedRequested) {
        emit(TopRatedLoading());

        final result = await _getTopRatedMovies.execute();
        result.fold((failure) {
          emit(TopRatedError(failure.message));
        }, (data) {
          emit(TopRatedHasData(data));
        });
      }
    });
  }
}
