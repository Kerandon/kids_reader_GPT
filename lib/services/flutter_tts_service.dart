import 'package:flutter_tts/flutter_tts.dart';

class FlutterTTSService {



  Future speak(String text) async{
    print('speak $text');
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.40);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    var result = await flutterTts.speak(text);
    print(result);
  }


}