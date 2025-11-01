import 'package:flutter/material.dart';
import '../widgets/login_input_fields.dart';
import '../widgets/login_buttons.dart';
import 'Choose_Language.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleShowMore() {}

  void _handleLogin() {
    final userId = _userIdController.text;
    final password = _passwordController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
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

                    SizedBox(width: 30),
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
                            color: const Color.fromARGB(255, 240, 237, 237),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => ChooseLanguageDialog(),
                            );
                          },
                        ),

                        //child: const Icon(Icons.language,size: 35, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const Center(
                  child: Text(
                    'Welcome Back!',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Log back into your account',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 40),
                LoginInputFields(
                  userIdController: _userIdController,
                  passwordController: _passwordController,
                ),
                const SizedBox(height: 20),
                LoginButtons(
                  onShowMore: _handleShowMore,
                  onLogin: _handleLogin,
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
