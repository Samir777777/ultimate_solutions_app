import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'dart:convert';
import 'orders_screen.dart'; // تأكد من مسار الاستيراد الصحيح لصفحة الطلبات
import '../Screens/Choose_Language.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiService apiService = ApiService();
  bool _isLoading = false; // لإظهار مؤشر تحميل

  void _handleShowMore() {
    // تنفيذ عند الضغط على "اظهر المزيد" إذا احتجت
  }

  void _handleLogin() async {
    final userId = _userIdController.text.trim();
    final password = _passwordController.text.trim();

    if (userId.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يرجى إدخال اسم المستخدم وكلمة المرور')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final requestBody = {
      "Value": {
        "P_LANG_NO": "1",
        "P_DLVRY_NO": userId,
        "P_PSSWRD": password,
      }
    };

    try {
      final response = await apiService.checkDeliveryLogin(requestBody);
      setState(() {
        _isLoading = false;
      });
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // يمكن التحقق من محتوى الرد إذا كان ناجحًا هنا
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم تسجيل الدخول بنجاح')),
        );
        // تنفيذ التنقل لصفحة الطلبات
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OrdersScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل تسجيل الدخول. تأكد من البيانات')),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ، يرجى المحاولة لاحقاً')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 60),
                Center(
                  child: Image.asset(
                    'assets/logo.png',
                    height: 140,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 120,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.language,
                            color: Color.fromARGB(255, 240, 237, 237),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => ChooseLanguageDialog(),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Center(
                  child: Text(
                    'Welcome Back!',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 8),
                Center(
                  child: Text(
                    'Log back into your account',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 40),
                TextField(
                  controller: _userIdController,
                  decoration: InputDecoration(
                    labelText: 'User ID',
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(height: 30),
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                  onPressed: _handleLogin,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text('Login', style: TextStyle(fontSize: 18)),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: _handleShowMore,
                  child: Text('Show more'),
                ),
                Expanded(
                  child: Image.asset('assets/truck_image.png', fit: BoxFit.contain),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

