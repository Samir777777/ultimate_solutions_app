import 'package:flutter/material.dart';
import 'Screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  String selectedLanguageCode = '1'; // '1' = English, '2' = Arabic

  void changeLanguage(String langCode) {
    setState(() {
      selectedLanguageCode = langCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale(selectedLanguageCode == '1' ? 'en' : 'ar'),
      home: LoginScreen(languageCode: selectedLanguageCode),
      debugShowCheckedModeBanner: false,
    );
  }
}