class BelongToCollectionModel {
  int id;
  String name;
  String poster_path;
  String backdrop_path;

  BelongToCollectionModel.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson == null) {
      return;
    }

    id = parsedJson['id'] ?? 0;
    name = parsedJson['name'] ?? "";
    poster_path = parsedJson['poster_path'] ?? "";
    backdrop_path = parsedJson['backdrop_path'] ?? "";
  }
}