import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kids_reader_gpt/configs/constants.dart';
import 'package:kids_reader_gpt/pages/home_page/topic_cards/topic_card_contents.dart';

import '../../../models/topic_model.dart';
import '../../../state_management/state_manager.dart';

class TopicLandingTile extends ConsumerWidget {
  const TopicLandingTile(
    this.index, {
    super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final state = ref.watch(appProvider);
    final notifier = ref.read(appProvider.notifier);

    return DragTarget<TopicModel>(onWillAccept: (details) {
      return
        state.topicModels
          .every((element) => element.placedPosition != index);


    }, onAccept: (topic) {
      notifier.updateTopic(topic.copyWith(placedPosition: index));
    }, builder: (BuildContext context, List<Object?> candidateData,
        List<dynamic> rejectedData) {

      TopicModel? matchedTopic;

       for(var m in state.topicModels){
         if(m.placedPosition == index){
           matchedTopic = m;
         }
       }

       if(matchedTopic != null){
         return TopicContents(topic: matchedTopic);
       }



        return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kBorderRadius),
            color: Colors.orange),
        width: size.width * kTopicWidth,
        height: size.height * kTopicHeight,
      );
    });
  }
}
