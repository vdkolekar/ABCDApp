import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/app_shape.dart';
import '../widgets/shape_widget.dart';
import '../widgets/reward_dialog.dart';
import '../providers/progress_provider.dart';

class ShapesMatchingScreen extends ConsumerStatefulWidget {
  const ShapesMatchingScreen({super.key});

  @override
  ConsumerState<ShapesMatchingScreen> createState() => _ShapesMatchingScreenState();
}

class _ShapesMatchingScreenState extends ConsumerState<ShapesMatchingScreen> {
  late List<AppShape> draggableShapes;
  late List<AppShape> targetShapes;
  Map<String, bool> matched = {};

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  void _resetGame() {
    setState(() {
      draggableShapes = List.from(defaultShapes)..shuffle();
      targetShapes = List.from(defaultShapes)..shuffle();
      matched = {for (var shape in defaultShapes) shape.id: false};
    });
  }

  void _checkWin() {
    if (matched.values.every((isMatched) => isMatched)) {
      const stars = 3;
      ref.read(progressProvider.notifier).saveProgress(
        id: 'shapes_matching_all',
        category: 'shape',
        stars: stars,
      );

      showDialog(
        context: context,
        builder: (context) => const RewardDialog(stars: 3),
      ).then((_) {
        if (mounted) Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shape Matching'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetGame,
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          const Text(
            'Drag the shape to its shadow!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueGrey),
          ),
          const Spacer(),
          // Target Shadows
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: targetShapes.map((shape) {
              return DragTarget<AppShape>(
                onWillAcceptWithDetails: (details) => details.data.id == shape.id,
                onAcceptWithDetails: (details) {
                  setState(() {
                    matched[shape.id] = true;
                  });
                  _checkWin();
                },
                builder: (context, candidateData, rejectedData) {
                  if (matched[shape.id] == true) {
                    return ShapeWidget(type: shape.type, color: shape.color);
                  } else {
                    return ShapeWidget(type: shape.type, color: Colors.grey, isShadow: true);
                  }
                },
              );
            }).toList(),
          ),
          const Spacer(),
          // Draggable Shapes
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: Wrap(
              spacing: 30,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: draggableShapes.where((s) => matched[s.id] == false).map((shape) {
                return Draggable<AppShape>(
                  data: shape,
                  feedback: Material(
                    color: Colors.transparent,
                    child: ShapeWidget(type: shape.type, color: shape.color.withAlpha(180), size: 110),
                  ),
                  childWhenDragging: ShapeWidget(type: shape.type, color: Colors.transparent),
                  child: ShapeWidget(type: shape.type, color: shape.color),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
