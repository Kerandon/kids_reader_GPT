
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kids_reader_gpt/configs/constants.dart';
import 'package:kids_reader_gpt/pages/home_page/topic_cards/topic_card_contents.dart';

import '../../../state_management/state_manager.dart';

class TopicLandingTile extends ConsumerWidget {
  const TopicLandingTile(this.index, {
    super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('index $index');
    final size = MediaQuery.of(context).size;
    final state = ref.watch(appProvider);
    final notifier = ref.read(appProvider.notifier);

    String? placedTopic;
    if(state.placedTopics.entries.any((element) => element.key == index)) {
      placedTopic = state.placedTopics.entries
          .firstWhere(
              (element) => element.key == index).value;
    }


    return DragTarget<String>(
      onWillAccept: (details){
        if(placedTopic == null) {
          return true;
        }else{
          return false;
        }
      },
      onAccept: (details){
        notifier.addPlacedTopics(topics: {index : details});

      },
      builder: (
          BuildContext context,
          List<Object?> candidateData, List<dynamic> rejectedData) {
        if (placedTopic != null) {
          return TopicCardContents(topic: placedTopic);
        } else {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kBorderRadius),
                color: Colors.orange
            ),
            width: size.width * kTopicWidth,
            height: size.height * kTopicHeight,
          );
        }
      }

    );
  }
}
