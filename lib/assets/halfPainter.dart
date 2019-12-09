import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart';

class HalfPainter extends CustomPainter {

  Paint arcPaint;

  HalfPainter(Color paintColor) {

    this.arcPaint = Paint()..color = paintColor;
  }

  @override
  void paint(Canvas canvas, Size size) {

    final Rect beforeRect = Rect.fromLTWH(size.width / 4, 0, size.width / 2, size.height / 2);

    final path = Path();
    
    path.arcTo(beforeRect, radians(180), radians(180), false);

    canvas.drawPath(path, arcPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    
    return true;
  }
}