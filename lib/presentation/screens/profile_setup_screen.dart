import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_provider.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome!',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 16),
              const Text(
                'What is your name?',
                style: TextStyle(fontSize: 24, color: Colors.blueGrey),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _controller,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 32),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                  hintText: 'Your Name',
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    ref.read(userProvider.notifier).createUser(_controller.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('Start Learning', style: TextStyle(fontSize: 24)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
