import 'package:flutter/material.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Hero(
          tag: 'hero1',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              'assets/img/slide2.jpg',
              colorBlendMode: BlendMode.darken,
            ),
          ),
        ),
        FittedBox(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 50.0,
              letterSpacing: 30.0,
            ),
          ),
        ),
      ],
    );
  }
}
