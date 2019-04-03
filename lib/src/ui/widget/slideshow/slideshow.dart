import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo_bloc/src/blocs/movies_list_bloc.dart';
import 'package:demo_bloc/src/constant/global.dart';
import 'package:demo_bloc/src/model/item_model.dart';
import 'package:flutter/material.dart';

class SlideShowView extends StatefulWidget {

  final Function(int movieId) onItemInteraction;

  const SlideShowView({Key key, this.onItemInteraction}) : super(key: key);

  @override
  State createState() => _SlideShowViewState();
}

class _SlideShowViewState extends State<SlideShowView> {
  @override
  Widget build(BuildContext context) {
    movieListBloc.fetchMovieList(MovieListType.nowPlaying);
    return StreamBuilder(
      stream: movieListBloc.movieList,
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (snapshot.hasData) {
          return buildContent(snapshot, context);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildContent(AsyncSnapshot<ItemModel> snapshot, BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: CarouselSlider(
        height: width / 2,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        pauseAutoPlayOnTouch: Duration(seconds: 10),
        enlargeCenterPage: true,
        items: snapshot.data.results.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return InkWell(
                onTap: () {
                  if (widget.onItemInteraction != null) {
                    widget.onItemInteraction(item.id);
                  } else {
                    debugPrint("No handle");
                  }
                },
                child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: _buildItem(item.backdrop_path, item.original_title)
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  _buildItem(String imagePath, String title) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10.0,
      margin: EdgeInsets.only(left: 5, right: 5, bottom: 20),
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
              alignment: Alignment.bottomLeft,
              width: constraints.biggest.width,
              height: constraints.biggest.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 0.5, 0.7, 0.9],
                  colors: [
                    Color(0x00000000),
                    Color(0x00000000),
                    Color(0x22000000),
                    Color(0x66000000),
                  ],
                ),),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(title?.toUpperCase() ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Muli'
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }

}