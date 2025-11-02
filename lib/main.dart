import 'package:flutter/material.dart';
import 'package:flutter_inactive_timer/flutter_inactive_timer.dart';
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
  late FlutterInactiveTimer _inactivityTimer;

  @override
  void initState() {
    super.initState();

    _inactivityTimer = FlutterInactiveTimer(
      timeoutDuration: 120,
      notificationPer: 20,
      onInactiveDetected: () {
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => LoginScreen(languageCode: selectedLanguageCode),
            ),
            (route) => false,
          );
        }
      },
      onNotification: () {
        print('Warning: Session will expire soon due to inactivity.');
      },
      requireExplicitContinue: false,
    );

    _inactivityTimer.startMonitoring();
  }

  @override
  void dispose() {
    _inactivityTimer.stopMonitoring();
    super.dispose();
  }

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
