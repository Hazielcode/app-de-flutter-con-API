import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login.dart';
import 'shared_styles.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: 'https://jucurerlhqjdtglbwkhw.supabase.co',
    anonKey: 'sb_publishable_-0dSYiZ2Wsf8md8LJN5GtQ_1lRq0mR5',
  );

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
