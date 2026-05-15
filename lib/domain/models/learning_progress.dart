import 'package:hive/hive.dart';

part 'learning_progress.g.dart';

@HiveType(typeId: 0)
class LearningProgress extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String category; // 'alphabet' or 'shape'

  @HiveField(2)
  final int starsEarned;

  @HiveField(3)
  final bool isUnlocked;

  @HiveField(4)
  final DateTime lastPracticed;

  LearningProgress({
    required this.id,
    required this.category,
    this.starsEarned = 0,
    this.isUnlocked = false,
    required this.lastPracticed,
  });

  LearningProgress copyWith({
    String? id,
    String? category,
    int? starsEarned,
    bool? isUnlocked,
    DateTime? lastPracticed,
  }) {
    return LearningProgress(
      id: id ?? this.id,
      category: category ?? this.category,
      starsEarned: starsEarned ?? this.starsEarned,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      lastPracticed: lastPracticed ?? this.lastPracticed,
    );
  }
}
