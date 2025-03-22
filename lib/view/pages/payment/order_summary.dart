import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:ppb_test/components/my_slide_button.dart';
import 'package:ppb_test/models/cart_item.dart';
import 'package:lottie/lottie.dart';

class PaymentPage extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final List<CartItem> cartItems;
  final int totalPrice;

  const PaymentPage({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.cartItems,
    required this.totalPrice,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  MidtransSDK? _midtrans;
  String? transactionToken;
  bool isLoading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    initSDK();
    getMidtransToken();
  }

  // Initialize Midtrans SDK
  void initSDK() async {
    try {
      _midtrans = await MidtransSDK.init(
        config: MidtransConfig(
          clientKey: 'SB-Mid-client-2kYFyiPDSMnf0SM6',
          merchantBaseUrl: 'https://api.sandbox.midtrans.com',
          colorTheme: ColorTheme(
            colorPrimary: Colors.blue,
            colorPrimaryDark: Colors.blue.shade700,
            colorSecondary: Colors.blue.shade500,
          ),
        ),
      );

      _midtrans!.setTransactionFinishedCallback((result) {
        print("Transaction Result: ${result.toJson()}");
      });
    } catch (e) {
      setState(() {
        error = "Failed to initialize Midtrans SDK: $e";
        isLoading = false;
      });
      print("Error initializing Midtrans SDK: $e");
    }
  }

  // Get Midtrans token from backend
  Future<void> getMidtransToken() async {
    setState(() {
      isLoading = true;
      error = '';
    });

    try {
      // Format the items for the request
      final items = widget.cartItems
          .map((item) => {
                'id': item.shoes.id,
                'name': item.shoes.name,
                'price': item.shoes.price,
                'quantity': item.quantity,
              })
          .toList();

      final response = await http.post(
        Uri.parse(
            'http://10.0.2.2:3000/create-transaction'), // For Android emulator
        // Uri.parse('http://localhost:3000/create-transaction'), // For iOS simulator
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "order_id": "ORDER-${DateTime.now().millisecondsSinceEpoch}",
          "total_price": widget.totalPrice,
          "name": widget.name,
          "email": widget.email,
          "phone": widget.phone,
          "items": items,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          transactionToken = data["token"];
          isLoading = false;
        });
      } else {
        setState(() {
          error =
              "Failed to get transaction token. Status: ${response.statusCode}";
          isLoading = false;
        });
        print("API Error: ${response.body}");
      }
    } catch (e) {
      setState(() {
        error = "Network error: $e";
        isLoading = false;
      });
      print("Error fetching Midtrans token: $e");
    }
  }

  void showResultDialog(String message, String animationPath, bool isSuccess) {
    showDialog(
      context: context,
      barrierDismissible: false,
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
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (isSuccess) {
                  // Navigate back to home or shop page
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Summary'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Items list
              Expanded(
                child: ListView.builder(
                  itemCount: widget.cartItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(widget.cartItems[index].shoes.name),
                      subtitle: Text('${NumberFormat.currency(
                        locale: 'id',
                        symbol: 'Rp',
                        decimalDigits: 0,
                      ).format(widget.cartItems[index].shoes.price)} x ${widget.cartItems[index].quantity}'),
                    );
                  },
                ),
              ),

              // Total
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    NumberFormat.currency(
                      locale: 'id',
                      symbol: 'Rp',
                      decimalDigits: 0,
                    ).format(widget.totalPrice),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Customer details
              const Text(
                'Customer Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('Name: ${widget.name}'),
              Text('Email: ${widget.email}'),
              Text('Phone: ${widget.phone}'),
              const SizedBox(height: 24),

              // Payment button
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else if (error.isNotEmpty)
                Center(
                  child: Column(
                    children: [
                      Text(
                        error,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: getMidtransToken,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              else
                MySlideButton(
                  text: 'Slide to Pay',
                  icon: Icons.payment,
                  onSubmit: () async {
                    if (transactionToken != null) {
                      await _midtrans?.startPaymentUiFlow(
                          token: transactionToken!);
                      return true;
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Payment token not available")),
                      );
                      return false;
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
