import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_recommendations_event.dart';
part 'movie_recommendations_state.dart';

class MovieRecommendationsBloc
    extends Bloc<MovieRecommendationsEvent, MovieRecommendationsState> {
  final GetMovieRecommendations _getDetailMovie;

  MovieRecommendationsBloc(this._getDetailMovie)
      : super(MovieRecommendationsEmpty()) {
    on<MovieRecommendationsEvent>((event, emit) async {
      if (event is OnMovieRecommendationsRequested) {
        emit(MovieRecommendationsLoading());
        final result = await _getDetailMovie.execute(event.id);
        result.fold((failure) {
          emit(MovieRecommendationsError(failure.message));
        }, (data) {
          emit(MovieRecommendationsSuccess(data));
        });
      }
    });
  }
}
