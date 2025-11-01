import 'package:flutter/material.dart';
import '../models/order.dart';
import '../services/api_service.dart';
import '../widgets/order_card.dart';

class OrdersScreen extends StatefulWidget {
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future<List<Order>> ordersFuture;
  String filter = 'New';
  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ordersFuture = apiService.fetchOrders();
  }


  void setFilter(String newFilter) {
    setState(() {
      filter = newFilter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ahmed Othman'),
        backgroundColor: Colors.red,
        actions: [
          Padding(
            padding: EdgeInsets.all(8),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: filter == 'New' ? Color(0xff13505B) : Colors.grey[200],
                    ),
                    onPressed: () => setFilter('New'),
                    child: Text(
                      'New',
                      style: TextStyle(color: filter == 'New' ? Colors.white : Colors.black),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: filter == 'Others' ? Color(0xff13505B) : Colors.grey[200],
                    ),
                    onPressed: () => setFilter('Others'),
                    child: Text(
                      'Others',
                      style: TextStyle(color: filter == 'Others' ? Colors.white : Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Order>>(
              future: ordersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final data = snapshot.data ?? [];
                final filtered = data.where((order) => order.status == filter).toList();
                if(filtered.isEmpty){
                  return Center(child: Text('No orders for filter: $filter'));
                }
                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) => OrderCard(order: filtered[index], onDetails: () {}),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
