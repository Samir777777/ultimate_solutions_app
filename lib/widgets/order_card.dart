import 'package:flutter/material.dart';
import '../models/order.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback onDetails;

  const OrderCard({Key? key, required this.order, required this.onDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color statusColor = Colors.orange;
    String statusText = 'غير معروف';

    switch (order.status) {
      case '0':
        statusColor = Colors.green;
        statusText = 'جديد';
        break;
      case '1':
        statusColor = Colors.blue;
        statusText = 'قيد التوصيل';
        break;
      case '2':
        statusColor = Colors.red;
        statusText = 'ملغى';
        break;
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      shadowColor: statusColor.withOpacity(0.5),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onDetails,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'رقم الفاتورة: ${order.billNo ?? "غير متوفر"}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[900],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 18, color: Colors.grey[700]),
                  const SizedBox(width: 8),
                  Text(
                    'تاريخ: ${order.billDate ?? "غير معروف"}',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 14),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}