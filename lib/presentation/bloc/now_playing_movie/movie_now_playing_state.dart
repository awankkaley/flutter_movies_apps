part of 'movie_now_playing_bloc.dart';

abstract class MovieNowPlayingState extends Equatable {
  const MovieNowPlayingState();

  @override
  List<Object> get props => [];
}

class NowPlayingEmpty extends MovieNowPlayingState {}

class NowPlayingLoading extends MovieNowPlayingState {}

class NowPlayingError extends MovieNowPlayingState {
  final String message;

  NowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingMovieHasData extends MovieNowPlayingState {
  final List<Movie> result;

  NowPlayingMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}