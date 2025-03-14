import 'package:ppb_test/models/shoes.dart';

class CartItem {
  Shoes shoes;
  double selectedSize;
  int quantity;

  CartItem({
    required this.shoes,
    required this.selectedSize,
    this.quantity = 1,
  });

  int get totalPrice {
    return shoes.price * quantity;
  }
}
