import 'package:flutter/material.dart';
import 'loading_login.dart';
import 'shared_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController(text: 'admin@google.com');
  final _passwordController = TextEditingController(text: 'admin123');

  void _login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email == 'admin@google.com' && password == 'admin123') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoadingLoginPage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Acceso Denegado'),
          content: const Text('Las credenciales ingresadas son incorrectas.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Entendido'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GoogleColors.grey100,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Card(
              color: Colors.white,
              elevation: 4,
              shadowColor: Colors.black.withOpacity(0.06),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: GoogleColors.grey200),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(width: 10, height: 10, decoration: const BoxDecoration(color: GoogleColors.blue, shape: BoxShape.circle)),
                        const SizedBox(width: 6),
                        Container(width: 10, height: 10, decoration: const BoxDecoration(color: GoogleColors.red, shape: BoxShape.circle)),
                        const SizedBox(width: 6),
                        Container(width: 10, height: 10, decoration: const BoxDecoration(color: GoogleColors.yellow, shape: BoxShape.circle)),
                        const SizedBox(width: 6),
                        Container(width: 10, height: 10, decoration: const BoxDecoration(color: GoogleColors.green, shape: BoxShape.circle)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Google Developers',
                      style: TextStyle(
                        color: GoogleColors.grey900,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Portal Corporativo de Ingeniería',
                      style: TextStyle(
                        color: GoogleColors.grey700,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 36),
                    GoogleTextField(
                      placeholder: 'Usuario corporativo',
                      icon: Icons.badge_outlined,
                      controller: _emailController,
                    ),
                    const SizedBox(height: 18),
                    GoogleTextField(
                      placeholder: 'Contraseña de red',
                      icon: Icons.lock_outline,
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    const SizedBox(height: 36),
                    SizedBox(
                      width: double.infinity,
                      child: GoogleButton(
                        text: 'Siguiente',
                        icon: Icons.arrow_forward,
                        onPressed: _login,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
