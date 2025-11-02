import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/order.dart';
import '../helpers/database_helper.dart';

class ApiService {
  static const String baseUrl = 'http://mdev.yemensoft.net:8087/OnyxDeliveryService/Service.svc/';

  Future<http.Response> checkDeliveryLogin(Map<String, dynamic> body) async {
    final url = Uri.parse('${baseUrl}CheckDeliveryLogin');
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
  }

  Future<List<Order>> fetchOrders(String deliveryNo, String langNo) async {
    final url = Uri.parse('${baseUrl}GetDeliveryBillsItems');

    final requestBody = {
      "Value": {
        "P_DLVRY_NO": deliveryNo,
        "P_LANG_NO": langNo,
        "P_BILL_SRL": "",
        "P_PRCSSD_FLG": ""
      }
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    print('Orders API response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      if (jsonData['Result'] != null && jsonData['Result']['ErrNo'] == 1) {
        return [];
      }


      final List billsJson = jsonData['Data']?['DeliveryBills'] ?? [];
      final orders = billsJson.map((json) => Order.fromJson(json)).toList();
      final dbHelper = DatabaseHelper.instance;
      await dbHelper.clearOrders();
      for (var order in orders) {
        await dbHelper.insertOrder(order);
      }

      return orders;
    } else {
      throw Exception('Failed to load orders');
    }
  }
      //return billsJson.map((json) => Order.fromJson(json)).toList();
    //} else {
      //throw Exception('Failed to load orders');
   // }
  //}

  Future<bool> updateOrderStatus(String orderId, String status) async {
    final url = Uri.parse('${baseUrl}UpdateOrderStatus');
    final body = {
      "Value": {
        "OrderID": orderId,
        "Status": status,
      }
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['success'] == true;
    } else {
      return false;
    }
  }
}