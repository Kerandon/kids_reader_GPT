
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:kids_reader_gpt/services/flutter_tts_service.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Word extends StatefulWidget {
  const Word({
    super.key, required this.word,
  });

  final String word;

  @override
  State<Word> createState() => _WordState();
}

class _WordState extends State<Word> {




  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
FlutterTTSService().speak(widget.word);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.green,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(widget.word,
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }

}

