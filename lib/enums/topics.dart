enum Topics {
  animals,
  fairyTales,
  beasts,
  superHeroes,
}

extension TopicsExtension on Topics {
  String get toText {
    switch (this) {
      case Topics.animals:
        return "Animals";
      case Topics.fairyTales:
        return "Fairy tales";
      case Topics.beasts:
        return "Beasts";
      case Topics.superHeroes:
        return "Super heroes";
      default:
        return "";
    }
  }
}