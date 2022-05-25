part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchListEvent extends Equatable {
  const MovieWatchListEvent();

  @override
  List<Object> get props => [];
}

class OnMovieWatchListRequested extends MovieWatchListEvent {}
