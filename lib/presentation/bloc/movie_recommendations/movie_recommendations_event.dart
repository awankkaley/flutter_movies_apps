part of 'movie_recommendations_bloc.dart';

abstract class MovieRecommendationsEvent extends Equatable {
  const MovieRecommendationsEvent();

  @override
  List<Object> get props => [];
}

class OnMovieRecommendationsRequested extends MovieRecommendationsEvent {
  final int id;

  OnMovieRecommendationsRequested(this.id);

  @override
  List<Object> get props => [id];
}
