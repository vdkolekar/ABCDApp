import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'tap_learn_screen.dart';
import 'drop_learn_screen.dart';
import 'trace_list_screen.dart';

enum CategoryType { letters, numbers, shapes }

class ActivitySelectionScreen extends StatelessWidget {
  final LearningMode mode;

  const ActivitySelectionScreen({super.key, required this.mode});

  String get _title {
    switch (mode) {
      case LearningMode.tap: return 'Tap & Learn';
      case LearningMode.drop: return 'Drop & Learn';
      case LearningMode.trace: return 'Trace & Learn';
    }
  }

  Color get _color {
    switch (mode) {
      case LearningMode.tap: return Colors.orange;
      case LearningMode.drop: return Colors.green;
      case LearningMode.trace: return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        backgroundColor: _color,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _CategoryButton(
              label: 'Letters',
              icon: Icons.abc,
              color: _color,
              onPressed: () => _navigate(context, CategoryType.letters),
            ),
            const SizedBox(height: 24),
            _CategoryButton(
              label: 'Numbers',
              icon: Icons.numbers,
              color: _color,
              onPressed: () => _navigate(context, CategoryType.numbers),
            ),
            if (mode != LearningMode.trace) ...[
              const SizedBox(height: 24),
              _CategoryButton(
                label: 'Shapes',
                icon: Icons.category,
                color: _color,
                onPressed: () => _navigate(context, CategoryType.shapes),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _navigate(BuildContext context, CategoryType category) {
    Widget screen;
    switch (mode) {
      case LearningMode.tap:
        screen = TapLearnScreen(category: category);
        break;
      case LearningMode.drop:
        screen = DropLearnScreen(category: category);
        break;
      case LearningMode.trace:
        screen = TraceListScreen(category: category);
        break;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _CategoryButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: color, width: 3),
        ),
        elevation: 4,
      ),
      child: Column(
        children: [
          Icon(icon, size: 64),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
