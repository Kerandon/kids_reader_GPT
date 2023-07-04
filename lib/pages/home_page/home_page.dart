import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kids_reader_gpt/animations/spring_animation.dart';
import 'package:kids_reader_gpt/models/topic_model.dart';
import 'package:kids_reader_gpt/pages/home_page/topic_cards/topic_card_contents.dart';
import 'package:kids_reader_gpt/pages/home_page/topic_cards/topic_landing_tile.dart';
import 'package:kids_reader_gpt/state_management/state_manager.dart';

import 'story_button/story_button.dart';
import 'topic_cards/topic_card_main.dart';
import '../../data/topics.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool _setUpTopicModels = false;
  bool _animate = false, _reset = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final state = ref.watch(appProvider);
    final notifier = ref.read(appProvider.notifier);
    if (!_setUpTopicModels) {
      _setUpTopicModels = true;
      List<TopicModel> topicsList = [];
      for (var t in topics) {
        topicsList.add(TopicModel(t));
      }
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        notifier.setTopics(topics: topicsList);
      });
    }
    final safePadding = MediaQuery.of(context).padding.top;

    Offset droppedOffset = Offset.zero;
    Offset originalOffset = Offset.zero;

    TopicModel? topic;
    for (var m in state.topicModels) {
      if (m.droppedOffset != Offset.zero) {
        topic = m;
        _animate = true;
        print(m.droppedOffset);
      }
    }

    if (state.topicModels.isNotEmpty && topic != null) {
      droppedOffset =
          Offset(topic.droppedOffset.dx, topic.droppedOffset.dy - safePadding);
      originalOffset = Offset(
          topic.originalOffset.dx, topic.originalOffset.dy - safePadding);
    }

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.black38,
                    child: Center(
                      child: ListView.builder(
                        itemCount: state.topicModels.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            TopicCardMain(topic: state.topicModels[index]),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                      color: Colors.green,
                      height: size.height * 0.30,
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                          (index) {
                            if (index % 2 == 0) {
                              return TopicLandingTile(
                                  index); // Original child container
                            } else {
                              return const Icon(Icons.add); // Plus icon
                            }
                          },
                        )
                            .expand(
                              (widget) => [
                                widget,
                                const SizedBox(width: 10),
                                // Adjust the spacing between containers and plus icons
                              ],
                            )
                            .toList(),
                      )),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(size.height * 0.01),
                    child: const StoryButton(),
                  ),
                ),
              ],
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    _reset = false;
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      _animate = true;
                    });
                    notifier.updateTopic(
                        topic!.copyWith(droppedOffset: Offset.zero));
                    setState(() {});
                  },
                  child: const Text('check status')),
            ),
            _animate
                ? SpringAnimation(
                    animate: _animate,
                    reset: _reset,
                    startOffset: droppedOffset,
                    endOffset: originalOffset,
                    onComplete: () {
                      _animate = false;
                      _reset = true;
                      setState(() {});

                      if (topic != null) {
                        notifier.updateTopic(
                            topic.copyWith(droppedOffset: Offset.zero));
                      }
                    },
                    child: TopicContents(
                      topic: state.topicModels.first,
                    ))
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
