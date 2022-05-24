import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';

import '../../common/failure.dart';
import '../repositories/movie_repository.dart';

class GetTopRatedTv {
  final MovieRepository repository;

  GetTopRatedTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTvTopRated();
  }
}
