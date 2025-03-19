import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

class MySlideButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Future<dynamic>? Function()? onSubmit; // Perbaiki tipe data

  const MySlideButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SlideAction(
      innerColor: Colors.white,
      outerColor: Colors.blueAccent,
      elevation: 5,
      sliderButtonIcon: Icon(
        icon,
        color: Colors.blueAccent,
      ),
      height: 55, // Perkecil tinggi button
      sliderButtonIconPadding: 10, // Sesuaikan padding ikon
      text: text,
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 16, // Perkecil ukuran font
        fontWeight: FontWeight.w600,
        letterSpacing: 1.0,
      ),
      sliderRotate: true,
      onSubmit: onSubmit,
    );
  }
}
