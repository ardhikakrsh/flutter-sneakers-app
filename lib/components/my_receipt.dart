import 'package:flutter/material.dart';
import 'package:ppb_test/components/my_button.dart';
import 'package:ppb_test/models/store.dart';
import 'package:provider/provider.dart';

class MyReceipt extends StatefulWidget {
  const MyReceipt({super.key});

  @override
  State<MyReceipt> createState() => _MyReceiptState();
}

class _MyReceiptState extends State<MyReceipt> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Thank you for your order!'),
              const SizedBox(height: 25),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: isDarkMode ? Colors.white : Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(25),
                child: Consumer<Store>(
                  builder: (context, store, child) =>
                      Text(store.displayReceipt()),
                ),
              ),
              const SizedBox(height: 25),
              MyButton(
                text: 'Back to Home',
                icon: Icons.home,
                onPressed: () {
                  backToHome();
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void backToHome() {
    context.read<Store>().clearCart();
  }
}
