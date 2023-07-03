import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kids_reader_gpt/configs/constants.dart';
import 'package:kids_reader_gpt/models/topic_model.dart';
import 'package:kids_reader_gpt/pages/home_page/topic_cards/topic_card_contents.dart';
import 'package:kids_reader_gpt/state_management/state_manager.dart';
import 'package:kids_reader_gpt/utils/get_position.dart';

class TopicCardMain extends ConsumerStatefulWidget {
  const TopicCardMain({
    super.key,
    required this.topic,
  });

  final TopicModel topic;

  @override
  ConsumerState<TopicCardMain> createState() => _TopicCardMainState();
}

class _TopicCardMainState extends ConsumerState<TopicCardMain> {
  final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final state = ref.watch(appProvider);
    final notifier = ref.read(appProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final startOffset = _key.getWidgetRect();

      final topic = state.topicModels
          .firstWhere((element) => element.name == widget.topic.name);

      notifier.updateTopic(
          topic.copyWith(originalOffset: startOffset?.topLeft ?? Offset.zero));
    });

    bool isPlaced = false;
    for (var m in state.topicModels) {
      if (m.name == widget.topic.name) {
        if (m.placedPosition != null) {
          isPlaced = true;
        }
      }
    }

    return Container(
      color: Colors.deepOrange,
      key: _key,
      width: size.width * kTopicWidth,
      height: size.height * kTopicHeight,
      child: widget.topic.isDragged == true || isPlaced
          ? const SizedBox()
          : Draggable<TopicModel>(
              data: widget.topic,
              onDragStarted: () {
                notifier.updateTopic(widget.topic.copyWith(isDragged: true));
              },
              onDraggableCanceled: (velocity, offset) {
                notifier.updateTopic(widget.topic.copyWith(
                    isDragged: false,
                    droppedOffset: offset,
                    droppedVelocity: velocity));
              },
              feedback: TopicContents(
                topic: widget.topic,
                addShadow: true,
              ),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: TopicContents(topic: widget.topic)),
            ),
    );
  }
}
