import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/presentation/bloc/tv_watchlist/tv_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_watchlost_bloc_test.mocks.dart';




@GenerateMocks([GetWatchlistTv])
void main() {
  late TvWatchListBloc bloc;
  late MockGetWatchlistTv mock;

  setUp(() {
    mock = MockGetWatchlistTv();
    bloc = TvWatchListBloc(mock);
  });

  test('initial state should be empty', () {
    expect(bloc.state, TvWatchListEmpty());
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

  blocTest<TvWatchListBloc, TvWatchListState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mock.execute())
          .thenAnswer((_) async => Right(tTvList));
      return bloc;
    },
    act: (bloc) => bloc.add(OnTvWatchListRequested()),
    expect: () => [
      TvWatchListLoading(),
      TvWatchListSuccess(tTvList),
    ],
    verify: (bloc) {
      verify(mock.execute());
    },
  );

  blocTest<TvWatchListBloc, TvWatchListState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mock.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(OnTvWatchListRequested()),
    expect: () => [
      TvWatchListLoading(),
      TvWatchListError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mock.execute());
    },
  );
}