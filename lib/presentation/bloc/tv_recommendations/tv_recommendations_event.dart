part of 'tv_recommendations_bloc.dart';

abstract class TvRecommendationsEvent extends Equatable {
  const TvRecommendationsEvent();

  @override
  List<Object> get props => [];
}

class OnTvRecommendationsRequested extends TvRecommendationsEvent {
  final int id;

  OnTvRecommendationsRequested(this.id);

  @override
  List<Object> get props => [id];
}
