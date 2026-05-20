import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final phonicsServiceProvider = Provider((ref) => PhonicsService());

class PhonicsService {
  final FlutterTts _flutterTts = FlutterTts();

  PhonicsService() {
    _initTts();
  }

  Future<void> _initTts() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.4); // Slower for kids to understand
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.2); // Slightly higher pitch for a friendlier "kid" tone
  }

  Future<void> playItem(dynamic item) async {
    try {
      String textToSpeak;
      if (item is String) {
        textToSpeak = item;
      } else {
        // Handle Shape object or others
        try {
          textToSpeak = (item as dynamic).name.toString();
        } catch (_) {
          textToSpeak = item.toString();
        }
      }
      
      await _flutterTts.speak(textToSpeak);
    } catch (e) {
      debugPrint('Error with TTS for $item: $e');
    }
  }

  void dispose() {
    _flutterTts.stop();
  }
}
