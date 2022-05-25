
part of 'tv_watchlist_bloc.dart';

abstract class TvWatchListState extends Equatable {
  const TvWatchListState();

  @override
  List<Object> get props => [];
}

class TvWatchListEmpty extends TvWatchListState {}

class TvWatchListLoading extends TvWatchListState {}

class TvWatchListError extends TvWatchListState {
  final String message;

  TvWatchListError(this.message);

  @override
  List<Object> get props => [message];
}

class TvWatchListSuccess extends TvWatchListState {
  final List<Tv> result;

  TvWatchListSuccess(this.result);

  @override
  List<Object> get props => [result];
}