


import 'package:ditonton/domain/usecases/get_tv_on_the_air.dart';
import 'package:flutter/foundation.dart';

import '../../common/state_enum.dart';
import '../../domain/entities/tv.dart';

class OnTheAirTvNotifier extends ChangeNotifier {
  final GetTvOnTheAir getOnTheAirTv;

  OnTheAirTvNotifier(this.getOnTheAirTv);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _tv = [];
  List<Tv> get tv => _tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnTheAirTv() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAirTv.execute();

    result.fold(
          (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
          (moviesData) {
        _tv = moviesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}