part of 'tv_watchlist_status_bloc.dart';

abstract class TvWatchListStatusEvent extends Equatable {
  const TvWatchListStatusEvent();

  @override
  List<Object> get props => [];
}

class OnTvWatchListStatusAdded extends TvWatchListStatusEvent {
  final TvDetail movieDetail;

  OnTvWatchListStatusAdded(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnTvWatchListStatusRemoved extends TvWatchListStatusEvent {
  final TvDetail movieDetail;

  OnTvWatchListStatusRemoved(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnTvWatchListStatusFavorited extends TvWatchListStatusEvent {
  final TvDetail movieDetail;

  OnTvWatchListStatusFavorited(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

