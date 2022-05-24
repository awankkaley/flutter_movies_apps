import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import '../../common/failure.dart';
import '../repositories/movie_repository.dart';

class SaveTvWatchlist {
  final MovieRepository repository;

  SaveTvWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvDetail movie) {
    return repository.saveTvWatchlist(movie);
  }
}
