import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ppb_test/view/pages/login_page.dart';
import 'package:ppb_test/view/pages/welcome_page.dart';
import 'package:ppb_test/view/widgets/hero_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPass = TextEditingController();
  TextEditingController controllerConfirmPass = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPass.dispose();
    controllerConfirmPass.dispose();
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
                title: 'Register',
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
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: controllerConfirmPass,
                obscureText: !isConfirmPasswordVisible,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
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
                    backgroundColor: Colors.teal,
                    minimumSize: const Size(
                        double.infinity, 40.0) // Warna tombol lebih sesuai
                    ),
                child: const Text('Register',
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    child: const Text(
                      ' Login here',
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

  void onRegisterPressed() {
    if (controllerEmail.text.isEmpty ||
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

    showAnimation(
      'Registration Success!',
      'assets/lotties/login.json',
      true,
    );
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
            builder: (context) => const WelcomePage(),
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
