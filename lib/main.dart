import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kids_reader_gpt/configs/constants.dart';
import 'package:kids_reader_gpt/configs/theme/theme_data.dart';
import 'package:kids_reader_gpt/pages/home_page/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
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
    return MaterialApp(
      theme: appTheme,
        title: kAppName,
        home: ProviderScope(child: const HomePage())

    );
  }
}