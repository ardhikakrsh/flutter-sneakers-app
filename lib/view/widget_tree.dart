import 'package:flutter/material.dart';
import 'package:ppb_test/data/notifiers.dart';
import 'package:ppb_test/view/pages/collections_page.dart';
import 'package:ppb_test/view/pages/home_page.dart';
import 'package:ppb_test/view/pages/profile_page.dart';
import 'package:ppb_test/view/pages/settings_page.dart';
import 'package:ppb_test/view/pages/welcome_page.dart';
import 'package:ppb_test/view/widgets/navbar_widget.dart';

List<Widget> pages = [
  const HomePage(),
  const CollectionsPage(),
  const ProfilePage(),
];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sole City Kicks'),
        actions: [
          IconButton(
            onPressed: () {
              isDarkModeNotifier.value = !isDarkModeNotifier.value;
            },
            icon: ValueListenableBuilder(
              valueListenable: isDarkModeNotifier,
              builder: (context, isDarkMode, child) {
                return Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode);
              },
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SettingsPage();
                  },
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
        centerTitle: true,
      ),
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black87,
                ),
                accountName: Text(
                  'Sole City Kicks',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                accountEmail: Text('info@solecity.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/img/logo2.png'), // Ganti dengan logo Anda
                  backgroundColor: Colors.white,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.shopping_cart, color: Colors.blue),
                title: const Text('My Chart'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CollectionsPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.grey),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WelcomePage()),
                  );
                },
              ),
              const Spacer(),
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
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),
      bottomNavigationBar: const NavbarWidget(),
    );
  }
}
