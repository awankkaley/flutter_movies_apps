import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_watchlist_bloc_test.mocks.dart';



@GenerateMocks([GetWatchlistMovies])
void main() {
  late MovieWatchListBloc bloc;
  late MockGetWatchlistMovies mock;

  setUp(() {
    mock = MockGetWatchlistMovies();
    bloc = MovieWatchListBloc(mock);
  });

  test('initial state should be empty', () {
    expect(bloc.state, MovieWatchListEmpty());
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

  blocTest<MovieWatchListBloc, MovieWatchListState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mock.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(OnMovieWatchListRequested()),
    expect: () => [
      MovieWatchListLoading(),
      MovieWatchListSuccess(tMovieList),
    ],
    verify: (bloc) {
      verify(mock.execute());
    },
  );

  blocTest<MovieWatchListBloc, MovieWatchListState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mock.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(OnMovieWatchListRequested()),
    expect: () => [
      MovieWatchListLoading(),
      MovieWatchListError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mock.execute());
    },
  );
}