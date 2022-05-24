part of 'movie_top_rated_bloc.dart';

abstract class MovieTopRatedState extends Equatable {
  const MovieTopRatedState();

  @override
  List<Object> get props => [];
}

class TopRatedEmpty extends MovieTopRatedState {}

class TopRatedLoading extends MovieTopRatedState {}

class TopRatedError extends MovieTopRatedState {
  final String message;

  TopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedHasData extends MovieTopRatedState {
  final List<Movie> result;

  TopRatedHasData(this.result);

  @override
  List<Object> get props => [result];
}