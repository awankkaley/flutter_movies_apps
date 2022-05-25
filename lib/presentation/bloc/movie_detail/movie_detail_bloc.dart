import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getDetailMovie;

  MovieDetailBloc(this._getDetailMovie)
      : super(MovieDetailLoading()) {
    on<MovieDetailEvent>((event, emit) async {
      if (event is OnMovieDetailRequested) {
        emit(MovieDetailLoading());
        final result = await _getDetailMovie.execute(event.id);
        result.fold((failure) {
          emit(MovieDetailError(failure.message));
        }, (data) {
          emit(MovieDetailSuccess(data));
        });
      }
    });
  }
}
