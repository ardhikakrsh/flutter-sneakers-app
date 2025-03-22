import 'package:flutter/material.dart';
import 'package:ppb_test/components/my_card.dart';
import '../sneakers/sneakers_detail_page.dart';
import 'package:ppb_test/models/shoes.dart';
import 'package:ppb_test/models/store.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: Store().sneakers.length,
        itemBuilder: (context, index) {
          Shoes shoes = Store().sneakers[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SneakersDetailPage(shoe: shoes),
                ),
              );
            },
            child: CollectionItem(imagePath: shoes.imagePath),
          );
        },
      ),
    );
  }
}
