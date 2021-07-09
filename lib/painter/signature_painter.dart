import 'package:flutter/material.dart';

class SignaturePainter extends CustomPainter {
  SignaturePainter({required this.points,required this.signatureColor,required this.thickness,required this.strokeCap});

  List<Offset?> points;
  final Color signatureColor;
  final double thickness;
  final StrokeCap strokeCap;
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = signatureColor
      ..strokeWidth = thickness
      ..strokeCap = strokeCap;
    for (var i = 0; i < points.length - 1; i++) {
      if (points[i] != null &&
          points[i + 1] != null &&
          ((points[i]!.dy < size.height && points[i + 1]!.dy < size.height) &&
              (points[i]!.dy > 0 && points[i + 1]!.dy > 0)) &&
          ((points[i]!.dx < size.width && points[i + 1]!.dx < size.width) &&
              (points[i]!.dx > 0 && points[i + 1]!.dx > 0))) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
