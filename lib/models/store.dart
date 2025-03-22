// ignore_for_file: unused_local_variable

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppb_test/models/cart_item.dart';

import 'shoes.dart';

class Store extends ChangeNotifier {
  final List<Shoes> _sneakers = [
    //basketball
    Shoes(
        id: '1',
        name: 'Nike GT Cut 2 Hyperpink',
        imagePath: 'assets/img/basketball/hyperpink.png',
        description:
            'The Nike Zoom GT Cut 2 Hyper Pink is part of the second edition of Nike’s Greater Than (GT) series with a focus on Air Zoom technology.',
        price: 2500000,
        size: [40, 40.5, 41, 42, 42.5, 43, 44, 44.5, 45.5, 46],
        category: SneakersCategory.basketball),
    Shoes(
        id: '2',
        name: 'Nike GT Cut 2 We Are All Greater',
        imagePath: 'assets/img/basketball/weareallgreater.png',
        description:
            'The Nike Zoom GT Cut 2 We Are All Greater is a basketball shoe from the Nike Zoom GT Cut 2 lineup that celebrates the power of unity and collective strength.',
        price: 2200000,
        size: [40, 40.5, 41, 42, 42.5, 43, 44, 44.5, 45.5, 46],
        category: SneakersCategory.basketball),
    Shoes(
        id: '3',
        name: 'Nike Kobe 4 Philly',
        imagePath: 'assets/img/basketball/kobe4philly.png',
        description:
            'Introducing the Nike Kobe 4 Protro Philly 2024, a stunning tribute to Kobe Bryant`s birthplace and the historical city of Philadelphia',
        price: 4200000,
        size: [40, 40.5, 41, 42, 42.5, 43, 44, 44.5, 45.5, 46],
        category: SneakersCategory.basketball),
    Shoes(
        id: '4',
        name: 'Nike Kobe 5 Undeafeated',
        imagePath: 'assets/img/basketball/kobe5undefeated.png',
        description:
            'The Nike Kobe 5 Protro Undefeated What If Multi is a unique pair of sneakers with right and left shoes, each sporting different colors such as black, metallic gold, university red, and white.',
        price: 5600000,
        size: [40, 40.5, 41, 42, 42.5, 43, 44, 44.5, 45.5, 46],
        category: SneakersCategory.basketball),
    Shoes(
        id: '5',
        name: 'Nike Kobe 6 Grinch',
        imagePath: 'assets/img/basketball/kobe6grinch.png',
        description:
            'The Kobe 6 Grinch originally debuted in 2010 when Kobe Bryant’s Los Angeles Lakers faced LeBron James’ Miami Heat in a legendary match up on Christmas Day. This is the first Kobe 6 to receive the Kobe Protro treatment, a design process that takes classic Kobe designs and updates them with modern tech for improved performance.',
        price: 9000000,
        size: [40, 40.5, 41, 42, 42.5, 43, 44, 44.5, 45.5, 46],
        category: SneakersCategory.basketball),
    Shoes(
        id: '6',
        name: 'Nike Kobe 8 Protro Radiant Emerald',
        imagePath: 'assets/img/basketball/kobe8emerald.png',
        description:
            'This sneaker captures the essence of Kobe Bryant`s dynamic playstyle and his legacy on the court, featuring a sleek White, Radiant Emerald, White colorway that stands out in any crowd.',
        price: 5600000,
        size: [40, 40.5, 41, 42, 42.5, 43, 44, 44.5, 45.5, 46],
        category: SneakersCategory.basketball),

    //sneaker
    Shoes(
        id: '7',
        name: 'Air Jordan 1 High Dark Mocha',
        imagePath: 'assets/img/sneaker/aj1mocha.png',
        description:
            'The Dark Mocha 1 was one of the most anticipated releases in 2020 due to its familiar colorblocking that referenced two of the greatest Jordan 1s of all-time, the Jordan 1 Travis Scott and the Jordan 1 Black Toe.',
        price: 5200000,
        size: [40, 40.5, 41, 42, 42.5, 43, 44, 44.5, 45.5, 46],
        category: SneakersCategory.sneaker),
    Shoes(
        id: '8',
        name: 'Nike Dunk Low Georgetown',
        imagePath: 'assets/img/sneaker/dunklowgeorge.png',
        description:
            'The Nike Dunk Low Georgetown arrives with a smooth grey leather upper with Midnight Navy overlays and Swooshes.',
        price: 2200000,
        size: [40, 40.5, 41, 42, 42.5, 43, 44, 44.5, 45.5, 46],
        category: SneakersCategory.sneaker),
    Shoes(
        id: '9',
        name: 'Nike Dunk Low Grey Fog',
        imagePath: 'assets/img/sneaker/dunklowgrey.png',
        description:
            'The Nike Dunk Low Grey Fog features a white leather upper with Grey Fog leather overlays and Swooshes.',
        price: 1800000,
        size: [40, 40.5, 41, 42, 42.5, 43, 44, 44.5, 45.5, 46],
        category: SneakersCategory.sneaker),
    Shoes(
        id: '10',
        name: 'Nike P-6000 Flat Pewter',
        imagePath: 'assets/img/sneaker/p6000_flatpewter.png',
        description:
            'The Flat Pewter iteration of the Nike P-6000 sports of base of matte gray mesh overlaid with strips of white leather and metallic-looking synthetic material with hits of aqua-green TPU.',
        price: 1900000,
        size: [40, 40.5, 41, 42, 42.5, 43, 44, 44.5, 45.5, 46],
        category: SneakersCategory.sneaker),
    Shoes(
        id: '11',
        name: 'Nike P-6000 Metallic Silver Sail',
        imagePath: 'assets/img/sneaker/p6000_metallic.png',
        description:
            'The Metallic Silver Nike P-6000 features an upper base crafted from breathable metallic fabric. Both vertical and horizontal overlays are constructed of chrome synthetic leather course across the upper, making it glisten.',
        price: 2100000,
        size: [40, 40.5, 41, 42, 42.5, 43, 44, 44.5, 45.5, 46],
        category: SneakersCategory.sneaker),
    //running
    Shoes(
        id: '12',
        name: 'Nike Air Zoom Alphafly Next% Barely Volt Orange',
        imagePath: 'assets/img/running/alphafly_volt.png',
        description:
            'The Nike Air Zoom Alphafly Next Barely Volt Orange has responsive Zoom X foam cushioning, woven cotton laces, and sock-like construction for a snug fit.',
        price: 3200000,
        size: [40, 40.5, 41, 42, 42.5, 43, 44, 44.5, 45.5, 46],
        category: SneakersCategory.running),
    Shoes(
        id: '13',
        name: 'Nike Air Zoom Alphafly NEXT% Eliud Kipchoge',
        imagePath: 'assets/img/running/alphafly_eliud.png',
        description:
            'The Nike Air Zoom Alphafly Next Kenya is a high-performance running shoe designed for serious athletes. This shoe features Nike`s innovative Zoom Air technology, which provides responsive cushioning and a comfortable fit.',
        price: 4240000,
        size: [40, 40.5, 41, 42, 42.5, 43, 44, 44.5, 45.5, 46],
        category: SneakersCategory.running),
    //football
    Shoes(
        id: '14',
        name: 'Nike Phantom GX Elite SE FG Thunder Pack',
        imagePath: 'assets/img/football/phantom_thunder.png',
        description:
            'Introducing the Nike Phantom GX Elite SE FG "Thunder Pack", the ultimate weapon for field domination. These electrifying cleats ignite the pitch with their bold black and yellow "Thunder Pack" design.',
        price: 8460000,
        size: [40, 40.5, 41, 42, 42.5, 43, 44, 44.5, 45.5, 46],
        category: SneakersCategory.football),
    Shoes(
        id: '15',
        name: 'Nike Phantom GX Elite Gripknit DF FG Peak Ready Pack',
        imagePath: 'assets/img/football/phantom_gripknit.png',
        description:
            'Elevate your game with the Nike Phantom GX Elite Gripknit FG "Peak Ready Pack". Engineered for precision control, this soccer cleat features a textured Gripknit upper for enhanced ball touch.',
        price: 5160000,
        size: [40, 40.5, 41, 42, 42.5, 43, 44, 44.5, 45.5, 46],
        category: SneakersCategory.football),
    Shoes(
        id: '16',
        name: 'Nike Mercurial Dream Speed Superfly 8 Elite FG Bright Mango',
        imagePath: 'assets/img/football/mecurial_mango.png',
        description:
            'These high-performance Nike shoes combine style and functionality to boost your game. Whether you`re playing on grass or turf, these bright and bold sneakers will help you stand out.',
        price: 6870000,
        size: [40, 40.5, 41, 42, 42.5, 43, 44, 44.5, 45.5, 46],
        category: SneakersCategory.football),
  ];

  /*
  * Getter 
  */

  List<Shoes> get sneakers => _sneakers;
  List<CartItem> get cart => _cart;

  /*
  * operations 
  */

  // user cart
  final List<CartItem> _cart = [];

  // add to cart
  void addToCart(Shoes shoes, selectedSize) {
    // see if the item is already in the cart with the same shoes and size
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      // chek if the shoes same
      bool isShoesSame = item.shoes == shoes;

      // check if the size same
      bool isSizeSame = item.selectedSize == selectedSize;

      return isShoesSame && isSizeSame;
    });

    // if item already exists, increase the quantity
    if (cartItem != null) {
      cartItem.quantity++;
    }
    // otherwise, add new item to cart
    else {
      _cart.add(CartItem(
        shoes: shoes,
        selectedSize: selectedSize,
      ));
    }

    notifyListeners();
  }

  // remove from cart
  void removeFromCart(CartItem cartItem) {
    // if quantity is more than 1, decrease the quantity
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
    }
    // otherwise, remove the item from cart
    else {
      _cart.remove(cartItem);
    }

    notifyListeners();
  }

  // get total price of cart
  int getTotalPrice() {
    int totalPrice = 0;

    for (CartItem cardItem in _cart) {
      totalPrice += cardItem.shoes.price * cardItem.quantity;
    }

    return totalPrice;
  }

  // get total number of items in cart
  int getTotalItems() {
    int totalItems = 0;

    for (CartItem cardItem in _cart) {
      totalItems += cardItem.quantity;
    }

    return totalItems;
  }

  // clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  /*
  * helpers 
  */

  // generate a receipt
  String displayReceipt() {
    final receipt = StringBuffer();
    // add header

    receipt.writeln("Here's your receipt:");
    receipt.writeln('');
    receipt.writeln(
        '----------------------------------------------------------------');

    // generate a unique transaction id
    receipt.writeln('Receipt #: ${generateTransactionId()}');

    // format the date to include up to second only
    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    receipt.writeln('Date: $formattedDate');
    receipt.writeln(
        '----------------------------------------------------------------');
    receipt.writeln('');

    for (final cartItem in _cart) {
      receipt.writeln(
        '${cartItem.shoes.name} - ${formatSize(cartItem.selectedSize)}:',
      );
      receipt.writeln(
          '${formatPrice(cartItem.shoes.price)} x ${cartItem.quantity}');
      receipt.writeln('');
    }

    receipt.writeln(
        '----------------------------------------------------------------');
    receipt.writeln('');
    receipt.writeln('Total Items: ${getTotalItems()}');
    receipt.writeln('Total Price: ${formatPrice(getTotalPrice())}');
    return receipt.toString();
  }

  // format double value into money format
  String formatPrice(int price) {
    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(price);
  }

  // format double value into size format
  String formatSize(double size) {
    return size % 1 == 0 ? size.toInt().toString() : size.toString();
  }

  // generate a unique id for each transaction
  String generateTransactionId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
