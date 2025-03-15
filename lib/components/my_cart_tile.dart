import 'package:flutter/material.dart';
import 'package:ppb_test/components/my_quantity.dart';
import 'package:ppb_test/models/cart_item.dart';
import 'package:ppb_test/models/store.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;

  const MyCartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Consumer<Store>(
      builder: (context, store, child) => Container(
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[900] : Colors.blueGrey[100],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Shoe Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                cartItem.shoes.imagePath,
                height: 100,
                width: 100,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 10),

            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.shoes.name,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    NumberFormat.currency(
                      locale: 'id',
                      symbol: 'Rp',
                      decimalDigits: 0,
                    ).format(cartItem.shoes.price),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.greenAccent : Colors.green,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cartItem.selectedSize % 1 == 0
                        ? 'Size: ${cartItem.selectedSize.toInt()}'
                        : 'Size: ${cartItem.selectedSize}',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            // Quantity Controls
            MyQuantity(
              quantity: cartItem.quantity,
              shoes: cartItem.shoes,
              onIncrement: () {
                store.addToCart(cartItem.shoes, cartItem.selectedSize);
              },
              onDecrement: () {
                store.removeFromCart(cartItem);
              },
            ),
          ],
        ),
      ),
    );
  }
}
