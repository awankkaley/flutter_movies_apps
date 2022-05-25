part of 'movie_watchlist_status_bloc.dart';


abstract class MovieWatchListStatusEvent extends Equatable {
  const MovieWatchListStatusEvent();

  @override
  List<Object> get props => [];
}

class OnMovieWatchListStatusAdded extends MovieWatchListStatusEvent {
  final MovieDetail movieDetail;

  OnMovieWatchListStatusAdded(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnMovieWatchListStatusRemoved extends MovieWatchListStatusEvent {
  final MovieDetail movieDetail;

  OnMovieWatchListStatusRemoved(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnMovieWatchListStatusFavorited extends MovieWatchListStatusEvent {
  final MovieDetail movieDetail;

  OnMovieWatchListStatusFavorited(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

