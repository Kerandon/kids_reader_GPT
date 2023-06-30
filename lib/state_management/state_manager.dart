import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppState {
  final String topicDragged;
  final Map<int, String> placedTopics;
  final List<String> story;

  AppState(
      {required this.topicDragged,
      required this.placedTopics,
      required this.story});

  AppState copyWith({
    String? topicDragged,
    Map<int, String>? placedTopics,
    List<String>? story,
  }) {
    return AppState(
      topicDragged: topicDragged ?? this.topicDragged,
      placedTopics: placedTopics ?? this.placedTopics,
      story: story ?? this.story,
    );
  }
}

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier(AppState state) : super(state);

  void setTopicDragged({required String topic}) {
    state = state.copyWith(topicDragged: topic);
  }

  void addPlacedTopics({required Map<int, String> topics}) {
    state = state.copyWith(
      placedTopics: Map<int, String>.from(state.placedTopics)..addAll(topics),
    );
  }

  void setStory({required List<String> story}) {
    print('story is set ${story} and ${story.length}');
    state = state.copyWith(story: story.toList());


  }
}

final appProvider = StateNotifierProvider<AppStateNotifier, AppState>(
  (ref) => AppStateNotifier(
    AppState(topicDragged: "", placedTopics: {}, story: []),
  ),
);
