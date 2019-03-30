import 'package:demo_bloc/src/blocs/movies_detail_bloc.dart';
import 'package:demo_bloc/src/model/movie_detail_model.dart';
import 'package:flutter/material.dart';

class MovieDetailPage extends StatefulWidget {
  MovieDetailPage({Key key, this.movieName, this.movieId}) : super(key: key);
  final String movieName;
  final int movieId;

  @override
  State createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    movieDetailBloc.fetchMovieDetail(widget.movieId.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: StreamBuilder(
        stream: movieDetailBloc.movieDetail,
        builder: (context, AsyncSnapshot<MovieDetailModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<MovieDetailModel> snapshot) {
    return Text(snapshot.data.backdrop_path);
  }
}
