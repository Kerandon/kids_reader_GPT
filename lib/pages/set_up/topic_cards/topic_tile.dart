import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kids_reader_gpt/enums/story_stage.dart';
import 'package:kids_reader_gpt/state_management/state_manager.dart';
import '../../../configs/constants.dart';

class TopicTile extends ConsumerWidget {
  const TopicTile(
    this.item, {
    super.key,
  });

  final String item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final state = ref.watch(appProvider);
    final notifier = ref.read(appProvider.notifier);
    bool isSelected = false;
    if(state.storyStage == StoryStage.topics) {
      if (state.storySelection.topics.contains(item)) {
        isSelected = true;
      }
    }else if(state.storyStage == StoryStage.characters){
      if(state.storySelection.characters.contains(item)){
        isSelected = true;
      }
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
                color: isSelected ? Colors.amber : Colors.grey,
                borderRadius: BorderRadius.circular(kBorderRadius),
                border: Border.all(
                    width: 10, color: isSelected ? Colors.green : Colors.grey)),
            child: Column(
              children: [
                Expanded(
                    flex: 3,
                    child: Image.asset('assets/images/topics/mermaid.jpg')),
                Expanded(
                  flex: 1,
                  child: Text(item),
                )
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(kBorderRadius),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: isSelected
                    ? () {
                        if (state.storyStage == StoryStage.topics) {
                          notifier.setStorySelection(
                            state.storySelection.copyWith(
                              topics:
                                  List<String>.from(state.storySelection.topics)
                                    ..remove(item),
                            ),
                          );
                        } else if (state.storyStage == StoryStage.characters) {
                          notifier.setStorySelection(
                            state.storySelection.copyWith(
                              characters: List<String>.from(
                                  state.storySelection.characters)
                                ..remove(item),
                            ),
                          );
                        }
                      }
                    : () {
                        if (state.storyStage == StoryStage.topics) {
                          notifier.setStorySelection(
                            state.storySelection.copyWith(
                              topics: [...state.storySelection.topics, item],
                            ),
                          );
                        }else if(state.storyStage == StoryStage.characters){
                          notifier.setStorySelection(
                            state.storySelection.copyWith(
                              characters: [...state.storySelection.characters, item],
                            ),
                          );
                        }
                      },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
