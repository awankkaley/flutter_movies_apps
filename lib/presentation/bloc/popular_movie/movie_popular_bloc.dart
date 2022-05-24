
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_popular_event.dart';
part 'movie_popular_state.dart';

class MoviePopularBloc
    extends Bloc<MoviePopularEvent, MoviePopularState> {
  final GetPopularMovies _getPopularMovies;

  MoviePopularBloc(this._getPopularMovies) : super(PopularEmpty()) {
    on<MoviePopularEvent>((event, emit) async {
      if (event is OnPopularRequested) {
        emit(PopularLoading());

        final result = await _getPopularMovies.execute();
        result.fold((failure) {
          emit(PopularError(failure.message));
        }, (data) {
          emit(PopularHasData(data));
        });
      }
    });
  }
}
