
part of 'movie_watchlist_status_bloc.dart';

abstract class MovieWatchListStatusState extends Equatable {
  const MovieWatchListStatusState();

  @override
  List<Object> get props => [];
}

class MovieWatchListStatusEmpty extends MovieWatchListStatusState {}

class MovieWatchListStatusLoading extends MovieWatchListStatusState {}

class WatchlistStatusLoaded extends MovieWatchListStatusState {
  final bool isAdded;

  WatchlistStatusLoaded(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}

class MovieWatchListStatusError extends MovieWatchListStatusState {
  final String message;

  MovieWatchListStatusError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchListStatusSuccess extends MovieWatchListStatusState {
  final String message;

  MovieWatchListStatusSuccess(this.message);

  @override
  List<Object> get props => [message];
}