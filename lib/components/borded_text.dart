// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class BordedText extends StatelessWidget {
  String text;
  double? fontSize;
  Color? borderColor;
  Color? fillColor;

  BordedText({
    super.key,
    required this.text,
    this.fontSize,
    this.borderColor,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Texto com contorno
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize ?? 25,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 4
              ..color = borderColor ?? Colors.white, // Cor da borda
          ),
        ),
        // Texto principal (preenchimento)
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize ?? 25,
            fontWeight: FontWeight.bold,
            color: fillColor ?? Colors.black, // Cor do texto interno
          ),
        ),
      ],
    );
  }
}
