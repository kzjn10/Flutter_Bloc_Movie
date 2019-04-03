import 'package:demo_bloc/src/blocs/movies_list_bloc.dart';
import 'package:demo_bloc/src/constant/global.dart';
import 'package:demo_bloc/src/model/item_model.dart';
import 'package:flutter/material.dart';

class MovieCategory extends StatefulWidget {

  @override
  State createState() => _MovieCategoryState();
}

class _MovieCategoryState extends State<MovieCategory> {
  @override
  Widget build(BuildContext context) {
    movieListBloc.fetchMovieList(MovieListType.upcoming);
    return StreamBuilder(
      stream: movieListBloc.movieList,
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (snapshot.hasData) {
          return buildContent(snapshot, context);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        return Container(
            padding: EdgeInsets.all(20.0),
            child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget buildContent(AsyncSnapshot<ItemModel> snapshot, BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Container(
      height: width / 4,
      margin: EdgeInsets.only(bottom: 10, top: 25),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data.results.length > 10 ? 10 : snapshot.data.results.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(snapshot.data.results[index].backdrop_path,
              snapshot.data.results[index].release_date,
              width / 3, index == 0);
        },
      ),
    );
  }

  _buildItem(String imagePath, String cate, double itemHeight, bool isFirst) {
    return Container(
      width: itemHeight * 4 / 3,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10.0,
        margin: EdgeInsets.only(left: isFirst ? 20 : 10, right: 10, bottom: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            children: <Widget>[
              Image.network('https://image.tmdb.org/t/p/w500$imagePath',
                fit: BoxFit.cover,
                height: constraints.biggest.height,
                width: constraints.biggest.width,
              ),
              Container(
                alignment: Alignment.center,
                width: constraints.biggest.width,
                height: constraints.biggest.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.1, 0.5, 0.7, 0.9],
                    colors: [
                      Color(0x99ff0000),
                      Color(0x66ff0000),
                      Color(0x66ff0000),
                      Color(0x99ff0000),
                    ],
                  ),),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(cate,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Muli'
                    ),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

}