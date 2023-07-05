import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kids_reader_gpt/data/topics.dart';
import 'package:kids_reader_gpt/enums/story_stage.dart';
import 'package:kids_reader_gpt/pages/set_up/selection_page.dart';
import 'package:kids_reader_gpt/state_management/state_manager.dart';

import '../../enums/themes.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List<String> _items = [];
  int crossAxisCount = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(appProvider);
    final notifier = ref.read(appProvider.notifier);

    if (state.storyStage == StoryStage.topics) {
      _items = topics.map((e) => e.topic).toSet().toList();
      crossAxisCount = 2;
    }else if(state.storyStage == StoryStage.characters){
      crossAxisCount = 2;
      List<String> characters = [];
      for(var t in topics){
        print('t is ${t.topic}');
        if(state.storySelection.topics.contains(t.topic)){
          characters.add(t.character);
        }
      }
     _items = characters.toList();
    }else if(state.storyStage == StoryStage.theme){
      crossAxisCount = 2;
     _items = Themes.values.map((e) => e.name).toList();
    }

    return SelectionPage(_items, crossAxisCount: crossAxisCount,);
  }
}
