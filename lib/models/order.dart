class Order {
  final String? id;
  final String? billNo;
  final String? billSrl;
  final String? billDate;
  final String status;

  Order({this.id, this.billNo, this.billSrl, this.billDate, required this.status});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['BILL_NO']?.toString(),
      billNo: json['BILL_NO']?.toString(),
      billSrl: json['BILL_SRL']?.toString(),
      billDate: json['BILL_DATE']?.toString(),
      status: json['DLVRY_STATUS_FLG']?.toString() ?? '0',
    );
  }
}
