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

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id']?.toString(),
      billNo: map['billNo']?.toString(),
      billSrl: map['billSrl']?.toString(),
      billDate: map['billDate']?.toString(),
      status: map['status'] ?? '0',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'billNo': billNo,
      'billSrl': billSrl,
      'billDate': billDate,
      'status': status,
    };
  }
}
