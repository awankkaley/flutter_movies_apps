import 'package:dartz/dartz.dart';
import '../../common/failure.dart';
import '../entities/tv.dart';
import '../repositories/movie_repository.dart';

class GetPopularTv {
  final MovieRepository repository;

  GetPopularTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTvPopular();
  }
}