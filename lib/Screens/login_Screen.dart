
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../Screens/orders_screen.dart';
import '../widgets/login_input_fields.dart';
import '../widgets/login_buttons.dart';
import '../screens/choose_language.dart';

class LoginScreen extends StatefulWidget {
  String languageCode;

  LoginScreen({Key? key, required this.languageCode}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiService _apiService = ApiService();

  bool _isLoading = false;

  @override
  void dispose() {
    _userIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final userId = _userIdController.text.trim();
    final password = _passwordController.text.trim();

    final requestBody = {
      "Value": {
        "P_LANG_NO": widget.languageCode,
        "P_DLVRY_NO": userId,
        "P_PSSWRD": password,
      }
    };

    try {
      final response = await _apiService.checkDeliveryLogin(requestBody);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.languageCode == '1' ? 'Login successful' : 'تم تسجيل الدخول بنجاح'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => OrderScreen(userId: userId, languageCode: widget.languageCode),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.languageCode == '1' ? 'Login failed. Check your credentials' : 'فشل تسجيل الدخول. تأكد من البيانات'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.languageCode == '1' ? 'Error occurred: $e' : 'حدث خطأ: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleShowMore() {
    // وظيفة زر Show More إذا تطلب الأمر
    print('Show More pressed');
  }

  Future<void> _chooseLanguage() async {
    final selectedLang = await showDialog<String>(
      context: context,
      builder: (context) =>  ChooseLanguageDialog(),
    );
    if (selectedLang != null && selectedLang != widget.languageCode) {
      setState(() {
        widget.languageCode = selectedLang;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEnglish = widget.languageCode == '1';

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Image.asset(
                        'assets/logo.png',
                        height: 140,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: Container(
                        height: 120,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30)),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.language, color: Color.fromARGB(255, 240, 237, 237)),
                          onPressed: _chooseLanguage,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Center(
                  child: Text(
                    isEnglish ? 'Welcome Back!' : 'مرحباً بعودتك!',
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    isEnglish ? 'Log back into your account' : 'سجل دخول إلى حسابك',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 40),
                LoginInputFields(
                  userIdController: _userIdController,
                  passwordController: _passwordController,
                  formKey: _formKey,
                ),
                const SizedBox(height: 20),
                LoginButtons(
                  onShowMore: _handleShowMore,
                  onLogin: _handleLogin,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: Image.asset(
                    'assets/truck_image.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
