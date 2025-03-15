import 'package:flutter/material.dart';
import 'package:ppb_test/models/shoes.dart';

class MyQuantity extends StatelessWidget {
  final int quantity;
  final Shoes shoes;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const MyQuantity({
    super.key,
    required this.quantity,
    required this.shoes,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(50),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // decrement button
          GestureDetector(
            onTap: onDecrement,
            child: const Icon(
              Icons.remove,
              size: 20,
              color: Colors.white,
            ),
          ),

          // quantity count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              width: 14,
              child: Center(
                child: Text(
                  quantity.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          // increment button
          GestureDetector(
            onTap: onIncrement,
            child: const Icon(
              Icons.add,
              size: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
