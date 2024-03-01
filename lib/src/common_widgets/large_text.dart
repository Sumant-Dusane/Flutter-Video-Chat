import 'package:flutter/material.dart';

class LargeText extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  final FontWeight fontWeight;

  LargeText({
    Key? key, 
    this.size = 30,
    required this.text,
    this.color = Colors.black,
    this.fontWeight = FontWeight.bold
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
      ),
    );
  }
}