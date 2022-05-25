import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail _getDetailTv;

  TvDetailBloc(this._getDetailTv)
      : super(TvDetailLoading()) {
    on<TvDetailEvent>((event, emit) async {
      if (event is OnTvDetailRequested) {
        emit(TvDetailLoading());
        final result = await _getDetailTv.execute(event.id);
        result.fold((failure) {
          emit(TvDetailError(failure.message));
        }, (data) {
          emit(TvDetailSuccess(data));
        });
      }
    });
  }
}
