class StorySelection {
  final List<String> topic;
  final List<String> characters;
  final List<String> theme;

  const StorySelection({
    this.topic = const [],
    this.characters = const [],
    this.theme = const [],
  });

  StorySelection copyWith({
    List<String>? topics,
    List<String>? characters,
    List<String>? theme,
  }) {
    return StorySelection(
      topic: topics ?? topic,
      characters: characters ?? this.characters,
      theme: theme ?? this.theme,
    );
  }
}
