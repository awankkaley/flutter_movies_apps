import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_detail_bloc_test.mocks.dart';



@GenerateMocks([GetTvDetail])
void main() {
  late TvDetailBloc movieDetailBloc;
  late MockGetTvDetail mockGetDEtailMovies;

  setUp(() {
    mockGetDEtailMovies = MockGetTvDetail();
    movieDetailBloc = TvDetailBloc(mockGetDEtailMovies);
  });
  
  final tId = 1;

  final testTvDetail = TvDetail(
    backdropPath: "backdropPath",
    episodeRunTime: [1, 2, 3],
    firstAirDate: "firstAirDate",
    genres: [Genre(id: 1, name: 'Action')],
    homepage: "homepage",
    id: 1,
    inProduction: false,
    languages: ["UK", "ID"],
    lastAirDate: "lastAirDate",
    name: "name",
    numberOfEpisodes: 3,
    numberOfSeasons: 4,
    originCountry: ["UK", "ID"],
    originalLanguage: "UK",
    originalName: "originalName",
    overview: "overview",
    popularity: 1,
    posterPath: "posterPath",
    status: "status",
    tagline: "tagline",
    type: "type",
    voteAverage: 2,
    voteCount: 7,
  );


  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetDEtailMovies.execute(tId))
          .thenAnswer((_) async => Right(testTvDetail));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(OnTvDetailRequested(tId)),
    expect: () => [
      TvDetailLoading(),
      TvDetailSuccess(testTvDetail),
    ],
    verify: (bloc) {
      verify(mockGetDEtailMovies.execute(tId));
    },
  );

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetDEtailMovies.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(OnTvDetailRequested(tId)),
    expect: () => [
      TvDetailLoading(),
      TvDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetDEtailMovies.execute(tId));
    },
  );
}