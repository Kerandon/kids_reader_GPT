
import 'package:flutter/material.dart';

import '../../../configs/constants.dart';

class TopicCardContents extends StatelessWidget {
  const TopicCardContents({
    super.key,
    required this.topic,
    this.addShadow = false,
  });

  final String topic;
  final bool addShadow;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kBorderRadius),
          color: Colors.amber,
          boxShadow: [
            if(addShadow)...[
            BoxShadow(color: Colors.black38, blurRadius: 3.0, offset: Offset(3,3))
          ],]
        ),
        width: size.width * kTopicWidth,
        height: size.height * kTopicHeight,
        child: Column(
          children: [
            Expanded(child: Image.asset('assets/images/topics/mermaid.jpg')),
            Padding(
              padding: EdgeInsets.all(size.width * 0.03),
              child: Center(child: Text(topic)),
            ),
          ],
        ),
      ),
    );
  }
}
