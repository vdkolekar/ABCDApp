import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/reward_dialog.dart';
import '../providers/progress_provider.dart';
import '../../data/services/tracing_validator.dart';

class AlphabetTracingScreen extends ConsumerStatefulWidget {
  final String letter;

  const AlphabetTracingScreen({super.key, required this.letter});

  @override
  ConsumerState<AlphabetTracingScreen> createState() => _AlphabetTracingScreenState();
}

class _AlphabetTracingScreenState extends ConsumerState<AlphabetTracingScreen> {
  List<Offset?> points = [];
  static const double _fontSize = 300;
  Size _canvasSize = Size.zero;

  void _onDone() {
    final stars = TracingValidator.validate(
      letter: widget.letter,
      points: points,
      size: _canvasSize,
      fontSize: _fontSize,
    );

    if (stars == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Try drawing the letter first!')),
      );
      return;
    }

    ref.read(progressProvider.notifier).saveProgress(
      id: RegExp(r'^[0-9]+$').hasMatch(widget.letter) 
          ? 'number_${widget.letter}' 
          : 'alphabet_${widget.letter.toLowerCase()}',
      category: RegExp(r'^[0-9]+$').hasMatch(widget.letter) ? 'number' : 'alphabet',
      stars: stars,
    );

    showDialog(
      context: context,
      builder: (context) => RewardDialog(stars: stars),
    ).then((_) {
      if (mounted && stars >= 2) {
        Navigator.pop(context);
      } else if (mounted) {
        setState(() => points.clear());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trace ${widget.letter}'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() => points.clear()),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          _canvasSize = Size(constraints.maxWidth, constraints.maxHeight);
          return Stack(
            children: [
              // Letter Template
              Center(
                child: Text(
                  widget.letter,
                  style: TextStyle(
                    fontSize: _fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.withAlpha(51), // ~0.2 opacity
                  ),
                ),
              ),
              // Tracing Layer
              GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    points.add(details.localPosition);
                  });
                },
                onPanEnd: (details) {
                  setState(() {
                    points.add(null);
                  });
                },
                child: CustomPaint(
                  painter: TracingPainter(points: points),
                  size: Size.infinite,
                ),
              ),
              // Done Button
              Positioned(
                bottom: 40,
                right: 40,
                child: FloatingActionButton.extended(
                  onPressed: _onDone,
                  backgroundColor: Colors.green,
                  icon: const Icon(Icons.check),
                  label: const Text('Done'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class TracingPainter extends CustomPainter {
  final List<Offset?> points;

  TracingPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(TracingPainter oldDelegate) => true;
}
