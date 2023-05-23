import 'package:flutter/material.dart';
import 'package:kids_reader_gpt/configs/constants.dart';
import 'package:kids_reader_gpt/pages/home_page/topic_cards/topic_landing_tile.dart';

import 'story_button/story_button.dart';
import 'topic_cards/topic_card_main.dart';
import '../../data/topics.dart';

class HomePage   extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(kAppName,
              style: Theme.of(context).textTheme.headlineSmall,
          ),
          centerTitle: true,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final biggest = constraints.biggest;
            return Column(
            children: [
              Container(
                color: Colors.red,
                height: biggest.height * 0.40,
                child: Center(
                  child: SizedBox(
                    height: biggest.height * 0.35,
                    width: biggest.width,
                    child: ListView.builder(
                      itemCount: topics.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            TopicCardMain(topic: topics[index],),)
                  ),
                ),
              ),
              Container(
                color: Colors.green,
                height: size.height * 0.30,
                width: size.width,
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                        (index) {
                      if (index % 2 == 0) {
                        return TopicLandingTile(index); // Original child container
                      } else {
                        return Icon(Icons.add); // Plus icon
                      }
                    },
                  ).expand(
                        (widget) => [
                      widget,
                      SizedBox(width: 10), // Adjust the spacing between containers and plus icons
                    ],
                  ).toList(),
                )



              ),
              Padding(
                padding: EdgeInsets.all(size.height * 0.01),
                child: StoryButton(),
              )
            ],
          );
          },
        ),
      ),
    );
  }
}
