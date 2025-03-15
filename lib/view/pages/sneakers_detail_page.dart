import 'package:flutter/material.dart';
import 'package:ppb_test/components/my_button.dart';
import 'package:ppb_test/models/shoes.dart';
import 'package:intl/intl.dart';
import 'package:ppb_test/models/store.dart';
import 'package:provider/provider.dart';

class SneakersDetailPage extends StatefulWidget {
  final Shoes shoe;
  const SneakersDetailPage({super.key, required this.shoe});

  @override
  State<SneakersDetailPage> createState() => _SneakersDetailPageState();
}

class _SneakersDetailPageState extends State<SneakersDetailPage> {
  double? selectedSize;

  // method add to cart
  void addToCart(Shoes shoe, selectedSize) {
    if (selectedSize == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select a size first'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }
    context.read<Store>().addToCart(shoe, selectedSize);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sneaker Detail'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Sneaker Image
          Positioned(
            top: 40,
            left: 30,
            right: 30,
            child: Hero(
              tag: widget.shoe.imagePath,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Image.asset(widget.shoe.imagePath),
              ),
            ),
          ),

          // Draggable Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.3,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[900] : Colors.blueGrey[100],
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(22)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.white : Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    // Sneaker Name
                    Text(
                      widget.shoe.name,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),

                    // Sneaker Price
                    const SizedBox(height: 5),
                    Text(
                      NumberFormat.currency(
                        locale: 'id',
                        symbol: 'Rp',
                        decimalDigits: 0,
                      ).format(widget.shoe.price),
                      style: TextStyle(
                        color: isDarkMode ? Colors.greenAccent : Colors.green,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Sneaker Description
                    const SizedBox(height: 20),
                    Text(
                      widget.shoe.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: isDarkMode ? Colors.grey[400] : Colors.black87,
                      ),
                    ),

                    // Select Size
                    const SizedBox(height: 20),
                    Text(
                      "Select Size:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),

                    // Sneaker Size
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 10,
                      children: widget.shoe.size.map((size) {
                        return SizedBox(
                          width: 67,
                          child: ChoiceChip(
                            label: Center(
                              child: Text(
                                size % 1 == 0
                                    ? size.toInt().toString()
                                    : size.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: selectedSize == size
                                      ? Colors.white
                                      : isDarkMode
                                          ? Colors.white70
                                          : Colors.black87,
                                ),
                              ),
                            ),
                            selected: selectedSize == size,
                            selectedColor: Colors.blueAccent,
                            onSelected: (selected) {
                              setState(() {
                                selectedSize = selected ? size : null;
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 40),
                    MyButton(
                      text: 'Add to Cart',
                      icon: Icons.shopping_cart,
                      onPressed: () {
                        addToCart(widget.shoe, selectedSize);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
