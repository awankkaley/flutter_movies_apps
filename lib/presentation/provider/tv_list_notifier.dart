
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/domain/usecases/get_tv_on_the_air.dart';
import 'package:flutter/material.dart';

class TvListNotifier extends ChangeNotifier {
  var _onTheAirTv = <Tv>[];
  List<Tv> get onTheAirTv => _onTheAirTv;

  RequestState _onTheAirState = RequestState.Empty;
  RequestState get onTheAIrState => _onTheAirState;

  var _popularTv = <Tv>[];
  List<Tv> get popularTv => _popularTv;

  RequestState _popularTvState = RequestState.Empty;
  RequestState get popularTvState => _popularTvState;

  var _topRatedTv = <Tv>[];
  List<Tv> get topRatedTv => _topRatedTv;

  RequestState _topRatedTvState = RequestState.Empty;
  RequestState get topRatedTvState => _topRatedTvState;

  String _message = '';
  String get message => _message;

  TvListNotifier({
    required this.getOnTheAIrTv,
    required this.getPopularTv,
    required this.getTopRatedTv,
  });

  final GetTvOnTheAir getOnTheAIrTv;
  final GetPopularTv getPopularTv;
  final GetTopRatedTv getTopRatedTv;

  Future<void> fetchOnTheAirTv() async {
    _onTheAirState = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAIrTv.execute();
    result.fold(
          (failure) {
        _onTheAirState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (moviesData) {
        _onTheAirState = RequestState.Loaded;
        _onTheAirTv = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTv() async {
    _popularTvState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTv.execute();
    result.fold(
          (failure) {
        _popularTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (moviesData) {
        _popularTvState = RequestState.Loaded;
        _popularTv = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTv() async {
    _topRatedTvState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTv.execute();
    result.fold(
          (failure) {
        _topRatedTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (moviesData) {
        _topRatedTvState = RequestState.Loaded;
        _topRatedTv = moviesData;
        notifyListeners();
      },
    );
  }
}
