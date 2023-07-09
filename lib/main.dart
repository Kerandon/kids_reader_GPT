import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kids_reader_gpt/configs/constants.dart';
import 'package:kids_reader_gpt/configs/theme/theme_data.dart';
import 'package:kids_reader_gpt/pages/selection/selection_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kids_reader_gpt/utils/get_api_key.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  await dotenv.load(fileName: ".env");
  runApp(const KidsReaderGPT());
}

class KidsReaderGPT extends StatefulWidget {
  const KidsReaderGPT({Key? key}) : super(key: key);

  @override
  State<KidsReaderGPT> createState() => _KidsReaderGPTState();
}

class _KidsReaderGPTState extends State<KidsReaderGPT> {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        title: kAppName,
        home: SelectionPage(),
      ),
    );
  }
}

class TEST extends StatefulWidget {
  const TEST({Key? key}) : super(key: key);

  @override
  State<TEST> createState() => _TESTState();
}

class _TESTState extends State<TEST> {
  late final Future _getImage;

  @override
  void initState() {
    _getImage = _generateImageFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make Image'),
      ),
      body: FutureBuilder(
          future: _getImage,
          builder: (context, snapshot) {

            if(snapshot.hasData) {
              final image = snapshot.data as GenImgResponse;
              return Center(
                child: Container(
                  width: 200,
                  height: 200,

                  decoration: BoxDecoration(
                    color: Colors.red,

                    image: DecorationImage(
                      image: NetworkImage(image.data!.first!.url!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }else return Container(color: Colors.green,);
    }
    ));
  }
}
Future<GenImgResponse> _generateImageFuture() async {
  const prompt = "snow white & dinosaur cartoon";

  final request = GenerateImage(prompt, 1,size: ImageSize.size256,
      responseFormat: Format.url);
  final response = await initOpenAI().generateImage(request);
  print("img url :${response?.data?.last?.url}");
  return response!;
}