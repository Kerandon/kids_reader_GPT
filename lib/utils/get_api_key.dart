import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

OpenAI initOpenAI() {
  String apiKey = dotenv.get('API_KEY');
  return OpenAI.instance.build(
      token: apiKey,
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 15)),
      enableLog: true);
}
