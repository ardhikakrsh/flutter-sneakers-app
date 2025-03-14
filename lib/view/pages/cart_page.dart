import 'package:flutter/material.dart';
import 'package:ppb_test/components/my_cart_tile.dart';
import 'package:ppb_test/models/store.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Store>(
      builder: (context, store, child) {
        final userCart = store.cart;

        return Scaffold(
            appBar: AppBar(
              title: const Text('My Cart'),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: userCart.length,
                    itemBuilder: (context, index) {
                      // get individual cart item
                      final cartItem = userCart[index];

                      //return card tile UI
                      return MyCartTile(cartItem: cartItem);
                    },
                  ),
                ),
              ],
            ));
      },
    );
  }
}
