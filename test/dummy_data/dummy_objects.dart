import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

final testMovie = Movie(
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

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

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

final testTvList = [tTv];

