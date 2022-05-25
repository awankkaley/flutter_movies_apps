

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_on_the_air.dart';
import 'package:ditonton/presentation/bloc/now_playing_tv/tv_now_playing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_now_playing_bloc_test.mocks.dart';


@GenerateMocks([GetTvOnTheAir])
void main() {
  late TvNowPlayingBloc tvNowPlayingBloc;
  late MockGetTvOnTheAir mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetTvOnTheAir();
    tvNowPlayingBloc = TvNowPlayingBloc(mockGetNowPlayingMovies);
  });

  test('initial state should be empty', () {
    expect(tvNowPlayingBloc.state, TvNowPlayingEmpty());
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

  blocTest<TvNowPlayingBloc, TvNowPlayingState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(tTvList));
      return tvNowPlayingBloc;
    },
    act: (bloc) => bloc.add(OnTvNowPlayingRequested()),
    expect: () => [
      TvNowPlayingLoading(),
      TvNowPlayingHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<TvNowPlayingBloc, TvNowPlayingState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvNowPlayingBloc;
    },
    act: (bloc) => bloc.add(OnTvNowPlayingRequested()),
    expect: () => [
      TvNowPlayingLoading(),
      TvNowPlayingError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );
}