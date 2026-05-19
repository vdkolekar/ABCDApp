import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/progress_provider.dart';
import 'alphabet_tracing_screen.dart';

class NumbersListScreen extends ConsumerWidget {
  const NumbersListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressProvider);
    final List<int> numbers = List.generate(20, (index) => index + 1);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn Numbers'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: numbers.length,
        itemBuilder: (context, index) {
          final number = numbers[index];
          final String numberStr = number.toString();
          final isCompleted = progress.any((p) => p.id == 'number_$numberStr');
          
          return _NumberCard(number: numberStr, isCompleted: isCompleted);
        },
      ),
    );
  }
}

class _NumberCard extends StatelessWidget {
  final String number;
  final bool isCompleted;

  const _NumberCard({required this.number, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlphabetTracingScreen(letter: number),
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
                  color: Colors.grey.withAlpha(76),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              border: Border.all(color: Colors.orange, width: 2),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ),
          ),
          if (isCompleted)
            const Positioned(
              top: 4,
              right: 4,
              child: Icon(Icons.star, color: Colors.yellow, size: 24),
            ),
        ],
      ),
    );
  }
}
