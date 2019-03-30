import 'dart:async';

import 'package:demo_bloc/src/model/item_model.dart';
import 'package:demo_bloc/src/model/movie_detail_model.dart';

import 'movie_api_provider.dart';

class Repository {
  final moviesApiProvider = MovieApiProvider();

  Future<ItemModel> fetchAllMovies() => moviesApiProvider.fetchMovieList();

  Future<MovieDetailModel> fetchMovieDetail(String movieId) => moviesApiProvider.fetchMovieDetail(movieId);
}