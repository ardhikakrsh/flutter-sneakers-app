import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:ppb_test/components/my_slide_button.dart';
import 'package:ppb_test/view/pages/delivery_progress_page.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Credit Card
                    CreditCardWidget(
                      cardNumber: cardNumber,
                      expiryDate: expiryDate,
                      cardHolderName: cardHolderName,
                      cvvCode: cvvCode,
                      showBackView: isCvvFocused,
                      onCreditCardWidgetChange: (p0) {},
                    ),

                    CreditCardForm(
                      cardNumber: cardNumber,
                      expiryDate: expiryDate,
                      cardHolderName: cardHolderName,
                      cvvCode: cvvCode,
                      onCreditCardModelChange: (data) {
                        setState(() {
                          cardNumber = data.cardNumber;
                          expiryDate = data.expiryDate;
                          cardHolderName = data.cardHolderName;
                          cvvCode = data.cvvCode;
                          isCvvFocused = data.isCvvFocused;
                        });
                      },
                      formKey: formKey,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MySlideButton(
                text: 'Slide to Pay',
                icon: Icons.attach_money_rounded,
                onSubmit: () {
                  userSlidePay();
                  return Future.value(true);
                },
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void userSlidePay() {
    if (formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DeliveryProgressPage(),
        ),
      );
    }
  }
}
