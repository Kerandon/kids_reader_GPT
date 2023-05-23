import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kids_reader_gpt/configs/constants.dart';
import 'package:kids_reader_gpt/pages/home_page/topic_cards/topic_card_contents.dart';
import 'package:kids_reader_gpt/state_management/state_manager.dart';


class TopicCardMain extends ConsumerWidget {
  const TopicCardMain({
    super.key, required this.topic,
  });

  final String topic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final size = MediaQuery.of(context).size;
    final state = ref.watch(appProvider);
    final notifier = ref.read(appProvider.notifier);
    bool placed = false;
    if(state.placedTopics.entries.any((element) => element.value == topic)) {
     placed = true;
    }
    return Padding(
      padding: EdgeInsets.all(size.width * 0.003),
      child: SizedBox(
        width: size.width * kTopicWidth,
        height: size.height * kTopicHeight,
        child: placed ? SizedBox() : Center(
          child: state.topicDragged != topic ? Draggable<String>(
            data: topic,
            onDragStarted: (){
              notifier.setTopicDragged(topic:
              topic
              );
            },
            feedback: TopicCardContents(topic: topic, addShadow: true,),
            child: TopicCardContents(topic: topic),
          ) : SizedBox(

          )
        ),
      ),
    );
  }
}
