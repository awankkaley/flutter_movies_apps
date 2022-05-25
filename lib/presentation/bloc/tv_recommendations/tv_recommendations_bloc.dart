import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_recommendations_event.dart';
part 'tv_recommendations_state.dart';

class TvRecommendationsBloc
    extends Bloc<TvRecommendationsEvent, TvRecommendationsState> {
  final GetTvRecommendations _getDetailMovie;

  TvRecommendationsBloc(this._getDetailMovie)
      : super(TvRecommendationsEmpty()) {
    on<TvRecommendationsEvent>((event, emit) async {
      if (event is OnTvRecommendationsRequested) {
        emit(TvRecommendationsLoading());
        final result = await _getDetailMovie.execute(event.id);
        result.fold((failure) {
          emit(TvRecommendationsError(failure.message));
        }, (data) {
          emit(TvRecommendationsSuccess(data));
        });
      }
    });
  }
}
