import 'package:flutter/material.dart';
import 'package:ppb_test/service/auth/auth_service.dart';
import 'package:ppb_test/view/pages/login/login_page.dart';
import 'package:ppb_test/view/widgets/hero_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
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
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const HeroWidget(title: 'Reset\nPassword'),
                      const SizedBox(height: 30.0),
                      const Text(
                        'Enter Your Email Address to Reset Your Password and We Will Send You a Password Reset Link.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 30.0),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail),
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      FilledButton(
                        onPressed: resetPassword,
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shadowColor: Colors.blue.shade300,
                          elevation: 5,
                          minimumSize: const Size(double.infinity, 40.0),
                        ),
                        child: const Text('Reset Password',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // reset password
  void resetPassword() async {
    if (emailController.text.isEmpty) {
      showErrorDialog('Please enter your email address');
      return;
    }

    if (!emailController.text.contains('@gmail.com')) {
      showErrorDialog('Please enter a valid email address');
      return;
    }

    try {
      await AuthService().resetPassword(emailController.text);
      showSuccessDialog();
    } catch (e) {
      showErrorDialog(e.toString().replaceFirst('Exception: ', ''));
    }
  }

// Fungsi untuk menampilkan dialog error
  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Failed'),
        content: Text(message),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              fixedSize: const Size(80, 40),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }

// Fungsi untuk menampilkan dialog sukses
  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Success',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        content: const Text(
            'Password reset link has been sent to your email address'),
        actions: [
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  fixedSize: const Size(100, 40),
                ),
                onPressed: () {
                  resetPassword();
                },
                child: const Text('Resend'),
              ),
              const SizedBox(width: 10.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  fixedSize: const Size(100, 40),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: const Text('Done'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
