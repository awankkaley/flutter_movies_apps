

import 'dart:convert';

import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
    backdropPath : "/T2Oi1KTOOVhHygBK99yX4QHZg9.jpg",
    firstAirDate: "2021-02-20",
    genreIds: [10759, 35, 18],
    id : 117376,
    name : "Vincenzo",
    originCountry : ["KR"],
    originalLanguage : "ko",
    originalName : "빈센조",
    overview : "Vincenzo Cassano is an Italian lawyer and Mafia consigliere who moves back to Korea due to a conflict within his organization. He ends up crossing paths with a sharp-tongued lawyer named Cha-young, and the two join forces in using villainous methods to take down villains who cannot be punished by the law.",
    popularity : 36.396,
    posterPath : "/dvXJgEDQXhL9Ouot2WkBHpQiHGd.jpg",
    voteAverage : 8.8,
    voteCount : 506,
  );
  final tMovieResponseModel =  TvResponse(tvList: <TvModel>[tTvModel]);
  
  group('fromJson', () {
    test('should return a valid tv model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
      json.decode(readJson('dummy_data/tv_top_rated.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tMovieResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper tv data ', () async {

      final result = tMovieResponseModel.toJson();

      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/T2Oi1KTOOVhHygBK99yX4QHZg9.jpg",
            "first_air_date": "2021-02-20",
            "genre_ids": [
              10759,
              35,
              18
            ],
            "id": 117376,
            "name": "Vincenzo",
            "origin_country": [
              "KR"
            ],
            "original_language": "ko",
            "original_name": "빈센조",
            "overview": "Vincenzo Cassano is an Italian lawyer and Mafia consigliere who moves back to Korea due to a conflict within his organization. He ends up crossing paths with a sharp-tongued lawyer named Cha-young, and the two join forces in using villainous methods to take down villains who cannot be punished by the law.",
            "popularity": 36.396,
            "poster_path": "/dvXJgEDQXhL9Ouot2WkBHpQiHGd.jpg",
            "vote_average": 8.8,
            "vote_count": 506
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
