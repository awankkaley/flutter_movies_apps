
part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchListState extends Equatable {
  const MovieWatchListState();

  @override
  List<Object> get props => [];
}

class MovieWatchListEmpty extends MovieWatchListState {}

class MovieWatchListLoading extends MovieWatchListState {}

class MovieWatchListError extends MovieWatchListState {
  final String message;

  MovieWatchListError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchListSuccess extends MovieWatchListState {
  final List<Movie> result;

  MovieWatchListSuccess(this.result);

  @override
  List<Object> get props => [result];
}