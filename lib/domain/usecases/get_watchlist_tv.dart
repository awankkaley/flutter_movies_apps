

import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import '../../common/failure.dart';
import '../repositories/movie_repository.dart';

class GetWatchlistTv {
  final MovieRepository _repository;

  GetWatchlistTv(this._repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getWatchlistTv();
  }
}
