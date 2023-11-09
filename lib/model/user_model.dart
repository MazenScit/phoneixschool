class User_Model {
  final dynamic student_id;
  final dynamic student_card_id;
  final dynamic student_first_name;
  final dynamic student_middle_name;
  final dynamic student_last_name;

  User_Model({
    required this.student_id,
    required this.student_card_id,
    required this.student_first_name,
    required this.student_middle_name,
    required this.student_last_name,
  });

  factory User_Model.fromJson(Map<String, dynamic> json) {
    return User_Model(
      student_id: json['student_id'] as dynamic,
      student_card_id: json['student_card_id'] as dynamic,
      student_first_name: json['student_first_name'] as dynamic,
      student_middle_name: json['student_middle_name'] as dynamic,
      student_last_name: json['student_last_name'] as dynamic,
    );
  }
}
