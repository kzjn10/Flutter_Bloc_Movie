class ProductionCompanyModel {
  int id;
  String logo_path;
  String name;
  String origin_country;

  ProductionCompanyModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    name = parsedJson['name'];
    logo_path = parsedJson['logo_path'];
    origin_country = parsedJson['origin_country'];
  }

  static List<ProductionCompanyModel> fromJsonArray(List jsonArray) {
    return jsonArray?.map((item) {
      return ProductionCompanyModel.fromJson(item);
    })?.toList();
  }
}