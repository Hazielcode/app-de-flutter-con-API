import 'package:flutter/material.dart';
import 'login.dart';
import 'shared_styles.dart';

void main() {
  runApp(const GoogleStoreApp());
}

class GoogleStoreApp extends StatelessWidget {
  const GoogleStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Devs Portal',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: GoogleColors.blue,
          primary: GoogleColors.blue,
          secondary: GoogleColors.green,
          error: GoogleColors.red,
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: GoogleColors.grey100,
        fontFamily: 'Roboto',
      ),
      home: const LoginPage(),
    );
  }
}
