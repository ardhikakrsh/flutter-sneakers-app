import 'package:flutter/material.dart';
import 'package:ppb_test/models/shoes.dart';

class SneakersDetailPage extends StatelessWidget {
  final Shoes sneaker;
  const SneakersDetailPage({super.key, required this.sneaker});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Positioned.directional(
            textDirection: Directionality.of(context),
            start: 0,
            end: 0,
            top: 0,
            child: Image.asset(
              sneaker.imagePath,
              fit: BoxFit.cover,
            ),
          ),
          DraggableScrollableSheet(
              initialChildSize: 0.6,
              minChildSize: 0.3,
              maxChildSize: 0.8,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.teal,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(22)),
                    boxShadow: [BoxShadow(color: Colors.black, blurRadius: 10)],
                  ),
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    children: [
                      Text(
                        sneaker.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        sneaker.description,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Buy Now'),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.shopping_cart),
                            label: const Text('Add to Cart'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}
