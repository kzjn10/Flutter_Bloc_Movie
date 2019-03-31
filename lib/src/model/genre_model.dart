class GenreModel {
  int id;
  String name;

  GenreModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    name = parsedJson['name'];
  }

  static List<GenreModel> fromJsonArray(List jsonArray) {
    return jsonArray?.map((item) {
      return GenreModel.fromJson(item);
    })?.toList();
  }
}