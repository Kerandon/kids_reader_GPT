import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kids_reader_gpt/configs/constants.dart';
import 'package:kids_reader_gpt/state_management/state_manager.dart';
import '../../../animations/bounce_animation.dart';
import '../../../enums/story_stage.dart';

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
    final size = MediaQuery.of(context).size;
    final state = ref.watch(appProvider);
    final notifier = ref.read(appProvider.notifier);

    bool enable = false;
    if (state.storyStage == StoryStage.topics) {
      if (state.storySelection.topics.isNotEmpty) {
        enable = true;
      }
    }if(state.storyStage == StoryStage.characters){
      if(state.storySelection.characters.isNotEmpty){
        enable = true;
      }
    }

    return Bounce(
      animate: enable,
      child: SizedBox(
          width: size.width * 0.50,
          height: size.height * 0.12,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kBorderRadius))),
              onPressed: enable
                  ? () async {
                      if (state.storyStage == StoryStage.topics) {
                        notifier.setStoryStage(StoryStage.characters);
                      } else if (state.storyStage == StoryStage.characters) {
                        notifier.setStoryStage(StoryStage.theme);
                      }

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => LoadingHelper(
                      //       future:
                      //           chatComplete(openAI: _openAI, appState: state),
                      //       onComplete: (payload) {
                      //         final result = payload as ChatCTResponse;
                      //
                      //         final text = result.choices.last.message!.content;
                      //
                      //         notifier.setStory(story: text.split(" "));
                      //
                      //         Navigator.of(context).push(MaterialPageRoute(
                      //             builder: (context) => const StoryPage()));
                      //       },
                      //     ),
                      //   ),
                      // );
                    }
                  : null,
              child: Text(
                'Next!',
                style: Theme.of(context).textTheme.displayLarge,
              ))),
    );
  }

  Future<ChatCTResponse?> chatComplete(
      {required OpenAI openAI, required AppState appState}) async {
    final request = ChatCompleteText(messages: [
      Map.of({
        "role": "user",
        "content": 'Can you tell me a short story about a '
            'cats and a dogs than 50 words and aimed for a 6 year old?'
      })
    ], maxToken: 200, model: ChatModel.gptTurbo);

    final response = await openAI.onChatCompletion(request: request);
    return response;
  }
}
