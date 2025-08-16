class RateModel {

  String name;

  RateModel({required this.name});
  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  factory RateModel.fromJson(Map<String, dynamic> json) {

    return RateModel(
      name: json['name'],
    );
  }
}
