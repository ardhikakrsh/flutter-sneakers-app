// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ppb_test/service/auth/auth_service.dart';
import 'package:ppb_test/service/database/firestore.dart';
import 'package:ppb_test/view/pages/login_page.dart';
import 'package:ppb_test/view/widgets/hero_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FirestoreService db = FirestoreService();

  final controllerName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPass = TextEditingController();
  final controllerConfirmPass = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  void dispose() {
    controllerName.dispose();
    controllerEmail.dispose();
    controllerPass.dispose();
    controllerConfirmPass.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
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
                // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag, // Menutup keyboard saat scroll
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const HeroWidget(
                        title: 'Register',
                      ),
                      const SizedBox(height: 30.0),
                      TextField(
                        controller: controllerName,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Full Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      TextField(
                        controller: controllerEmail,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
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
                      TextField(
                        controller: controllerConfirmPass,
                        obscureText: !isConfirmPasswordVisible,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: 'Confirm Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isConfirmPasswordVisible =
                                    !isConfirmPasswordVisible;
                              });
                            },
                            icon: Icon(
                              isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      FilledButton(
                        onPressed: () {
                          onRegisterPressed();
                        },
                        style: FilledButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shadowColor: Colors.blue.shade300,
                            elevation: 5,
                            minimumSize: const Size(double.infinity,
                                40.0) // Warna tombol lebih sesuai
                            ),
                        child: const Text('Register',
                            style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(height: 10.0),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          const Text('Already have an account?'),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                            },
                            child: const Text(
                              ' Login here',
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
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

  void onRegisterPressed() async {
    final authService = AuthService();

    if (controllerName.text.isEmpty ||
        controllerEmail.text.isEmpty ||
        controllerPass.text.isEmpty ||
        controllerConfirmPass.text.isEmpty) {
      showAnimation(
        'Please fill all fields!',
        'assets/lotties/error.json',
        false,
      );
      return;
    }

    if (controllerPass.text != controllerConfirmPass.text) {
      showAnimation(
        'Password does not match!',
        'assets/lotties/error.json',
        false,
      );
      return;
    }

    if (controllerPass.text == controllerConfirmPass.text) {
      try {
        await authService.signUpWithEmailPassword(
          controllerName.text,
          controllerEmail.text,
          controllerPass.text,
        );

        // save user data to firestore
        await db.saveUserDataToDatabase(
          controllerName.text,
          controllerEmail.text,
          controllerPass.text,
        );

        showAnimation(
          'Registration Success!',
          'assets/lotties/login.json',
          true,
        );
      } catch (e) {
        showAnimation(
            'Registration Failed', 'assets/lotties/error.json', false);
      }
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
            builder: (context) => const LoginPage(),
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
