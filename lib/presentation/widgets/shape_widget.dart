import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../domain/models/app_shape.dart';

class ShapeWidget extends StatelessWidget {
  final ShapeType type;
  final Color color;
  final double size;
  final bool isShadow;

  const ShapeWidget({
    super.key,
    required this.type,
    required this.color,
    this.size = 100,
    this.isShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _ShapePainter(
        type: type,
        color: isShadow ? Colors.grey.withAlpha(100) : color,
      ),
    );
  }
}

class _ShapePainter extends CustomPainter {
  final ShapeType type;
  final Color color;

  _ShapePainter({required this.type, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    switch (type) {
      case ShapeType.circle:
        canvas.drawCircle(center, radius, paint);
        break;
      case ShapeType.square:
        canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
        break;
      case ShapeType.triangle:
        final path = Path()
          ..moveTo(size.width / 2, 0)
          ..lineTo(size.width, size.height)
          ..lineTo(0, size.height)
          ..close();
        canvas.drawPath(path, paint);
        break;
      case ShapeType.star:
        canvas.drawPath(_getStarPath(size.width, size.height), paint);
        break;
      case ShapeType.pentagon:
        canvas.drawPath(_getPolygonPath(5, size.width, size.height), paint);
        break;
    }
  }

  Path _getStarPath(double width, double height) {
    final path = Path();
    final double centerX = width / 2;
    final double centerY = height / 2;
    final double outerRadius = width / 2;
    final double innerRadius = width / 4;
    const int numPoints = 5;
    const double angleStep = (math.pi * 2) / (numPoints * 2);

    for (int i = 0; i < numPoints * 2; i++) {
      final double radius = i.isEven ? outerRadius : innerRadius;
      final double angle = i * angleStep - (math.pi / 2);
      final double x = centerX + radius * math.cos(angle);
      final double y = centerY + radius * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  Path _getPolygonPath(int sides, double width, double height) {
    final path = Path();
    final double centerX = width / 2;
    final double centerY = height / 2;
    final double radius = width / 2;
    final double angleStep = (math.pi * 2) / sides;

    for (int i = 0; i < sides; i++) {
      final double angle = i * angleStep - (math.pi / 2);
      final double x = centerX + radius * math.cos(angle);
      final double y = centerY + radius * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
