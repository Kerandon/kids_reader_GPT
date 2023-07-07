import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kids_reader_gpt/data/topics.dart';
import 'package:kids_reader_gpt/enums/story_stage.dart';
import 'package:kids_reader_gpt/pages/selection/selection_progress_bar/selection_progress_bar.dart';
import 'package:kids_reader_gpt/pages/selection/story_button/story_button.dart';
import 'package:kids_reader_gpt/pages/selection/topic_cards/topic_tile.dart';
import 'package:kids_reader_gpt/state_management/state_manager.dart';
import '../../configs/constants.dart';
import '../../enums/themes.dart';

class SelectionPage extends ConsumerStatefulWidget {
  const SelectionPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends ConsumerState<SelectionPage> {
  List<String> _items = [];
  int crossAxisCount = 1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final state = ref.watch(appProvider);
    final notifier = ref.read(appProvider.notifier);
    String title = "";
    List<String> currentSelectionToDisplay = [];

    ///TOPICS
    if (state.storyStage == StoryStage.topics) {
      title = "Choose Your Topic!";
      _items = topics.map((e) => e.topic).toSet().toList();
      crossAxisCount = 1;

      currentSelectionToDisplay = updateCurrentSelectedToDisplay(
              currentSelectionToDisplay, state.storySelection.topic)
          .toList();

      ///CHARACTERS
    } else if (state.storyStage == StoryStage.character) {
      title = "Choose Your Characters!";
      crossAxisCount = 1;
      List<String> characters = [];
      for (var t in topics) {
        if (state.storySelection.topic.contains(t.topic)) {
          characters.add(t.character);
        }
      }
      _items = characters.toList();
      currentSelectionToDisplay = updateCurrentSelectedToDisplay(
              currentSelectionToDisplay, state.storySelection.characters)
          .toList();

      ///THEME
    } else if (state.storyStage == StoryStage.theme) {
      title = "Choose Your Story Theme!";
      crossAxisCount = 1;
      _items = Themes.values.map((e) => e.name).toList();
      currentSelectionToDisplay = updateCurrentSelectedToDisplay(
              currentSelectionToDisplay, state.storySelection.theme)
          .toList();
    }

    print('current selection is ${currentSelectionToDisplay.length}');

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: size.height * kCustomToolbarHeight,
          leading: state.storyStage != StoryStage.topics
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_outlined, size: 50,
                  color: Colors.blue,
                  ),
                  onPressed: () {
                    if (state.storyStage == StoryStage.character) {
                      notifier.setStoryStage(StoryStage.topics);
                    } else if (state.storyStage == StoryStage.theme) {
                      notifier.setStoryStage(StoryStage.character);
                    }
                  },
                )
              : null,
          title: Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          centerTitle: true,
          actions: currentSelectionToDisplay
              .map(
                (topic) => LayoutBuilder(
                  builder: (context, constraints) {
                    final biggest = constraints.biggest;
                   final heightPadding = biggest.height * 0.10;
                    return Padding(
                      padding: EdgeInsets.fromLTRB(1, heightPadding, 1, heightPadding),
                      child: SizedBox(
                        width: size.width * 0.08,
                        child: Center(
                          child: TopicTile(topic),
                        ),
                      ),
                    );
                  },
                ),
              )
              .toList(),
        ),
        body: Column(
          children: [
            const Expanded(
              flex: 5,
              child: SelectionProgressBar(),
            ),
            Expanded(
              flex: 20,
              child: LayoutBuilder(
                builder: (context, constraints) => Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: constraints.maxHeight * 0.12),
                  child: GridView.builder(
                    itemCount: _items.length,
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount),
                    itemBuilder: (context, index) => TopicTile(_items[index]),
                  ),
                ),
              ),
            ),
            const Expanded(
              flex: 8,
              child: StoryButton(),
            ),
          ],
        ),
      ),
    );
  }

  List<String> updateCurrentSelectedToDisplay(
      List<String> currentList, List<String> allItems) {
    for (String item in allItems) {
      if (!currentList.contains(item)) {
        currentList.insert(0, item);
      }
    }

    return currentList;
  }
}
