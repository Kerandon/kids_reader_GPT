
import 'package:flutter/material.dart';
import 'package:kids_reader_gpt/configs/constants.dart';

import '../../../animations/bounce_animation.dart';
import '../../story_page/story_page.dart';

class StoryButton extends StatelessWidget {
  const StoryButton({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Bounce(

      child: SizedBox(
        width: size.width * 0.50,
        height: size.height * 0.12,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kBorderRadius)
          )
          ),
            onPressed: () =>
                Navigator.of(context).push(MaterialPageRoute(builder: (context)
                => StoryPage())),
            child: Text('Make a story!')),
      ),
    );
  }
}

