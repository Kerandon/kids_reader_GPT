import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kids_reader_gpt/enums/story_stage.dart';
import 'package:kids_reader_gpt/state_management/state_manager.dart';
import 'package:kids_reader_gpt/utils/showPopup.dart';
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
    if (state.storyStage == StoryStage.topics) {
      if (state.storySelection.topic.contains(item)) {
        isSelected = true;
      }
    } else if (state.storyStage == StoryStage.character) {
      if (state.storySelection.characters.contains(item)) {
        isSelected = true;
      }
    } else if (state.storyStage == StoryStage.theme) {
      if (state.storySelection.theme.contains(item)) {
        isSelected = true;
      }
    }
    return LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding: EdgeInsets.all(constraints.biggest.width * 0.02),
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  width: size.width,
                  height: size.width,
                  decoration: BoxDecoration(
                      color: isSelected ? Colors.amber : Colors.grey,
                      borderRadius: BorderRadius.circular(kBorderRadius),
                      border: Border.all(
                          width: constraints.maxWidth * 0.05,
                          color: isSelected ? Colors.green : Colors.grey)),
                  child: Column(
                    children: [
                      Expanded(
                          flex: 3,
                          child:
                              Image.asset('assets/images/topics/mermaid.jpg')),
                      Expanded(
                        flex: 1,
                        child: Text(item, style: Theme.of(context).textTheme.displaySmall,),
                      )
                    ],
                  ),
                );
              },
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(kBorderRadius),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    if (isSelected) {
                      if (state.storyStage == StoryStage.topics) {
                        notifier.setStorySelection(
                          state.storySelection.copyWith(
                            topics:
                                List<String>.from(state.storySelection.topic)
                                  ..remove(item),
                          ),
                        );
                      } else if (state.storyStage == StoryStage.character) {
                        notifier.setStorySelection(
                          state.storySelection.copyWith(
                            characters: List<String>.from(
                                state.storySelection.characters)
                              ..remove(item),
                          ),
                        );
                      } else if (state.storyStage == StoryStage.theme) {
                        notifier.setStorySelection(
                          state.storySelection.copyWith(
                            theme: List<String>.from(state.storySelection.theme)
                              ..remove(item),
                          ),
                        );
                      }
                    } else {
                      if (state.storyStage == StoryStage.topics &&
                          state.storySelection.topic.length == 2) {
                        showPopup(context, kOhNo,
                            subtitle: kCantMoreThan2Topics);
                      } else if (state.storyStage == StoryStage.character &&
                          state.storySelection.characters.length == 2) {
                        showPopup(context, kOhNo,
                            subtitle: kCantMoreThan2Characters);
                      } else if (state.storyStage == StoryStage.theme &&
                          state.storySelection.theme.length == 1) {
                        showPopup(context, kOhNo,
                            subtitle: kCantMoreThan1Theme);
                      } else {
                        if (state.storyStage == StoryStage.topics) {
                          notifier.setStorySelection(
                            state.storySelection.copyWith(
                              topics: [...state.storySelection.topic, item],
                            ),
                          );
                        } else if (state.storyStage == StoryStage.character) {
                          notifier.setStorySelection(
                            state.storySelection.copyWith(
                              characters: [
                                ...state.storySelection.characters,
                                item
                              ],
                            ),
                          );
                        } else if (state.storyStage == StoryStage.theme) {
                          notifier.setStorySelection(
                            state.storySelection.copyWith(
                              theme: [...state.storySelection.theme, item],
                            ),
                          );
                        }
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
