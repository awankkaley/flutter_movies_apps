import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_popular_event.dart';
part 'tv_popular_state.dart';

class TvPopularBloc
    extends Bloc<TvPopularEvent, TvPopularState> {
  final GetPopularTv _getPopularTv;

  TvPopularBloc(this._getPopularTv) : super(TvPopularEmpty()) {
    on<TvPopularEvent>((event, emit) async {
      if (event is OnTvPopularRequested) {
        emit(TvPopularLoading());

        final result = await _getPopularTv.execute();
        result.fold((failure) {
          emit(TvPopularError(failure.message));
        }, (data) {
          emit(TvPopularHasData(data));
        });
      }
    });
  }
}
