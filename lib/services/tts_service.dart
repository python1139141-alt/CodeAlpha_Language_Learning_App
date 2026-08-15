import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  TTSService._();

  static final TTSService instance = TTSService._();

  final FlutterTts _tts = FlutterTts();

  bool _initialized = false;
  double _speed = 1.0;

  static const Map<String, String> _languageCodes = {
    'Spanish': 'es-ES',
    'French': 'fr-FR',
    'German': 'de-DE',
    'English': 'en-US',
    'Urdu': 'ur-PK',
    'Hindi': 'hi-IN',
    'Arabic': 'ar-SA',
  };

  String languageCodeFor(String language) {
    return _languageCodes[language] ??
        _languageCodes.entries
            .firstWhere(
              (entry) => entry.key.toLowerCase() == language.toLowerCase(),
              orElse: () => const MapEntry('English', 'en-US'),
            )
            .value;
  }

  Future<void> initTTS({double speed = 1.0}) async {
    try {
      _speed = speed;
      await _tts.setSpeechRate(speed);
      await _tts.setVolume(1.0);
      await _tts.setPitch(1.0);
      _initialized = true;
    } catch (_) {
      _initialized = false;
    }
  }

  Future<void> setSpeed(double speed) async {
    _speed = speed;
    try {
      await initTTS(speed: speed);
    } catch (_) {}
  }

  Future<void> speak(String text, String languageCode, {double? speed}) async {
    try {
      if (!_initialized) {
        await initTTS(speed: speed ?? _speed);
      } else if (speed != null && speed != _speed) {
        _speed = speed;
        await _tts.setSpeechRate(speed);
      }
      _initialized = true;
      await _tts.awaitSpeakCompletion(true);
      await _tts.setLanguage(languageCode);
      await _tts.speak(text);
    } catch (_) {
      // TTS may be unavailable on some platforms (e.g. desktop); fail silently.
    }
  }
}