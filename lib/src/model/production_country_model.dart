class ProductionCountryModel {
  String id;
  String name;

  ProductionCountryModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['iso_3166_1'];
    name = parsedJson['name'];
  }

  static List<ProductionCountryModel> fromJsonArray(List jsonArray) {
    return jsonArray?.map((item) {
      return ProductionCountryModel.fromJson(item);
    })?.toList();
  }
}