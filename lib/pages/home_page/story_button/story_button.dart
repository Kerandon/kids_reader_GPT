import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kids_reader_gpt/components/builder_helper.dart';
import 'package:kids_reader_gpt/configs/constants.dart';
import 'package:kids_reader_gpt/state_management/state_manager.dart';

import '../../../animations/bounce_animation.dart';
import '../../story_page/story_page.dart';

class StoryButton extends ConsumerStatefulWidget {
  const StoryButton({
    super.key,
  });

  @override
  ConsumerState<StoryButton> createState() => _StoryButtonState();
}

class _StoryButtonState extends ConsumerState<StoryButton> {
  late final _openAI;

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
    final size = MediaQuery
        .of(context)
        .size;
    final notifier = ref.read(appProvider.notifier);
    return Bounce(
      child: SizedBox(
          width: size.width * 0.50,
          height: size.height * 0.12,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kBorderRadius))),
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => 
                    LoadingHelper(future: chatComplete(_openAI),
                    onComplete: (payload){
                      final result = payload as ChatCTResponse;
                      print(result.choices.toString());

                      final text = result.choices.last.message!.content;

                      notifier.setStory(story: text.split(" "));

                      Navigator.of(context).push(MaterialPageRoute(builder: (context)
                      => StoryPage()
                      ));


                    },
                    )));
              },
              child: Text('Make a story!'))
      ),
    );
  }

  Future<ChatCTResponse?> chatComplete(OpenAI openAI) async {
    final request = ChatCompleteText(messages: [
      Map.of({
        "role": "user",
        "content": 'Can you tell me a short story about a '
            'cat less than 50 words and aimed for a 6 year old?'
      })
    ], maxToken: 200, model: ChatModel.gptTurbo);

    final response = await openAI.onChatCompletion(request: request);
    return response;
  }
}
