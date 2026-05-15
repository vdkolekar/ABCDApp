import 'package:flutter/material.dart';

enum ShapeType { circle, square, triangle, star, pentagon }

class AppShape {
  final String id;
  final String name;
  final ShapeType type;
  final Color color;

  AppShape({
    required this.id,
    required this.name,
    required this.type,
    required this.color,
  });
}

final List<AppShape> defaultShapes = [
  AppShape(id: '1', name: 'Circle', type: ShapeType.circle, color: Colors.red),
  AppShape(id: '2', name: 'Square', type: ShapeType.square, color: Colors.blue),
  AppShape(id: '3', name: 'Triangle', type: ShapeType.triangle, color: Colors.green),
  AppShape(id: '4', name: 'Star', type: ShapeType.star, color: Colors.yellow[700]!),
  AppShape(id: '5', name: 'Pentagon', type: ShapeType.pentagon, color: Colors.orange),
];
