import 'package:flutter_tts/flutter_tts.dart';

class FlutterTTSService {



  Future<void> speak(String text) async{

    FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.40);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }


}