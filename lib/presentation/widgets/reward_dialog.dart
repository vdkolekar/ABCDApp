import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RewardDialog extends StatelessWidget {
  final int stars;

  const RewardDialog({super.key, required this.stars});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Great Job!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            // Placeholder for Lottie animation
            SizedBox(
              height: 200,
              width: 200,
              child: Lottie.asset(
                'assets/animations/celebration.json',
                repeat: false,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.star, size: 100, color: Colors.yellow);
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Icon(
                  index < stars ? Icons.star : Icons.star_border,
                  size: 48,
                  color: Colors.yellow,
                );
              }),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              ),
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
