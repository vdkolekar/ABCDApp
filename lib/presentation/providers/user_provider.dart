import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/user_profile.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserProfile?>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<UserProfile?> {
  UserNotifier() : super(null) {
    _loadProfile();
  }

  void _loadProfile() {
    final box = Hive.box<UserProfile>('profilesBox');
    if (box.isNotEmpty) {
      state = box.values.first;
    }
  }

  Future<void> createUser(String name) async {
    final box = Hive.box<UserProfile>('profilesBox');
    final newUser = UserProfile(
      id: const Uuid().v4(),
      name: name,
      createdAt: DateTime.now(),
    );
    await box.add(newUser);
    state = newUser;
  }

  Future<void> clearProgress() async {
    final progressBox = Hive.box('progressBox');
    await progressBox.clear();
  }
}
