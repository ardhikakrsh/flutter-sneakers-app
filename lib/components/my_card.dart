import 'package:flutter/material.dart';

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
