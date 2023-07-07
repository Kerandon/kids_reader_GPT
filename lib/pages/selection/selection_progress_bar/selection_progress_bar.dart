import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kids_reader_gpt/enums/story_stage.dart';
import 'package:kids_reader_gpt/pages/selection/selection_progress_bar/progress_marker.dart';

import '../../../state_management/state_manager.dart';

class SelectionProgressBar extends ConsumerWidget {
  const SelectionProgressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final biggest = constraints.biggest;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
            (index) {
              bool isSelected = false;
              if (index == 0) {
                isSelected = true;
              }
              if (state.storyStage == StoryStage.character) {
                if (index <= 2) {
                  isSelected = true;
                }
              }
              if (state.storyStage == StoryStage.theme) {
                if (index <= 5) {
                  isSelected = true;
                }
              }

              int position = 1;
              if(index == 0){
                position = 1;
              }else if(index == 2){
                position = 2;
              }else if(index == 4){
                position = 3;
              }
              return index % 2 != 0
                  ? Container(
                width: biggest.width * 0.20,
                      height: biggest.height * 0.05,
                      color: isSelected ? Colors.amber : Colors.grey,
                    )
                  : ProgressMarker(position, isSelected);
            },
          ),
        );
      },
    );
  }
}
