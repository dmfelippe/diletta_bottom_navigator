import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart';

class Painter extends CustomPainter {

  Paint arcPaint;

  Painter(Color paintColor) {

    this.arcPaint = Paint()..color = paintColor;
  }

  @override
  void paint(Canvas canvas, Size size) {

    print(size);

    final Rect beforeRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Rect largeRect = Rect.fromLTWH(10, 0, size.width - 20, 70);
    final Rect afterRect = Rect.fromLTWH(size.width - 10, (size.height / 2) - 10, 10, 10);

    final path = Path();
    path.arcTo(beforeRect, radians(180), radians(180), false);
    

    canvas.drawPath(path, arcPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    
    return true;
  }
}