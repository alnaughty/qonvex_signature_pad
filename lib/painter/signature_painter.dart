import 'package:flutter/material.dart';

class QonvexSignaturePainter extends CustomPainter {
  QonvexSignaturePainter(
      {required this.points,
      required this.signatureColor,
      required this.thickness,
      required this.strokeCap});

  /// Signature Points Source
  List<Offset?> points;

  /// Signature Stroke Color
  final Color signatureColor;

  /// Signature thickness
  final double thickness;

  ///Signature Stroke type
  final StrokeCap strokeCap;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = signatureColor
      ..strokeWidth = thickness
      ..strokeCap = strokeCap;

    /// Signature constraints on paint
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
