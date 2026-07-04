import 'dart:async';
import 'package:flutter/material.dart';
import 'home.dart';
import 'shared_styles.dart';

class LoadingLoginPage extends StatefulWidget {
  const LoadingLoginPage({super.key});

  @override
  State<LoadingLoginPage> createState() => _LoadingLoginPageState();
}

class _LoadingLoginPageState extends State<LoadingLoginPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: GoogleColors.grey100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(GoogleColors.blue),
              strokeWidth: 3,
            ),
            SizedBox(height: 24),
            Text(
              'Cargando credenciales de ingeniería...',
              style: TextStyle(
                color: GoogleColors.grey900,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
