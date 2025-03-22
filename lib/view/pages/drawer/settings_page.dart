import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ppb_test/data/notifiers.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          centerTitle: true,
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin: const EdgeInsets.all(25.0),
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Dark Mode',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  ValueListenableBuilder(
                    valueListenable: isDarkModeNotifier,
                    builder: (context, isDarkMode, child) {
                      return CupertinoSwitch(
                        value: !isDarkMode,
                        onChanged: (value) {
                          isDarkModeNotifier.value = !isDarkModeNotifier.value;
                        },
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
