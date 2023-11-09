class AdisorModel {
  final dynamic id;
  final dynamic name;

  AdisorModel({
    required this.id,
    required this.name,
  });

  factory AdisorModel.fromJson(Map<String, dynamic> json) {
    return AdisorModel(
      id: json['id'] as dynamic,
      name: json['name'] as dynamic,
    );
  }
}
