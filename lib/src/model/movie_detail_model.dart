import 'package:demo_bloc/src/model/base_model.dart';
import 'package:demo_bloc/src/model/belong_to_collection_model.dart';
import 'package:demo_bloc/src/model/genre_model.dart';
import 'package:demo_bloc/src/model/production_company_model.dart';
import 'package:demo_bloc/src/model/production_country_model.dart';
import 'package:demo_bloc/src/model/spoken_language.dart';

class MovieDetailModel extends BaseModel {
  bool adult;
  String backdrop_path;
  BelongToCollectionModel belongs_to_collection;
  int budget;
  List<GenreModel> genres = [];
  String homepage;
  int id;
  String imdb_id;
  String original_language;
  String original_title;
  String overview;
  double popularity;
  String poster_path;
  List<ProductionCompanyModel> production_companies = [];
  List<ProductionCountryModel> production_countries = [];
  String release_date;
  int revenue;
  int runtime;
  List<SpokenLanguage> spoken_languages = [];
  String status;
  String tagline;
  String title;
  bool video;
  double vote_average;
  int vote_count;

  MovieDetailModel.fromJson(Map<String, dynamic> parsedJson) {
    adult = parsedJson['adult'];
    backdrop_path = parsedJson['backdrop_path'];
    belongs_to_collection = BelongToCollectionModel.fromJson(parsedJson['belongs_to_collection']);
    budget = parsedJson['budget'];
    genres = GenreModel.fromJsonArray(parsedJson["genres"]);
    homepage = parsedJson['homepage'];
    id = parsedJson['id'];
    imdb_id = parsedJson['imdb_id'];
    original_language = parsedJson['original_language'];
    original_title = parsedJson['original_title'];
    overview = parsedJson['overview'];
    popularity = parsedJson['popularity'];
    poster_path = parsedJson['poster_path'];
    production_companies = ProductionCompanyModel.fromJsonArray(parsedJson['production_companies']);
    production_countries = ProductionCountryModel.fromJsonArray(parsedJson['production_countries']);
    release_date = parsedJson['release_date'];
    revenue = parsedJson['revenue'];
    runtime = parsedJson['runtime'];
    spoken_languages = SpokenLanguage.fromJsonArray(parsedJson['spoken_languages']);
    status = parsedJson['status'];
    tagline = parsedJson['tagline'];
    title = parsedJson['title'];
    video = parsedJson['video'];
    vote_average = parsedJson['vote_average'];
    vote_count = parsedJson['vote_count'];
  }
}





