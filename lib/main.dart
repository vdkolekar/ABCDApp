import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'domain/models/learning_progress.dart';
import 'domain/models/user_profile.dart';
import 'presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register Adapters
  Hive.registerAdapter(LearningProgressAdapter());
  Hive.registerAdapter(UserProfileAdapter());
  
  // Open Boxes
  await Hive.openBox<LearningProgress>('progressBox');
  await Hive.openBox<UserProfile>('profilesBox');
  await Hive.openBox('settingsBox');

  runApp(
    const ProviderScope(
      child: ABCDApp(),
    ),
  );
}

class ABCDApp extends StatelessWidget {
  const ABCDApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ABCD App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        // UI/UX Style Guide: Primary color palette
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue,
          secondary: Colors.yellow,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
