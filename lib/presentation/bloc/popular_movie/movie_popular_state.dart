part of 'movie_popular_bloc.dart';

abstract class MoviePopularState extends Equatable {
  const MoviePopularState();

  @override
  List<Object> get props => [];
}

class PopularEmpty extends MoviePopularState {}

class PopularLoading extends MoviePopularState {}

class PopularError extends MoviePopularState {
  final String message;

  PopularError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularHasData extends MoviePopularState {
  final List<Movie> result;

  PopularHasData(this.result);

  @override
  List<Object> get props => [result];
}