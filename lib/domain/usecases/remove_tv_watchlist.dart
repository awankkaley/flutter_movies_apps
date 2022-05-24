

import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

import '../../common/failure.dart';
import '../repositories/movie_repository.dart';

class RemoveTvWatchlist {
  final MovieRepository repository;

  RemoveTvWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvDetail movie) {
    return repository.removeTvWatchlist(movie);
  }
}
