import 'package:demo_bloc/src/blocs/movies_detail_bloc.dart';
import 'package:demo_bloc/src/model/genre_model.dart';
import 'package:demo_bloc/src/model/movie_detail_model.dart';
import 'package:demo_bloc/src/model/production_country_model.dart';
import 'package:demo_bloc/src/ui/widget/movie_gallery/movie_gallery.dart';
import 'package:demo_bloc/src/utils/my_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

class MovieDetailPage extends StatefulWidget {
  MovieDetailPage({Key key, this.movieId}) : super(key: key);
  final int movieId;

  @override
  State createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    movieDetailBloc.fetchMovieDetail(widget.movieId);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildBody(context),
          Positioned( //Place it at the top, and not use the entire screen
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              title: Image.asset("res/graphic/icon_netflix.png"),
              centerTitle: true,
              brightness: Brightness.light,
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              //No more green
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.black, // Here
                  ),
                  onPressed: () {},
                ),
              ],
            ),),

        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyScrollBehavior(),
      child: SingleChildScrollView(
        child: StreamBuilder(
          stream: movieDetailBloc.movieDetail,
          builder: (context, AsyncSnapshot<MovieDetailModel> snapshot) {
            if (snapshot.hasData) {
              return buildContent(snapshot, context);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            return Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: Center(child: CircularProgressIndicator()));
          },
        ),
      ),
    );
  }

  Widget buildContent(AsyncSnapshot<MovieDetailModel> snapshot, BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildBackdrop(context, snapshot.data.backdrop_path),
          Padding(padding: EdgeInsets.only(top: 20),),
          Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildMovieName(context, snapshot.data.original_title),
                Padding(padding: EdgeInsets.only(top: 10),),
                _buildGenres(context, snapshot.data.genres),
                Padding(padding: EdgeInsets.only(top: 10),),
                _buildRating(context, snapshot.data.vote_average, snapshot.data.vote_count),
                Padding(padding: EdgeInsets.only(top: 10),),
                _buildMovieInfo(context, snapshot.data.release_date, snapshot.data.production_countries, snapshot.data.runtime,),
                Padding(padding: EdgeInsets.only(top: 20),),
                _buildMovieDescription(context, snapshot.data.overview),
                Padding(padding: EdgeInsets.only(top: 20),),
                _buildScreenShoot(context, snapshot.data.id)
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildBackdrop(BuildContext context, String backdrop) {
    return Container(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            var width = constraints.biggest.width;
            return Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ClipPath(
                        clipper: Mclipper(),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 10.0),
                                blurRadius: 10.0)
                          ]),
                          child: Container(
                            width: width,
                            height: width,
                            child: Image.network('https://image.tmdb.org/t/p/w780$backdrop', fit: BoxFit.cover,),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            IconButton(icon: Icon(Icons.add,), onPressed: () {
                              debugPrint("Hello");
                            },),
                            Expanded(
                              child: Container(),
                            ),
                            IconButton(icon: Icon(Icons.share,), onPressed: () {
                              debugPrint("Hello");
                            },),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  right: width / 2 - 25,
                  top: width,
                  child: FractionalTranslation(
                    translation: Offset(0.0, -0.5),
                    child: FloatingActionButton(onPressed: () {
                      print('Touch');
                    },
                      backgroundColor: Colors.white,
                      child: Icon(Icons.play_arrow, color: Colors.red, size: 40,),
                    ),
                  ),
                )
              ],
            );
          }

      ),
    );
  }

  _buildMovieName(BuildContext context, String name) {
    return Container(
      alignment: Alignment.center,
      child: Text(name,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black87,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: "Muli"),
      ),
    );
  }

  _buildGenres(BuildContext context, List<GenreModel> genres) {
    StringBuffer genresValue = StringBuffer();
    debugPrint("Genres size ${genres.length}");

    for (var item in genres) {
      if (item != null) {
        if (genresValue.length != 0) {
          genresValue.write(", ");
        }

        genresValue.write(item.name);
      }
    }

    return Container(
        alignment: Alignment.center,
        child: Text(genresValue.toString(),
          style: TextStyle(
              color: Colors.black45,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              fontFamily: "Muli"),)
    );
  }

  _buildRating(BuildContext context, double voteAverage, int voteCount) {
    return Container(
      alignment: Alignment.center,
      child: StarRating(
        size: 25.0,
        rating: voteAverage / 2,
        color: Colors.red,
        borderColor: Colors.black54,
        starCount: 5,
      ),
    );
  }

  _buildMovieInfo(BuildContext context, String year, List<ProductionCountryModel> productionCountry, int length) {
    StringBuffer productionCountries = StringBuffer();
    for (var item in productionCountry) {
      if (item != null) {
        if (productionCountries.length != 0) {
          productionCountries.write(", ");
        }

        productionCountries.write(item.id);
      }
    }

    return Container(
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          _buildMovieMoreInfoItem("Year", year.substring(0, 4) ?? ""),
          _buildMovieMoreInfoItem("Country", productionCountries.toString() ?? ""),
          _buildMovieMoreInfoItem("Length", "$length min"),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  _buildMovieDescription(BuildContext context, String description) {
    return GestureDetector(
      onTap: () {
        _expand();
      },
      child: Container(
        alignment: Alignment.center,
        child: AnimatedCrossFade(
          firstChild: Text(
            description,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.black87,
                fontSize: 14.0,
                fontFamily: "Muli"),
          ),
          secondChild: Text(
            description,
            style: TextStyle(
                color: Colors.black87,
                fontSize: 14.0,
                fontFamily: "Muli"),),

          crossFadeState: isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: kThemeAnimationDuration,
        ),
      ),
    );
  }

  _buildScreenShoot(BuildContext context, int movieId) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text("Screenshots", style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Muli"),
                ),
              ),
              Icon(Icons.arrow_forward, color: Colors.black,)
            ],
          ),
          MovieGallery(movieId: movieId,)
        ],
      ),
    );
  }

  _buildMovieMoreInfoItem(String title, String value) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            width: constraints.biggest.width > 100 ? 100 : double.infinity,
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              children: <Widget>[
                Text(title, style: TextStyle(
                    color: Colors.black45,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Muli"),
                ),
                Padding(padding: EdgeInsets.only(top: 5),),
                Wrap(
                  children: <Widget>[
                    Text(value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Muli"),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  void _expand() {
    setState(() {
      isExpanded ? isExpanded = false : isExpanded = true;
    });
  }

}

class Mclipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 40.0);

    var controlPoint = Offset(size.width / 4, size.height);
    var endpoint = Offset(size.width / 2, size.height);

    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endpoint.dx, endpoint.dy);

    var controlPoint2 = Offset(size.width * 3 / 4, size.height);
    var endpoint2 = Offset(size.width, size.height - 40.0);

    path.quadraticBezierTo(
        controlPoint2.dx, controlPoint2.dy, endpoint2.dx, endpoint2.dy);

    path.lineTo(size.width, 0.0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
