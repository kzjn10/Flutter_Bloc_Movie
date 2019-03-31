import 'package:demo_bloc/src/blocs/base.dart';
import 'package:demo_bloc/src/model/movie_image_model.dart';
import 'package:rxdart/rxdart.dart';


class MovieImageBloc extends BaseBloc<MovieImageModel> {

  Observable<MovieImageModel> get movieImages => fetcher.stream;

  fetchMovieImages(int movieId) async {
    MovieImageModel itemModel = await repository.fetchMovieImages(movieId);
    fetcher.sink.add(itemModel);
  }
}

final movieImageBloc = MovieImageBloc();