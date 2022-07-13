import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String text;
  final double size;

  const Heading({
    Key? key,
    required this.text,
    this.size = 16,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      child: Text(
        text,
        style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}