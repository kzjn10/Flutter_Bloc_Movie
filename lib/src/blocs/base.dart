import 'package:demo_bloc/src/model/base_model.dart';
import 'package:demo_bloc/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc<T extends BaseModel> {
  final repository = Repository();
  final fetcher = PublishSubject<T>();

  dispose() {
    fetcher.close();
  }
}