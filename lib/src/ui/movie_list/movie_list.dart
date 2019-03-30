import 'package:demo_bloc/src/blocs/movies_bloc.dart';
import 'package:demo_bloc/src/model/item_model.dart';
import 'package:demo_bloc/src/ui/detail/detail_page.dart';
import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    movieBloc.fetchAllMovies();
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: StreamBuilder(
        stream: movieBloc.allMovies,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
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

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.results.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailPage(movieId: snapshot.data.results[index].id,
                  movieName: snapshot.data.results[index].title,),
                ),
              );
            },
            child: Image.network(
              'https://image.tmdb.org/t/p/w185${snapshot.data
                  .results[index].poster_path}',
              fit: BoxFit.cover,
            ),
          );
        });
  }
}