import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About This App'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to a safe, calm, and purposeful learning space designed entirely for your child.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 24),
            _infoSection(
              title: '1. 100% Privacy-First',
              content: 'We do not collect, store, or share any personal data. No login is required, and all progress data stays safely on your local device.',
            ),
            _infoSection(
              title: '2. Zero Ads & Offline Play',
              content: 'This app is completely ad-free and works entirely offline, ensuring a secure environment free from external distractions.',
            ),
            _infoSection(
              title: '3. Visual Wellness',
              content: 'We intentionally avoided harsh, overstimulating, high-contrast neon colors. Our soft, sensory-friendly palette reduces eye strain and fosters a focused, calm learning atmosphere.',
            ),
            _infoSection(
              title: '4. Early Development',
              content: 'Designed to build essential fine motor and cognitive skills through gentle, intuitive alphabet tracing and shape matching.',
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'For technical inquiries, bug reports, or product feedback, contact our development team at 3dfier.in@gmail.com.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            const Text(
              'Thank you,\nTeam 3Dfier',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _infoSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
