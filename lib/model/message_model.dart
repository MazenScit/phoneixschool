class MessageModel {
  final dynamic message_id;
  final dynamic message_title;
  final dynamic message_receiver;
  final dynamic student_first_name;
  final dynamic student_middle_name;
  final dynamic message_body;
  final dynamic message_status;
  final dynamic message_send_date;
  final dynamic message_links;
  final dynamic message_attachments;
  final dynamic replies;
  final dynamic sender_type_id;
  final dynamic message_type;
  MessageModel({
    required this.message_id,
    required this.message_title,
    required this.message_receiver,
    required this.student_first_name,
    required this.student_middle_name,
    required this.message_body,
    required this.message_status,
    required this.message_send_date,
    required this.message_links,
    required this.message_attachments,
    required this.replies,
    required this.sender_type_id,
    required this.message_type,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message_id: json['message_id'] as dynamic,
      message_title: json['message_title'] as dynamic,
      message_receiver: json['message_receiver'] as dynamic,
      student_first_name: json['student_first_name'] as dynamic,
      student_middle_name: json['student_middle_name'] as dynamic,
      message_body: json['message_body'] as dynamic,
      message_status: json['message_status'] as dynamic,
      message_send_date: json['message_send_date'] as dynamic,
      message_links: json['message_links'] as dynamic,
      message_attachments: json['message_attachments'] as dynamic,
      replies: json['replies'] as dynamic,
      sender_type_id: json['sender_type_id'] as dynamic,
      message_type: json['message_type'] as dynamic,
    );
  }
}
