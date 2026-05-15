import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../domain/models/learning_progress.dart';

final progressProvider = StateNotifierProvider<ProgressNotifier, List<LearningProgress>>((ref) {
  return ProgressNotifier();
});

class ProgressNotifier extends StateNotifier<List<LearningProgress>> {
  ProgressNotifier() : super([]) {
    _loadProgress();
  }

  void _loadProgress() {
    final box = Hive.box<LearningProgress>('progressBox');
    state = box.values.toList();
  }

  Future<void> saveProgress({
    required String id,
    required String category,
    required int stars,
  }) async {
    final box = Hive.box<LearningProgress>('progressBox');
    final progress = LearningProgress(
      id: id,
      category: category,
      starsEarned: stars,
      isUnlocked: true,
      lastPracticed: DateTime.now(),
    );
    
    // Use id as key for easy updates
    await box.put(id, progress);
    _loadProgress();
  }
}
