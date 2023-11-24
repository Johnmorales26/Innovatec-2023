import 'package:flutter_tts/flutter_tts.dart';

FlutterTts flutterTts = FlutterTts();

void speechIndicator(String text) async {
  await flutterTts.speak(text);
}
