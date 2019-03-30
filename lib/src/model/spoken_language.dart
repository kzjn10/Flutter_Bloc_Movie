class SpokenLanguage {
  String iso_639_1;
  String name;

  SpokenLanguage.fromJson(Map<String, dynamic> parsedJson) {
    iso_639_1 = parsedJson['iso_639_1'];
    name = parsedJson['name'];
  }

  static List<SpokenLanguage> fromJsonArray(List jsonArray) {
    return jsonArray?.map((item) {
      return SpokenLanguage.fromJson(item);
    })?.toList();
  }
}