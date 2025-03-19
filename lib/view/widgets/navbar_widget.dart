import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ppb_test/data/notifiers.dart';

class NavbarWidget extends StatefulWidget {
  const NavbarWidget({super.key});

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          height: 70,
          color: Colors.blueAccent,
          items: const [
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(Icons.search, color: Colors.white),
            Icon(Icons.person, color: Colors.white),
          ],
          index: selectedPage,
          onTap: (index) {
            selectedPageNotifier.value = index;
          },
        );
      },
    );
  }
}
