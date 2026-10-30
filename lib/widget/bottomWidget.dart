import 'package:flutter/material.dart';

class Bottomwidget extends StatelessWidget {
  const Bottomwidget({super.key, required this.text, this.color, this.ontap});

  final String text;
  final Color? color;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ontap,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color ?? Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
