// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ppb_test/service/auth/auth_service.dart';
import 'package:ppb_test/view/pages/register_page.dart';
import 'package:ppb_test/view/widget_tree.dart';
import 'package:ppb_test/view/widgets/hero_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPass = TextEditingController();
  bool isPasswordVisible = false;

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const HeroWidget(title: 'Login'),
                    const SizedBox(height: 30.0),

                    // Email Input
                    TextField(
                      controller: controllerEmail,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),

                    // Password Input
                    TextField(
                      controller: controllerPass,
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),

                    // Login Button
                    FilledButton(
                      onPressed: onLoginPressed,
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shadowColor: Colors.blue.shade300,
                        elevation: 5,
                        minimumSize: const Size(double.infinity, 40.0),
                      ),
                      child: const Text('Login',
                          style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 10.0),

                    // Register Link
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        const Text('Don\'t have an account?'),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterPage(),
                              ),
                            );
                          },
                          child: const Text(
                            ' Register here',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Copyright Text Paling Bawah
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
      ),
    );
  }

  void onLoginPressed() async {
    final authService = AuthService();

    if (controllerEmail.text.isEmpty || controllerPass.text.isEmpty) {
      showAnimation(
          'Please fill all fields', 'assets/lotties/error.json', false);
      return;
    }

    // try sign in
    try {
      await authService.signInWithEmailAndPassword(
        controllerEmail.text,
        controllerPass.text,
      );
      showAnimation('Login Success!', 'assets/lotties/login.json', true);
    } catch (e) {
      showAnimation('Login Failed', 'assets/lotties/error.json', false);
    }
  }

  void showAnimation(String message, String animationPath, bool isSuccess) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                animationPath,
                fit: BoxFit.fill,
                height: 200.0,
                width: 200.0,
                repeat: false,
              ),
              Text(
                message,
                style: TextStyle(
                  color: isSuccess ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );

    if (isSuccess) {
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const WidgetTree(),
          ),
        );
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pop(context);
      });
    }
  }
}
