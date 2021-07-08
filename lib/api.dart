import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_db/models/moviemodel.dart';
import 'package:movie_db/models/featuredmoviemodel.dart';

import 'models/genremodel.dart';
import 'models/trendingmoviemodel.dart';

class Api {
  var httpClient = http.Client();

  static const url = "https://api.themoviedb.org/3";
  static const apiKey = "4b132d8d955f95bf2ae463a2d294bcb4";

  Future<List<GenreModel>> getGenreList(int movieId) async {
    final response =
        await http.get('$url/movie/$movieId/credits?api_key=$apiKey');

    if (response.statusCode == 200) {
      final parsed =
          json.decode(response.body)['cast'].cast<Map<String, dynamic>>();

      return parsed
          .map<GenreModel>((json) => GenreModel.fromJson(json))
          .toList();
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<List<FeaturedMovieModel>> getFeaturedMovies() async {
    final response = await http.get('$url/movie/now_playing?api_key=$apiKey');
    print(response.body);
    if (response.statusCode == 200) {
      final parsed =
          json.decode(response.body)['results'].cast<Map<String, dynamic>>();
      print(parsed);
      return parsed
          .map<FeaturedMovieModel>((json) => FeaturedMovieModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load featured movies');
    }
  }

  Future<List<TrendingMovieModel>> getTrendingMovies() async {
    final response = await http.get('$url/trending/movie/day?api_key=$apiKey');
    print(response.body);
    if (response.statusCode == 200) {
      final parsed =
          json.decode(response.body)['results'].cast<Map<String, dynamic>>();
      print(parsed);
      return parsed
          .map<TrendingMovieModel>((json) => TrendingMovieModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load featured movies');
    }
  }

  Future<MovieModel> getMovieInfo(int movieId) async {
    final response = await http.get("$url/movie/$movieId?api_key=$apiKey");

    if (response.statusCode == 200) {
      return MovieModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Movie Information');
    }
  }
}
