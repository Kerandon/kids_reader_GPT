import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppState {
  final String topicDragged;
  final Map<int, String> placedTopics;

  AppState({required this.topicDragged, required this.placedTopics});

  AppState copyWith({String? topicDragged, Map<int, String>? placedTopics}) {
    return AppState(topicDragged: topicDragged ?? this.topicDragged,
    placedTopics: placedTopics ?? this.placedTopics,
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

}

final appProvider = StateNotifierProvider<AppStateNotifier,
    AppState>((ref) => AppStateNotifier(AppState(topicDragged: "",
    placedTopics: {}),),);