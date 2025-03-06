import 'package:flutter/material.dart';
import 'package:ppb_test/data/notifiers.dart';
import 'package:ppb_test/view/pages/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.grey,
              brightness: isDarkMode ? Brightness.light : Brightness.dark,
            ),
          ),
          home: const WelcomePage(),
        );
      },
    );
  }
}
