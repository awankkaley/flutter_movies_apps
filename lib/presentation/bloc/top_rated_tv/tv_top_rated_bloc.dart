import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_top_rated_event.dart';
part 'tv_top_rated_state.dart';

class TvTopRatedBloc
    extends Bloc<TvTopRatedEvent, TvTopRatedState> {
  final GetTopRatedTv _getTopRatedTv;

  TvTopRatedBloc(this._getTopRatedTv) : super(TvTopRatedEmpty()) {
    on<TvTopRatedEvent>((event, emit) async {
      if (event is OnTvTopRatedRequested) {
        emit(TvTopRatedLoading());

        final result = await _getTopRatedTv.execute();
        result.fold((failure) {
          emit(TvTopRatedError(failure.message));
        }, (data) {
          emit(TvTopRatedHasData(data));
        });
      }
    });
  }
}
