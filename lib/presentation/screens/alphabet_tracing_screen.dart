import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/reward_dialog.dart';
import '../providers/progress_provider.dart';

class AlphabetTracingScreen extends ConsumerStatefulWidget {
  final String letter;

  const AlphabetTracingScreen({super.key, required this.letter});

  @override
  ConsumerState<AlphabetTracingScreen> createState() => _AlphabetTracingScreenState();
}

class _AlphabetTracingScreenState extends ConsumerState<AlphabetTracingScreen> {
  List<Offset?> points = [];

  void _onDone() {
    const stars = 3;
    ref.read(progressProvider.notifier).saveProgress(
      id: 'alphabet_${widget.letter.toLowerCase()}',
      category: 'alphabet',
      stars: stars,
    );

    showDialog(
      context: context,
      builder: (context) => const RewardDialog(stars: 3),
    ).then((_) {
      if (mounted) Navigator.pop(context);
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
      body: Stack(
        children: [
          // Letter Template
          Center(
            child: Text(
              widget.letter,
              style: TextStyle(
                fontSize: 300,
                fontWeight: FontWeight.bold,
                color: Colors.grey.withAlpha(51), // ~0.2 opacity
              ),
            ),
          ),
          // Tracing Layer
          GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                RenderBox renderBox = context.findRenderObject() as RenderBox;
                points.add(renderBox.globalToLocal(details.globalPosition));
              });
            },
            onPanEnd: (details) {
              points.add(null);
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
