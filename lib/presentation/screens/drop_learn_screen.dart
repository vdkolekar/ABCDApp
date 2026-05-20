import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import 'activity_selection_screen.dart';
import '../../domain/models/app_shape.dart';
import '../widgets/shape_widget.dart';
import '../widgets/reward_dialog.dart';
import '../providers/phonics_provider.dart';

class DropLearnScreen extends ConsumerStatefulWidget {
  final CategoryType category;

  const DropLearnScreen({super.key, required this.category});

  @override
  ConsumerState<DropLearnScreen> createState() => _DropLearnScreenState();
}

class _DropLearnScreenState extends ConsumerState<DropLearnScreen> {
  late Object targetItem;
  late List<Object> options;
  bool isUppercase = true;
  bool isCorrect = false;

  @override
  void initState() {
    super.initState();
    _generateLevel();
  }

  void _generateLevel() {
    setState(() {
      isCorrect = false;
      final allItems = _getAllItems();
      targetItem = allItems[Random().nextInt(allItems.length)];
      
      final otherItems = allItems.where((item) => item != targetItem).toList();
      otherItems.shuffle();
      
      options = [targetItem, ...otherItems.take(3)];
      options.shuffle();
    });
  }

  List<Object> _getAllItems() {
    switch (widget.category) {
      case CategoryType.letters:
        return List.generate(26, (index) => String.fromCharCode(65 + index));
      case CategoryType.numbers:
        return List.generate(20, (index) => (index + 1).toString());
      case CategoryType.shapes:
        return List<Object>.from(defaultShapes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drop & Learn: ${widget.category.name}'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: widget.category == CategoryType.letters
            ? [
                TextButton(
                  onPressed: () => setState(() {
                    isUppercase = !isUppercase;
                    _generateLevel();
                  }),
                  child: Text(
                    isUppercase ? 'LOWERCASE' : 'UPPERCASE',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ]
            : null,
      ),
      body: Column(
        children: [
          // Upper Part: The Target
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              color: Colors.green.withAlpha(25),
              child: Center(
                child: DragTarget<Object>(
                  onWillAcceptWithDetails: (details) => details.data == targetItem,
                  onAcceptWithDetails: (details) {
                    setState(() => isCorrect = true);
                    ref.read(phonicsServiceProvider).playItem(targetItem);
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const RewardDialog(stars: 3),
                    ).then((_) {
                      if (mounted) _generateLevel();
                    });
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.green, width: 4, style: BorderStyle.solid),
                      ),
                      child: Center(
                        child: _buildItemDisplay(targetItem, isShadow: !isCorrect),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const Divider(height: 2, thickness: 2, color: Colors.green),
          // Bottom Part: The Options
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.2,
                ),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final item = options[index];
                  // Important: use a unique key for each item to ensure refresh
                  return Draggable<Object>(
                    key: ValueKey(item.hashCode),
                    data: item,
                    feedback: Material(
                      color: Colors.transparent,
                      child: _buildItemDisplay(item, size: 100),
                    ),
                    childWhenDragging: Opacity(
                      opacity: 0.3,
                      child: _buildItemDisplay(item),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 4),
                        ],
                      ),
                      child: Center(child: _buildItemDisplay(item)),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemDisplay(Object item, {bool isShadow = false, double size = 80}) {
    if (item is AppShape) {
      return ShapeWidget(type: item.type, color: item.color, size: size, isShadow: isShadow);
    }
    
    String text = item.toString();
    if (widget.category == CategoryType.letters) {
      text = isUppercase ? text.toUpperCase() : text.toLowerCase();
    }
    
    return Text(
      text,
      style: TextStyle(
        fontSize: size * 0.8,
        fontWeight: FontWeight.bold,
        color: isShadow ? Colors.grey.withAlpha(100) : Colors.green,
      ),
    );
  }
}
