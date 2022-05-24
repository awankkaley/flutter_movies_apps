import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/top_rated_movie/movie_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../provider/movie_list_notifier_test.mocks.dart';


@GenerateMocks([GetTopRatedMovies])
void main() {
  late MovieTopRatedBloc bloc;
  late MockGetTopRatedMovies mock;

  setUp(() {
    mock = MockGetTopRatedMovies();
    bloc = MovieTopRatedBloc(mock);
  });

  test('initial state should be empty', () {
    expect(bloc.state, TopRatedEmpty());
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];

  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mock.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(OnTopRatedRequested()),
    expect: () => [
      TopRatedLoading(),
      TopRatedHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mock.execute());
    },
  );

  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mock.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(OnTopRatedRequested()),
    expect: () => [
      TopRatedLoading(),
      TopRatedError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mock.execute());
    },
  );
}