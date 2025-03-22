import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ppb_test/components/my_drawer.dart';
import 'package:ppb_test/data/notifiers.dart';
import 'package:ppb_test/view/pages/cart/cart_page.dart';
import 'package:ppb_test/view/pages/main/collections_page.dart';
import 'package:ppb_test/view/pages/main/home_page.dart';
import 'package:ppb_test/view/pages/main/profile_page.dart';
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
                PageTransition(
                  type: PageTransitionType.rightToLeftWithFade,
                  childCurrent: const WidgetTree(),
                  child: const CartPage(),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
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
