import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kids_reader_gpt/enums/story_stage.dart';
import '../models/story_selection.dart';
import '../models/topic_model.dart';

class AppState {
  final StoryStage storyStage;
  final StorySelection storySelection;
  final List<TopicModel> topicModels;
  final List<String> story;

  AppState({
    required this.storyStage,
    required this.storySelection,
    required this.topicModels,
    required this.story,
  });

  AppState copyWith(
      {StoryStage? storyStage,
      StorySelection? storySelection,
      List<TopicModel>? topicModels,
      List<String>? story}) {
    return AppState(
      storyStage: storyStage ?? this.storyStage,
      storySelection: storySelection ?? this.storySelection,
      topicModels: topicModels ?? this.topicModels,
      story: story ?? this.story,
    );
  }
}

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier(AppState state) : super(state);

  void setStoryStage(StoryStage stage) {
    state = state.copyWith(storyStage: stage);
  }

  void setStorySelection(StorySelection selection) {
    state = state.copyWith(storySelection: selection);
  }

  void setTopics({required List<TopicModel> topics}) {
    state = state.copyWith(topicModels: topics);
  }

  void updateTopic(TopicModel model) {
    List<TopicModel> models = state.topicModels;

    int index = models.indexWhere((m) => m.character == model.character);

    if (index != -1) {
      models[index] = model;
    }

    state = state.copyWith(topicModels: models);
  }

  void setStory({required List<String> story}) {
    state = state.copyWith(story: story.toList());
  }

  void reset(){
    state = state.copyWith(storyStage: StoryStage.topics, storySelection:
    const StorySelection(), story: []);
  }
}

final appProvider = StateNotifierProvider<AppStateNotifier, AppState>(
  (ref) => AppStateNotifier(
    AppState(
      storyStage: StoryStage.topics,
      storySelection: const StorySelection(),
      story: [],
      topicModels: [],
    ),
  ),
);
