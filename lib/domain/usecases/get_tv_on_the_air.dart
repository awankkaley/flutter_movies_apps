import 'package:dartz/dartz.dart';
import '../../common/failure.dart';
import '../entities/tv.dart';
import '../repositories/movie_repository.dart';

class GetTvOnTheAir {
  final MovieRepository repository;

  GetTvOnTheAir(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTvOnTheAir();
  }
}