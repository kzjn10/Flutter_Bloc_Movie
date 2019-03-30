class ProductionCountryModel {
  int id;
  String name;

  ProductionCountryModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    name = parsedJson['name'];
  }

  static List<ProductionCountryModel> fromJsonArray(List jsonArray) {
    return jsonArray?.map((item) {
      return ProductionCountryModel.fromJson(item);
    })?.toList();
  }
}