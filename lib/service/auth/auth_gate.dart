import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ppb_test/service/auth/welcome_page.dart';
import 'package:ppb_test/view/widget_tree.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // user is logged in
        if (snapshot.hasData) {
          return const WidgetTree();
        }

        // user is not logged in
        else {
          return const WelcomePage();
        }
      },
    ));
  }
}
