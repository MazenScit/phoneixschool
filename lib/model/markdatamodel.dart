class MarkModel {
  final dynamic year;
  final dynamic data;
  
  MarkModel({
    required this.year,
    required this.data,
  });

  factory MarkModel.fromJson(Map<String, dynamic> json) {
    return MarkModel(
      year: json['year'] as dynamic,
      data: json['data'] as dynamic,
    );
  }
}
