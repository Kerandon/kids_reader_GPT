import 'dart:math';

import 'package:flutter/material.dart';

import 'word.dart';
import '../../data/stories.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {

  List<String> words = stories[0].split(" ");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Wrap(
          children:       words.map((word) {
            return Word(word: word,);
          }).toList(),
        ),
      )


    );
  }
}
