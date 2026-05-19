import 'package:flutter/material.dart';
import 'dart:math' as math;

class TracingValidator {
  static int validate({
    required String letter,
    required List<Offset?> points,
    required Size size,
    required double fontSize,
  }) {
    final validPoints = points.whereType<Offset>().toList();
    if (validPoints.isEmpty) return 0;

    // 1. Get the expected bounding box of the letter
    final textPainter = TextPainter(
      text: TextSpan(
        text: letter,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final textWidth = textPainter.width;
    final textHeight = textPainter.height;

    // Center the bounding box like the UI does
    final letterRect = Rect.fromLTWH(
      (size.width - textWidth) / 2,
      (size.height - textHeight) / 2,
      textWidth,
      textHeight,
    );

    // 2. Analyze user points
    int insideCount = 0;
    double minX = double.infinity, maxX = double.negativeInfinity;
    double minY = double.infinity, maxY = double.negativeInfinity;

    for (final point in validPoints) {
      if (letterRect.contains(point)) {
        insideCount++;
      }
      if (point.dx < minX) minX = point.dx;
      if (point.dx > maxX) maxX = point.dx;
      if (point.dy < minY) minY = point.dy;
      if (point.dy > maxY) maxY = point.dy;
    }

    final drawingBounds = Rect.fromLTRB(minX, minY, maxX, maxY);

    // Heuristic 1: Accuracy (points inside the letter rect / total points)
    final accuracy = insideCount / validPoints.length;

    // Heuristic 2: Spread (How much of the letter's dimensions did the drawing cover?)
    final spreadX = math.min(drawingBounds.width / letterRect.width, 1.0);
    final spreadY = math.min(drawingBounds.height / letterRect.height, 1.0);
    final spread = (spreadX + spreadY) / 2;

    // Heuristic 3: Point density
    // Numbers might need fewer points if they are simple (like '1')
    final isNumber = RegExp(r'^[0-9]+$').hasMatch(letter);
    final isEnoughPoints = validPoints.length > (isNumber ? 15 : 20);

    if (!isEnoughPoints) return 1;

    // Forgiving thresholds for children
    if (accuracy > 0.6 && spread > 0.6) {
      return 3;
    } else if (accuracy > 0.4 && spread > 0.3) {
      return 2;
    } else {
      return 1;
    }
  }
}
