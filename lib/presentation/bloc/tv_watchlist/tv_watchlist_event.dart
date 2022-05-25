part of 'tv_watchlist_bloc.dart';

abstract class TvWatchListEvent extends Equatable {
  const TvWatchListEvent();

  @override
  List<Object> get props => [];
}

class OnTvWatchListRequested extends TvWatchListEvent {}
