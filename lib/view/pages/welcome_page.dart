import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ppb_test/view/pages/login_page.dart';
import 'package:ppb_test/view/pages/register_page.dart';
// import 'package:ppb_test/view/widget_tree.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Lottie.asset(
              'assets/lotties/welcome.json',
              fit: BoxFit.fill,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FilledButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shadowColor: Colors.blue.shade300,
                        elevation: 5,
                        // Warna tombol lebih sesuai
                      ),
                      child: const Text('Register',
                          style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 10.0),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.blueAccent,
                          shadowColor: Colors.blue.shade300 // Warna teks tombol
                          ),
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30.0),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '© 2025 Sole City Kicks',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
