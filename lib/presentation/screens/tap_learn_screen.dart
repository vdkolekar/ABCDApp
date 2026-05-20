import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'activity_selection_screen.dart';
import '../../domain/models/alphabet_letter.dart';
import '../../domain/models/app_shape.dart';
import '../providers/phonics_provider.dart';
import '../widgets/shape_widget.dart';

class TapLearnScreen extends ConsumerStatefulWidget {
  final CategoryType category;

  const TapLearnScreen({super.key, required this.category});

  @override
  ConsumerState<TapLearnScreen> createState() => _TapLearnScreenState();
}

class _TapLearnScreenState extends ConsumerState<TapLearnScreen> {
  bool isUppercase = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tap & Learn: ${widget.category.name}'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: widget.category == CategoryType.letters
            ? [
                TextButton(
                  onPressed: () => setState(() => isUppercase = !isUppercase),
                  child: Text(
                    isUppercase ? 'LOWERCASE' : 'UPPERCASE',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ]
            : null,
      ),
      body: _buildGrid(),
    );
  }

  Widget _buildGrid() {
    switch (widget.category) {
      case CategoryType.letters:
        return _LetterGrid(isUppercase: isUppercase);
      case CategoryType.numbers:
        return _NumberGrid();
      case CategoryType.shapes:
        return _ShapeGrid();
    }
  }
}

class _LetterGrid extends ConsumerWidget {
  final bool isUppercase;
  const _LetterGrid({required this.isUppercase});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, crossAxisSpacing: 16, mainAxisSpacing: 16,
      ),
      itemCount: 26,
      itemBuilder: (context, index) {
        final letter = String.fromCharCode(65 + index);
        final displayLetter = isUppercase ? letter : letter.toLowerCase();
        return _TapCard(
          child: Text(displayLetter, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.orange)),
          onTap: () => ref.read(phonicsServiceProvider).playLetter(letter),
        );
      },
    );
  }
}

class _NumberGrid extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, crossAxisSpacing: 12, mainAxisSpacing: 12,
      ),
      itemCount: 20,
      itemBuilder: (context, index) {
        final number = (index + 1).toString();
        return _TapCard(
          child: Text(number, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.orange)),
          onTap: () => ref.read(phonicsServiceProvider).playLetter(number),
        );
      },
    );
  }
}

class _ShapeGrid extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16,
      ),
      itemCount: defaultShapes.length,
      itemBuilder: (context, index) {
        final shape = defaultShapes[index];
        return _TapCard(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShapeWidget(type: shape.type, color: shape.color, size: 60),
              const SizedBox(height: 8),
              Text(shape.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
            ],
          ),
          onTap: () => ref.read(phonicsServiceProvider).playLetter(shape.name),
        );
      },
    );
  }
}

class _TapCard extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const _TapCard({required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.orange, width: 2),
          boxShadow: [
            BoxShadow(color: Colors.grey.withAlpha(51), blurRadius: 4, offset: const Offset(0, 2)),
          ],
        ),
        child: Center(child: child),
      ),
    );
  }
}
