import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kids_reader_gpt/pages/selection/selection_page.dart';
import 'package:kids_reader_gpt/state_management/state_manager.dart';
import 'word.dart';

class StoryPage extends ConsumerStatefulWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  ConsumerState<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends ConsumerState<StoryPage> {
  bool _storySetUp = false;

  List<String> words = [];

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(appProvider);
    final notifier = ref.read(appProvider.notifier);

    if (!_storySetUp) {
      _storySetUp = true;
      words = state.story.toList();
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              notifier.reset();
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const SelectionPage()), (
                    route) => false);

              });

            }, icon: const Icon(Icons.arrow_back_outlined)),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Wrap(
            children: words.map((word) {
              return Word(
                word: word,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
