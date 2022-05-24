import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/tv_detail.dart';
import '../repositories/movie_repository.dart';

class GetTvDetail {
  final MovieRepository repository;

  GetTvDetail(this.repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getTvDetail(id);
  }
}
