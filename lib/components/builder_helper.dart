import 'package:flutter/material.dart';
import 'package:kids_reader_gpt/pages/story_page/story_page.dart';

class LoadingHelper extends StatelessWidget {
  const LoadingHelper(
      {required this.future, required this.onComplete, Key? key})
      : super(key: key);

  final Future<dynamic> future;
  final Function(dynamic) onComplete;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('HAS DATA');
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                onComplete.call(snapshot.data);
            });

          }

          return Center(child: CircularProgressIndicator());
        });
  }
}
