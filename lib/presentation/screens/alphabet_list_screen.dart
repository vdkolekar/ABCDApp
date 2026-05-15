import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/alphabet_letter.dart';
import '../providers/phonics_provider.dart';
import '../providers/progress_provider.dart';
import 'alphabet_tracing_screen.dart';

class AlphabetListScreen extends ConsumerWidget {
  const AlphabetListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn Alphabets'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: latinAlphabet.length,
        itemBuilder: (context, index) {
          final letter = latinAlphabet[index];
          final letterProgress = progress.any((p) => p.id == 'alphabet_${letter.toLowerCase()}');
          return _LetterCard(letter: letter, isCompleted: letterProgress);
        },
      ),
    );
  }
}

class _LetterCard extends ConsumerWidget {
  final String letter;
  final bool isCompleted;

  const _LetterCard({required this.letter, required this.isCompleted});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(phonicsServiceProvider).playLetter(letter);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlphabetTracingScreen(letter: letter),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(76), // ~0.3 opacity
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              border: Border.all(color: Colors.red, width: 2),
            ),
            child: Center(
              child: Text(
                letter,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          if (isCompleted)
            const Positioned(
              top: 8,
              right: 8,
              child: Icon(Icons.star, color: Colors.yellow, size: 32),
            ),
        ],
      ),
    );
  }
}

