import 'package:flutter/material.dart';

enum ShapeType { 
  circle, 
  square, 
  triangle, 
  star, 
  pentagon, 
  rectangle, 
  oval, 
  hexagon, 
  crescent, 
  heart, 
  diamond 
}

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
  AppShape(id: 'square', name: 'Square', type: ShapeType.square, color: Colors.blue),
  AppShape(id: 'triangle', name: 'Triangle', type: ShapeType.triangle, color: Colors.green),
  AppShape(id: 'circle', name: 'Circle', type: ShapeType.circle, color: Colors.red),
  AppShape(id: 'rectangle', name: 'Rectangle', type: ShapeType.rectangle, color: Colors.orange),
  AppShape(id: 'oval', name: 'Oval', type: ShapeType.oval, color: Colors.purple),
  AppShape(id: 'hexagon', name: 'Hexagon', type: ShapeType.hexagon, color: Colors.cyan),
  AppShape(id: 'pentagon', name: 'Pentagon', type: ShapeType.pentagon, color: Colors.teal),
  AppShape(id: 'crescent', name: 'Crescent', type: ShapeType.crescent, color: Colors.amber),
  AppShape(id: 'heart', name: 'Heart', type: ShapeType.heart, color: Colors.pink),
  AppShape(id: 'diamond', name: 'Diamond', type: ShapeType.diamond, color: Colors.indigo),
];
