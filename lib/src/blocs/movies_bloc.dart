import 'package:demo_bloc/src/blocs/base.dart';
import 'package:demo_bloc/src/model/item_model.dart';
import 'package:rxdart/rxdart.dart';


class MoviesBloc extends BaseBloc<ItemModel> {

  Observable<ItemModel> get allMovies => fetcher.stream;

  fetchAllMovies() async {
    ItemModel itemModel = await repository.fetchAllMovies();
    fetcher.sink.add(itemModel);
  }
}

final movieBloc = MoviesBloc();