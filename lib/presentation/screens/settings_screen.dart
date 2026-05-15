import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/progress_provider.dart';
import '../providers/user_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressList = ref.watch(progressProvider);
    final totalStars = progressList.fold<int>(0, (sum, p) => sum + p.starsEarned);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Parental Settings'),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          _buildSectionTitle('Progress Overview'),
          Card(
            child: ListTile(
              leading: const Icon(Icons.star, color: Colors.yellow, size: 40),
              title: const Text('Total Stars Earned', style: TextStyle(fontSize: 20)),
              trailing: Text(
                '$totalStars',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 32),
          _buildSectionTitle('Data Management'),
          Card(
            color: Colors.red[50],
            child: ListTile(
              leading: const Icon(Icons.delete_forever, color: Colors.red),
              title: const Text('Reset All Progress', style: TextStyle(color: Colors.red)),
              onTap: () {
                _confirmReset(context, ref);
              },
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'This app is privacy-first. All data is stored locally on this device and is never shared.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey),
      ),
    );
  }

  void _confirmReset(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Data?'),
        content: const Text('This will permanently delete all stars and progress. This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(userProvider.notifier).clearProgress();
              Navigator.pop(context);
              Navigator.pop(context); // Go back to Home
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text('Reset Everything'),
          ),
        ],
      ),
    );
  }
}
