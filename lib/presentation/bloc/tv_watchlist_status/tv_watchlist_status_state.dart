
part of 'tv_watchlist_status_bloc.dart';

abstract class TvWatchListStatusState extends Equatable {
  const TvWatchListStatusState();

  @override
  List<Object> get props => [];
}

class TvWatchListStatusEmpty extends TvWatchListStatusState {}

class TvWatchListStatusLoading extends TvWatchListStatusState {}

class WatchlistStatusLoaded extends TvWatchListStatusState {
  final bool isAdded;

  WatchlistStatusLoaded(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}

class TvWatchListStatusError extends TvWatchListStatusState {
  final String message;

  TvWatchListStatusError(this.message);

  @override
  List<Object> get props => [message];
}

class TvWatchListStatusSuccess extends TvWatchListStatusState {
  final String message;

  TvWatchListStatusSuccess(this.message);

  @override
  List<Object> get props => [message];
}