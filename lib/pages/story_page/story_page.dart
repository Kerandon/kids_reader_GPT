import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kids_reader_gpt/pages/home_page/home_page.dart';
import 'package:kids_reader_gpt/state_management/state_manager.dart';
import 'word.dart';
import '../../data/stories.dart';

class StoryPage extends ConsumerStatefulWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  ConsumerState<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends ConsumerState<StoryPage> {
  bool _storySetUp = false;

  List<String> words = stories[0].split(" ");

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appProvider);

    if (!_storySetUp) {
      _storySetUp = true;
      words = appState.story.toList();
    }

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
            (context) => const HomePage()), (route) => false);
          },
              icon: const Icon(Icons.arrow_back_outlined)),
        ),
        body: Center(
          child: Wrap(
            children: words.map((word) {
              return Word(
                word: word,
              );
            }).toList(),
          ),
        ));
  }
}
