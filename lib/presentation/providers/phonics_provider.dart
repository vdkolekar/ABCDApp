import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final phonicsServiceProvider = Provider((ref) => PhonicsService());

class PhonicsService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> playLetter(String letter) async {
    try {
      // Assuming audio files are named a.mp3, b.mp3, etc.
      await _player.play(AssetSource('audio/${letter.toLowerCase()}.mp3'));
    } catch (e) {
      // Handle error (e.g., file not found)
      debugPrint('Error playing audio: $e');
    }
  }

  void dispose() {
    _player.dispose();
  }
}
