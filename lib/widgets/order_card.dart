import 'package:flutter/material.dart';
import '../models/order.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback onDetails;

  const OrderCard({Key? key, required this.order, required this.onDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(
          'Order ID: ${order.id}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(order.description),
        trailing: Text(
          order.status,
          style: TextStyle(
            color: order.status.toLowerCase() == 'new' ? Colors.green : Colors.orange,
            fontWeight: FontWeight.w600,
          ),
        ),
        onTap: onDetails,
      ),
    );
  }
}
