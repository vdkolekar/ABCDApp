import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'activity_selection_screen.dart';
import '../providers/progress_provider.dart';
import 'alphabet_tracing_screen.dart';

class TraceListScreen extends ConsumerStatefulWidget {
  final CategoryType category;

  const TraceListScreen({super.key, required this.category});

  @override
  ConsumerState<TraceListScreen> createState() => _TraceListScreenState();
}

class _TraceListScreenState extends ConsumerState<TraceListScreen> {
  bool isUppercase = true;

  @override
  Widget build(BuildContext context) {
    final progress = ref.watch(progressProvider);
    final items = widget.category == CategoryType.letters
        ? List.generate(26, (index) => String.fromCharCode(65 + index))
        : List.generate(20, (index) => (index + 1).toString());

    return Scaffold(
      appBar: AppBar(
        title: Text('Trace & Learn: ${widget.category.name}'),
        backgroundColor: Colors.red,
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
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.category == CategoryType.letters ? 3 : 4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final rawItem = items[index];
          final displayItem = widget.category == CategoryType.letters 
              ? (isUppercase ? rawItem.toUpperCase() : rawItem.toLowerCase())
              : rawItem;
          
          final id = widget.category == CategoryType.letters
              ? 'alphabet_${rawItem.toLowerCase()}'
              : 'number_$rawItem';
          
          final isCompleted = progress.any((p) => p.id == id);

          return _TraceCard(
            item: displayItem,
            isCompleted: isCompleted,
            color: Colors.red,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AlphabetTracingScreen(letter: displayItem),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _TraceCard extends StatelessWidget {
  final String item;
  final bool isCompleted;
  final Color color;
  final VoidCallback onTap;

  const _TraceCard({
    required this.item,
    required this.isCompleted,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color, width: 2),
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 4),
              ],
            ),
            child: Center(
              child: Text(
                item,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: color,
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
