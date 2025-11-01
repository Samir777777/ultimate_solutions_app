class Order {
  final String id;
  final String status;
  final String description;

  Order({required this.id, required this.status, required this.description});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['OrderId'] ?? '',
      status: json['Status'] ?? '',
      description: json['Description'] ?? '',
    );
  }
}
