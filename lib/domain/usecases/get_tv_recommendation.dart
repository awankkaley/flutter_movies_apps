import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';

import '../../common/failure.dart';
import '../repositories/movie_repository.dart';

class GetTvRecommendations {
  final MovieRepository repository;

  GetTvRecommendations(this.repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}