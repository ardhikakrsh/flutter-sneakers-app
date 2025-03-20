import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ppb_test/service/auth/auth_service.dart';
import 'package:ppb_test/view/pages/cart_page.dart';
import 'package:ppb_test/view/pages/history_page.dart';
import 'package:ppb_test/view/pages/settings_page.dart';
import 'package:ppb_test/service/auth/welcome_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService().getCurrentUser();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.blueAccent : Colors.black87,
              ),
              accountName: Text(
                user?.displayName ?? 'No Name',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              accountEmail: Text(
                user?.email ?? 'No Email',
                style: TextStyle(color: Colors.white),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/icons/app_logo.png'), // Ganti dengan logo Anda
                backgroundColor: Colors.white,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart, color: Colors.blue),
              title: const Text('My Cart'),
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: const CartPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.grey),
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: const SettingsPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.history, color: Colors.green),
              title: const Text('History'),
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: const HistoryPage(),
                  ),
                );
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout'),
              onTap: () {
                logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomePage()),
                );
              },
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
}
