import 'package:flutter/material.dart';
import '../models/order.dart';
import '../services/api_service.dart';

class OrderScreen extends StatefulWidget {
  final String userId;
  final String languageCode;

  const OrderScreen({Key? key, required this.userId, required this.languageCode}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int selectedTab = 0; // 0 = New, 1 = Others
  late Future<List<Order>> _ordersFuture;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  void _fetchOrders() {
    _ordersFuture = apiService.fetchOrders(widget.userId, widget.languageCode);
  }

  List<Order> _filterOrders(List<Order> orders) {
    if (selectedTab == 0) {
      return orders.where((o) => o.status == '0').toList(); // جديد
    } else {
      return orders.where((o) => o.status != '0').toList(); // الباقي
    }
  }

  Widget orderCard(Order order) {
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

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 6, offset: const Offset(0, 3))],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order.billNo ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text('Status'),
                Text(statusText, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total price'),
                Text('غير متوفر', style: const TextStyle(fontWeight: FontWeight.bold)), // اضبط القيمة إذا متوفرة
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Date'),
                Text(order.billDate ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Details for ${order.billNo ?? ''}'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Status: $statusText'),
                        Text('Date: ${order.billDate ?? ''}'),
                      ],
                    ),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
                    ],
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Text(
                  'Order Details',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/profile.jpg'),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Ahmed',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                      Text('Othman',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.menu, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = 0;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: selectedTab == 0 ? Colors.black : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          'New',
                          style: TextStyle(
                            color: selectedTab == 0 ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = 1;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: selectedTab == 1 ? Colors.black : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          'Others',
                          style: TextStyle(
                            color: selectedTab == 1 ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: FutureBuilder<List<Order>>(
                future: _ordersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text(
                        widget.languageCode == '1' ? 'Error: ${snapshot.error}' : 'حدث خطأ: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text(
                        widget.languageCode == '1' ? 'No orders found' : 'لا توجد طلبات'));
                  }

                  final filtered = _filterOrders(snapshot.data!);

                  if (filtered.isEmpty) {
                    return Center(child: Text(
                        widget.languageCode == '1' ? 'No orders in this category' : 'لا توجد طلبات في هذا التصنيف'));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) => orderCard(filtered[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}