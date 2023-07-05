import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kids_reader_gpt/enums/story_stage.dart';
import 'package:kids_reader_gpt/pages/set_up/topic_cards/topic_tile.dart';
import '../../state_management/state_manager.dart';
import 'story_button/story_button.dart';

class SelectionPage extends ConsumerStatefulWidget {
  const SelectionPage(this.items, {this.crossAxisCount = 1, Key? key})
      : super(key: key);

  final List<String> items;
  final int crossAxisCount;

  @override
  ConsumerState<SelectionPage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<SelectionPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final state = ref.watch(appProvider);
    final notifier = ref.read(appProvider.notifier);

    String title = "";
    if (state.storyStage == StoryStage.topics) {
      title = "Choose Your Topic";
    } else if (state.storyStage == StoryStage.characters) {
      title = "Choose Your Characters";
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: state.storyStage != StoryStage.topics ? IconButton(icon: Icon(Icons.arrow_back_outlined), onPressed: (){

            if (state.storyStage == StoryStage.characters) {
                notifier.setStoryStage(StoryStage.topics);
            }else if(state.storyStage == StoryStage.theme){
              notifier.setStoryStage(StoryStage.characters);
            }

          },) : null,
          title: Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 8,
              child: GridView.builder(
                itemCount: widget.items.length,
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.crossAxisCount),
                itemBuilder: (context, index) => TopicTile(widget.items[index]),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(size.height * 0.01),
                child: const StoryButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
