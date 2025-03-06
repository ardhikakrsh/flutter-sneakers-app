import 'package:flutter/material.dart';
import 'sneakers_detail_page.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Sneaker> sneakers = [
      Sneaker(
          name: 'Nike Kobe 4 Philly', imagePath: 'assets/img/kobe4philly.png'),
      Sneaker(
          name: 'Nike Kobe 5 Undefeated',
          imagePath: 'assets/img/kobe5undefeated.png'),
      Sneaker(
          name: 'Nike GT Cut 2 Hyper Pink',
          imagePath: 'assets/img/hyperpink.png'),
      Sneaker(
          name: 'Nike GT Cut 2 We Are All Greater',
          imagePath: 'assets/img/weareallgreater.png'),
      Sneaker(
          name: 'Nike Dunk Low Grey', imagePath: 'assets/img/dunklowgrey.png'),
      Sneaker(
          name: 'Nike Dunk Low Georgetown',
          imagePath: 'assets/img/dunklowgeorge.png'),
      Sneaker(
          name: 'Air Jordan 1 High Dark Mocha',
          imagePath: 'assets/img/aj1mocha.png'),
      Sneaker(name: 'Nike Dunk Low VB', imagePath: 'assets/img/dunklowVB.png'),
    ];

    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: sneakers.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SneakersDetailPage(sneaker: sneakers[index]),
                ),
              );
            },
            child: CollectionItem(imagePath: sneakers[index].imagePath),
          );
        },
      ),
    );
  }
}

class CollectionItem extends StatelessWidget {
  final String imagePath;

  const CollectionItem({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(imagePath, fit: BoxFit.contain),
      ),
    );
  }
}
