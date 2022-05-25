part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class OnMovieDetailRequested extends MovieDetailEvent {
  final int id;

  OnMovieDetailRequested(this.id);

  @override
  List<Object> get props => [id];
}
