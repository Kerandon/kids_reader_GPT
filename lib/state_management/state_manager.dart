import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/topic_model.dart';

class AppState {
  final List<TopicModel> topicModels;
  final List<String> story;

  AppState({
    required this.story,
    required this.topicModels,
  });

  AppState copyWith({
    List<String>? story,
    List<TopicModel>? topicModels,
  }) {
    return AppState(
      story: story ?? this.story,
      topicModels: topicModels ?? this.topicModels,
    );
  }
}

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier(AppState state) : super(state);

  void setTopics({required List<TopicModel> topics}) {
    state = state.copyWith(topicModels: topics);
  }

  void updateTopic(TopicModel model) {
    List<TopicModel> models = state.topicModels;

    int index = models.indexWhere((m) => m.name == model.name);

    if (index != -1) {
      models[index] = model;
    }

    //print('models  IS ${models[index].name} ${models[index].droppedOffset}');

    state = state.copyWith(topicModels: models);
  }

  void setStory({required List<String> story}) {
    state = state.copyWith(story: story.toList());
  }
}

final appProvider = StateNotifierProvider<AppStateNotifier, AppState>(
  (ref) => AppStateNotifier(
    AppState(
      story: [],
      topicModels: [],
    ),
  ),
);
