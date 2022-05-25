

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/presentation/bloc/popular_tv/tv_popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_popular_bloc_test.mocks.dart';




@GenerateMocks([GetPopularTv])
void main() {
  late TvPopularBloc tvNowPlayingBloc;
  late MockGetPopularTv mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularTv();
    tvNowPlayingBloc = TvPopularBloc(mockGetPopularMovies);
  });

  test('initial state should be empty', () {
    expect(tvNowPlayingBloc.state, TvPopularEmpty());
  });
  final tTv = Tv(
    backdropPath: "/T2Oi1KTOOVhHygBK99yX4QHZg9.jpg",
    firstAirDate: "2021-02-20",
    genreIds: [10759, 35, 18],
    id: 117376,
    name: "Vincenzo",
    originCountry: ["KR"],
    originalLanguage: "ko",
    originalName: "빈센조",
    overview:
    "Vincenzo Cassano is an Italian lawyer and Mafia consigliere who moves back to Korea due to a conflict within his organization. He ends up crossing paths with a sharp-tongued lawyer named Cha-young, and the two join forces in using villainous methods to take down villains who cannot be punished by the law.",
    popularity: 36.396,
    posterPath: "/dvXJgEDQXhL9Ouot2WkBHpQiHGd.jpg",
    voteAverage: 8.8,
    voteCount: 506,
  );

  final tTvList = <Tv>[tTv];

  blocTest<TvPopularBloc, TvPopularState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tTvList));
      return tvNowPlayingBloc;
    },
    act: (bloc) => bloc.add(OnTvPopularRequested()),
    expect: () => [
      TvPopularLoading(),
      TvPopularHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<TvPopularBloc, TvPopularState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvNowPlayingBloc;
    },
    act: (bloc) => bloc.add(OnTvPopularRequested()),
    expect: () => [
      TvPopularLoading(),
      TvPopularError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );
}