import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
  String confirmedEmail = 'dhika';
  String confirmedPassword = '123';

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
      body: SingleChildScrollView(
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag, // Menutup keyboard saat scroll
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const HeroWidget(
                title: 'Login',
              ),
              const SizedBox(height: 30.0),
              TextField(
                controller: controllerEmail,
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onEditingComplete: () {
                  setState(() {});
                },
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: controllerPass,
                obscureText: !isPasswordVisible,
                decoration: InputDecoration(
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
                onEditingComplete: () {
                  setState(() {});
                },
              ),
              const SizedBox(height: 10.0),
              FilledButton(
                onPressed: () {
                  onLoginPressed();
                },
                style: FilledButton.styleFrom(
                    backgroundColor: Colors.teal,
                    minimumSize: const Size(
                        double.infinity, 40.0) // Warna tombol lebih sesuai
                    ),
                child:
                    const Text('Login', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()));
                    },
                    child: const Text(
                      ' Register here',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ],
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    '© 2025 Sole City Kicks',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onLoginPressed() {
    if (controllerEmail.text == confirmedEmail &&
        controllerPass.text == confirmedPassword) {
      showAnimation(
        'Login Success!',
        'assets/lotties/login.json',
        true,
      );
    } else {
      showAnimation(
        'Login Failed!',
        'assets/lotties/error.json',
        false,
      );
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
