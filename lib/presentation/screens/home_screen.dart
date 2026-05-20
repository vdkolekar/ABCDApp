import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'activity_selection_screen.dart';
import 'settings_screen.dart';
import 'about_screen.dart';
import '../providers/user_provider.dart';
import '../widgets/parental_gate.dart';

enum LearningMode { tap, drop, trace }

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(user != null ? 'Hi, ${user.name}!' : 'Learning App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
          ),
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Learning App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 24),
              _SectionCard(
                title: 'Tap & Learn',
                subtitle: 'Tap to hear sounds',
                color: Colors.orange,
                lottieAsset: 'assets/animations/tap.json',
                fallbackIcon: Icons.ads_click,
                onTap: () => _navigateToActivity(context, LearningMode.tap),
              ),
              const SizedBox(height: 16),
              _SectionCard(
                title: 'Drop & Learn',
                subtitle: 'Drag and match objects',
                color: Colors.green,
                lottieAsset: 'assets/animations/drop.json',
                fallbackIcon: Icons.front_hand,
                onTap: () => _navigateToActivity(context, LearningMode.drop),
              ),
              const SizedBox(height: 16),
              _SectionCard(
                title: 'Trace & Learn',
                subtitle: 'Trace letters and numbers',
                color: Colors.red,
                lottieAsset: 'assets/animations/trace.json',
                fallbackIcon: Icons.gesture,
                onTap: () => _navigateToActivity(context, LearningMode.trace),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToActivity(BuildContext context, LearningMode mode) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ActivitySelectionScreen(mode: mode),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final String lottieAsset;
  final IconData fallbackIcon;
  final VoidCallback onTap;

  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.lottieAsset,
    required this.fallbackIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(32),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: color.withAlpha(76),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withAlpha(204),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Lottie.asset(
                lottieAsset,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(fallbackIcon, size: 60, color: Colors.white);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
