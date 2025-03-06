import 'package:flutter/material.dart';

class Sneaker {
  final String name;
  final String imagePath;

  Sneaker({required this.name, required this.imagePath});
}

class SneakersDetailPage extends StatelessWidget {
  final Sneaker sneaker;
  const SneakersDetailPage({super.key, required this.sneaker});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(sneaker.name)),
      body: Stack(
        children: [
          // Gambar sepatu
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

          // DraggableScrollableSheet untuk detail
          DraggableScrollableSheet(
            initialChildSize: 0.6, // Ukuran awal 60% layar
            minChildSize: 0.3, // Minimum 30% layar
            maxChildSize: 0.8, // Bisa diperluas hingga 80%
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 10),
                  ],
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
                    const Text(
                      'This sneaker is a must-have for any sneakerhead. '
                      'It combines style and comfort, making it perfect for any occasion.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Buy Now"),
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
