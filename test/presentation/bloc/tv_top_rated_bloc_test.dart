

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv/tv_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_top_rated_bloc_test.mocks.dart';



@GenerateMocks([GetTopRatedTv])
void main() {
  late TvTopRatedBloc tvNowPlayingBloc;
  late MockGetTopRatedTv mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedTv();
    tvNowPlayingBloc = TvTopRatedBloc(mockGetTopRatedMovies);
  });

  test('initial state should be empty', () {
    expect(tvNowPlayingBloc.state, TvTopRatedEmpty());
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

  blocTest<TvTopRatedBloc, TvTopRatedState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tTvList));
      return tvNowPlayingBloc;
    },
    act: (bloc) => bloc.add(OnTvTopRatedRequested()),
    expect: () => [
      TvTopRatedLoading(),
      TvTopRatedHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );

  blocTest<TvTopRatedBloc, TvTopRatedState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvNowPlayingBloc;
    },
    act: (bloc) => bloc.add(OnTvTopRatedRequested()),
    expect: () => [
      TvTopRatedLoading(),
      TvTopRatedError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );
}