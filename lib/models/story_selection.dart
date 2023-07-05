class StorySelection {
  final List<String> topics;
  final List<String> characters;
  final List<String> theme;

  const StorySelection({
    this.topics = const [],
    this.characters = const [],
    this.theme = const [],
  });

  StorySelection copyWith({
    List<String>? topics,
    List<String>? characters,
    List<String>? theme,
  }) {
    return StorySelection(
      topics: topics ?? this.topics,
      characters: characters ?? this.characters,
      theme: theme ?? this.theme,
    );
  }
}

