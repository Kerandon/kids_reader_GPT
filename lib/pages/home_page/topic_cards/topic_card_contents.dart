
import 'package:flutter/material.dart';
import 'package:kids_reader_gpt/models/topic_model.dart';

import '../../../configs/constants.dart';

class TopicContents extends StatelessWidget {
  const TopicContents({
    super.key,
    required this.topic,
    this.addShadow = false,
  });

  final TopicModel topic;
  final bool addShadow;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * kTopicWidth,
      height: size.height * kTopicHeight,
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: Colors.amber,
            boxShadow: [
              if(addShadow)...[
              const BoxShadow(color: Colors.black38, blurRadius: 3.0, offset: Offset(3,3))
            ],]
          ),
          child: Column(
            children: [
              Expanded(child: Image.asset('assets/images/topics/mermaid.jpg')),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(size.width * 0.03),
                  child: Center(child: Text(topic.name)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
