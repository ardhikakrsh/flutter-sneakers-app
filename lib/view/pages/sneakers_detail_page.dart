import 'package:flutter/material.dart';
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
    // if size is not selected
    if (selectedSize == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a size first'),
        ),
      );
      return;
    }
    context.read<Store>().addToCart(shoe, selectedSize);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sneaker Detail'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // shoes image
          Image.asset(
            widget.shoe.imagePath,
            fit: BoxFit.cover,
            // height: 300,
            width: double.infinity,
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.3,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
                  boxShadow: [BoxShadow(color: Colors.black, blurRadius: 10)],
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
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ), // sneaker name
                    Text(
                      widget.shoe.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // sneaker price
                    const SizedBox(height: 2),
                    Text(
                      NumberFormat.currency(
                        locale: 'id',
                        symbol: 'Rp',
                        decimalDigits: 0,
                      ).format(widget.shoe.price),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    //sneaker description
                    const SizedBox(height: 20),
                    Text(
                      widget.shoe.description,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),

                    //pick your size
                    const SizedBox(height: 20),
                    const Text(
                      "Select Size:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),

                    //snearker size
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 10,
                      children: widget.shoe.size.map((size) {
                        return SizedBox(
                          width: 67, // Atur lebar yang sama untuk semua kotak
                          child: ChoiceChip(
                            label: Center(
                              child: Text(size % 1 == 0
                                  ? size.toInt().toString()
                                  : size.toString()),
                            ),
                            selected: selectedSize == size,
                            onSelected: (selected) {
                              setState(() {
                                selectedSize = selected ? size : null;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () => addToCart(widget.shoe, selectedSize),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart),
                          SizedBox(width: 10),
                          Text('Add to Cart'),
                        ],
                      ),
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
