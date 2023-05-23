import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

void chatComplete({required OpenAI openAI, required String message}) async {


  final request = ChatCompleteText(messages: [
    Map.of({"role": "user", "content": 'Hello!'})
  ], maxToken: 200, model: ChatModel.gptTurbo0301);

  final response = await openAI.onChatCompletion(request: request);
  for (var element in response!.choices) {
    print("data -> ${element.message?.content}");
  }


}