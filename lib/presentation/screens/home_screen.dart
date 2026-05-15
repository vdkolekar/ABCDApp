import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'alphabet_list_screen.dart';
import 'shapes_matching_screen.dart';
import 'profile_setup_screen.dart';
import 'settings_screen.dart';
import '../providers/user_provider.dart';
import '../widgets/parental_gate.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    if (user == null) {
      return const ProfileSetupScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Hi, ${user.name}!'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              ParentalGate.show(
                context,
                onPassed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsScreen()),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              const Text(
                'ABCD App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const Spacer(),
              // Alphabets Button
              _MenuButton(
                label: 'Alphabets',
                color: Colors.red,
                icon: Icons.abc,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AlphabetListScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              // Shapes Button
              _MenuButton(
                label: 'Shapes',
                color: Colors.green,
                icon: Icons.category,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ShapesMatchingScreen(),
                    ),
                  );
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  const _MenuButton({
    required this.label,
    required this.color,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40),
          const SizedBox(width: 16),
          Text(
            label,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
