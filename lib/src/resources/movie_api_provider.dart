import 'dart:async';
import 'dart:convert';

import 'package:demo_bloc/src/model/item_model.dart';
import 'package:demo_bloc/src/model/movie_detail_model.dart';
import 'package:demo_bloc/src/model/movie_image_model.dart';
import 'package:http/http.dart' show Client;

class MovieApiProvider {
  Client client = Client();
  final _apiKey = '802b2c4b88ea1183e50e6b285a27696e';

  Future<ItemModel> fetchMovieList(String type) async {
    final response = await client
        .get("http://api.themoviedb.org/3/movie/$type?api_key=$_apiKey");
    print(response.request.url);
    print(response.body.toString());
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<MovieDetailModel> fetchMovieDetail(int movieId) async {
    final response = await client
        .get("http://api.themoviedb.org/3/movie/$movieId?api_key=$_apiKey");
    print(response.body.toString());
    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }


  Future<MovieImageModel> fetchMovieImages(int movieId) async {
    final response = await client
        .get("http://api.themoviedb.org/3/movie/$movieId/images?api_key=$_apiKey");
    print(response.body.toString());
    if (response.statusCode == 200) {
      return MovieImageModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}