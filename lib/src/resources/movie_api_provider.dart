import 'dart:async';
import 'dart:convert';

import 'package:demo_bloc/src/model/item_model.dart';
import 'package:demo_bloc/src/model/movie_detail_model.dart';
import 'package:http/http.dart' show Client;

class MovieApiProvider {
  Client client = Client();
  final _apiKey = '802b2c4b88ea1183e50e6b285a27696e';

  Future<ItemModel> fetchMovieList() async {
    print("entered");
    final response = await client
        .get("http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey");
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<MovieDetailModel> fetchMovieDetail(String movieId) async {
    print("entered");
    final response = await client
        .get("http://api.themoviedb.org/3/movie/$movieId?api_key=$_apiKey");
    print(response.body.toString());
    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}