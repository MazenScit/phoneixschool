class FinicailaModel {
  final dynamic order_id;
  final dynamic order_student_card_id;
  final dynamic order_charge_date;
  final dynamic order_item;
  final dynamic order_unit;
  final dynamic order_quantity;
  final dynamic order_price;
  final dynamic order_total;
  final dynamic order_date;
  final dynamic remain_balance;

  FinicailaModel({
    required this.order_id,
    required this.order_student_card_id,
    required this.order_charge_date,
    required this.order_item,
    required this.order_unit,
    required this.order_quantity,
    required this.order_price,
    required this.order_total,
    required this.order_date,
    required this.remain_balance,
  });

  factory FinicailaModel.fromJson(Map<String, dynamic> json) {
    return FinicailaModel(
      order_id: json['order_id'] as dynamic,
      order_student_card_id: json['order_student_card_id'] as dynamic,
      order_charge_date: json['order_charge_date'] as dynamic,
      order_item: json['order_item'] as dynamic,
      order_unit: json['order_unit'] as dynamic,
      order_quantity: json['order_quantity'] as dynamic,
      order_price: json['order_price'] as dynamic,
      order_total: json['order_total'] as dynamic,
      order_date: json['order_date'] as dynamic,
      remain_balance: json['remain_balance'] as dynamic
    );
  }
}
