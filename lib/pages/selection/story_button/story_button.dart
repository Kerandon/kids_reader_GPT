import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kids_reader_gpt/configs/constants.dart';
import 'package:kids_reader_gpt/state_management/state_manager.dart';
import 'package:kids_reader_gpt/utils/string_extensions.dart';
import '../../../animations/bounce_animation.dart';
import '../../../components/builder_helper.dart';
import '../../../enums/story_stage.dart';
import '../../story_page/story_page.dart';

class StoryButton extends ConsumerStatefulWidget {
  const StoryButton({
    super.key,
  });

  @override
  ConsumerState<StoryButton> createState() => _StoryButtonState();
}

class _StoryButtonState extends ConsumerState<StoryButton> {
  late final OpenAI _openAI;

  @override
  void initState() {
    _openAI = OpenAI.instance.build(
        token: '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',
        baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 15)),
        enableLog: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(appProvider);
    final notifier = ref.read(appProvider.notifier);

    bool enable = false;
    if (state.storyStage == StoryStage.topics) {
      if (state.storySelection.topic.isNotEmpty) {
        enable = true;
      }
    } else if (state.storyStage == StoryStage.character) {
      if (state.storySelection.characters.isNotEmpty) {
        enable = true;
      }
    } else if (state.storyStage == StoryStage.theme) {
      if (state.storySelection.theme.isNotEmpty) {
        enable = true;
      }
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final biggest = constraints.biggest;
        return Bounce(
          animate: enable,
          child: Align(
            alignment: const Alignment(0, -0.80),
            child: SizedBox(
                width: biggest.width * 0.60,
                height: biggest.height * 0.60,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(kBorderRadius))),
                    onPressed: enable
                        ? () async {
                            if (state.storyStage == StoryStage.topics) {
                              notifier.setStoryStage(StoryStage.character);
                            } else if (state.storyStage ==
                                StoryStage.character) {
                              notifier.setStoryStage(StoryStage.theme);
                            } else if (state.storyStage == StoryStage.theme) {
                              List<String> characters =
                                  state.storySelection.characters.toList();
                              List<String> themes =
                                  state.storySelection.theme.toList();

                              final content =
                                  "Can you make a story that involves these character(s): $characters. "
                                  "The theme(s) of the story should be: $themes. "
                                  "Please make the story short and aimed for a 6 year old reader";

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoadingHelper(
                                    future: createStory(
                                        openAI: _openAI,
                                        appState: state,
                                        content: content),
                                    onComplete: (payload) {
                                      final result = payload as ChatCTResponse;

                                      final text =
                                          result.choices.last.message!.content;

                                      print('text ${result.choices.last.message!.content}');

                                      notifier.setStory(
                                          story: text.splitByWords());

                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const StoryPage()));
                                    },
                                  ),
                                ),
                              );
                            }
                          }
                        : null,
                    child: Text(
                      state.storyStage == StoryStage.theme
                          ? kMakeAStory
                          : kNext,
                      style: Theme.of(context).textTheme.displaySmall,
                    ))),
          ),
        );
      },
    );
  }

  Future<ChatCTResponse?> createStory(
      {required OpenAI openAI,
      required AppState appState,
      required String content}) async {
    final request = ChatCompleteText(messages: [
      Map.of({
        "role": "user",
        "content": content,
      })
    ], maxToken: 200, model: ChatModel.gptTurbo);

    final response = await openAI.onChatCompletion(request: request);
    return response;
  }
}
