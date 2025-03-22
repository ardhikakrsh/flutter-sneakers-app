import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ppb_test/components/my_button.dart';
import 'package:ppb_test/components/my_cart_tile.dart';
import 'package:ppb_test/models/store.dart';
import 'package:ppb_test/service/auth/auth_service.dart';
import 'package:ppb_test/view/pages/payment/order_summary.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Map<String, dynamic> userData = {};
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<Store>(
      builder: (context, store, child) {
        final userCart = store.cart;

        return Scaffold(
          appBar: AppBar(
            title: const Text('My Cart'),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete All Items'),
                      content: const Text(
                          'Are you sure you want to delete all items?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            store.clearCart();
                            Navigator.pop(context);
                          },
                          child: const Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('No'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          body: Column(
            children: [
              // list of cart items
              Expanded(
                child: Column(
                  children: [
                    userCart.isEmpty
                        ? const Expanded(
                            child: Center(
                              child: Text('Your Cart is Empty! ☹️'),
                            ),
                          )
                        : Expanded(
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
                ),
              ),

              // buat total price
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Price:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      NumberFormat.currency(
                        locale: 'id',
                        symbol: 'Rp',
                        decimalDigits: 0,
                      ).format(store.getTotalPrice()),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // checkout button
              MyButton(
                text: 'Go to Checkout',
                icon: Icons.shopping_cart_checkout,
                onPressed: checkOut,
              ),
              const SizedBox(height: 25),
            ],
          ),
        );
      },
    );
  }

  Future<void> checkOut() async {
    setState(() {
      isLoading = true;
    });

    final store = Provider.of<Store>(context, listen: false);

    if (store.cart.isEmpty) {
      showAnimation(
        'Your cart is empty!',
        'assets/lotties/error.json',
        false,
      );
    } else {
      final user = AuthService().getCurrentUser();
      if (user != null) {
        try {
          // First try to get user doc using UID
          final userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

          if (userDoc.exists) {
            setState(() {
              userData = userDoc.data() ?? {};
            });
          } else {
            // If user doc doesn't exist by UID, try to find by email
            final querySnapshot = await FirebaseFirestore.instance
                .collection('users')
                .where('email', isEqualTo: user.email)
                .limit(1)
                .get();

            if (querySnapshot.docs.isNotEmpty) {
              setState(() {
                userData = querySnapshot.docs.first.data();
              });
            }
          }
        } catch (e) {
          // Handle error silently
          print("Error loading user data: $e");
        }

        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: PaymentPage(
              name: userData['name'] ?? '',
              email: userData['email'] ?? '',
              phone: userData['phone'] ?? '',
              cartItems: store.cart,
              totalPrice: store.getTotalPrice(),
            ),
          ),
        );
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  void showAnimation(String message, String animationPath, bool isSuccess) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                animationPath,
                fit: BoxFit.fill,
                height: 200.0,
                width: 200.0,
                repeat: false,
              ),
              Text(
                message,
                style: TextStyle(
                  color: isSuccess ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
