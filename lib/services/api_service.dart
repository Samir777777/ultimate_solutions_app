import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/order.dart';

class ApiService {
  static const String baseUrl = 'http://mdev.yemensoft.net:8087/OnyxDeliveryService/Service.svc/';

  // دالة تسجيل الدخول
  Future<http.Response> checkDeliveryLogin(Map<String, dynamic> body) async {
    final url = Uri.parse('${baseUrl}CheckDeliveryLogin');
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
  }

  // دالة جلب الطلبات
  Future<List<Order>> fetchOrders() async {
    final url = Uri.parse('${baseUrl}GetDeliveryBillsItems');

    final requestBody = {
      "Value": {
        "P_DLVRY_NO": "1010", // عدّل حسب المستخدم الفعلي
        "P_LANG_NO": "1",
        "P_BILL_SRL": "",
        "P_PRCSSD_FLG": ""
      }
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      // عدّل المفتاح 'Orders' حسب شكل استجابة API
      final List ordersJson = jsonData['Orders'] ?? [];
      return ordersJson.map((json) => Order.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }
}
